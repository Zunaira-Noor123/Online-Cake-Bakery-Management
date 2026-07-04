@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    private static final String INSERT_ORDER = "INSERT INTO Orders (user_id, total_price, created_at) VALUES (?, ?, NOW())";
    private static final String INSERT_ORDER_ITEM = "INSERT INTO OrderItems (order_id, cake_id, quantity, price) VALUES (?, ?, ?, ?)";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve data from session
        Map<Cake, Integer> cart = (Map<Cake, Integer>) session.getAttribute("cart");
        Integer userId = (Integer) session.getAttribute("userId");

        System.out.println("DEBUG: CheckoutServlet invoked...");
        System.out.println("DEBUG: Cart = " + (cart != null ? cart.size() : "null"));
        System.out.println("DEBUG: User ID = " + userId);

        if (cart == null || cart.isEmpty() || userId == null) {
            response.sendRedirect("cart.jsp?error=invalid_cart");
            return;
        }

        double totalPrice = 0.0;

        for (Map.Entry<Cake, Integer> entry : cart.entrySet()) {
            Cake cake = entry.getKey();
            Integer quantity = entry.getValue();
            totalPrice += cake.getPrice() * quantity;
        }
        System.out.println("DEBUG: Total price = " + totalPrice);

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sweettreatsdb", "root", "zunaira_noor786")) {
            conn.setAutoCommit(false);

            try {
                // Insert order
                System.out.println("DEBUG: Placing order...");
                PreparedStatement psOrder = conn.prepareStatement(INSERT_ORDER, PreparedStatement.RETURN_GENERATED_KEYS);
                psOrder.setInt(1, userId);
                psOrder.setDouble(2, totalPrice);
                int rowsAffectedOrder = psOrder.executeUpdate();

                if (rowsAffectedOrder > 0) {
                    ResultSet rs = psOrder.getGeneratedKeys();
                    rs.next();
                    int orderId = rs.getInt(1);
                    System.out.println("DEBUG: OrderId = " + orderId);

                    // Insert order items
                    PreparedStatement psOrderItem = conn.prepareStatement(INSERT_ORDER_ITEM);
                    for (Map.Entry<Cake, Integer> entry : cart.entrySet()) {
                        Cake cake = entry.getKey();
                        Integer quantity = entry.getValue();

                        psOrderItem.setInt(1, orderId);
                        psOrderItem.setInt(2, cake.getId());
                        psOrderItem.setInt(3, quantity);
                        psOrderItem.setDouble(4, cake.getPrice());
                        System.out.println("DEBUG: Adding order item - CakeId: " + cake.getId() + ", Quantity: " + quantity);
                        psOrderItem.addBatch();
                    }
                    psOrderItem.executeBatch();

                    conn.commit();
                    session.removeAttribute("cart");
                    response.sendRedirect("order_history.jsp");
                }
            } catch (Exception e) {
                conn.rollback();
                System.out.println("ERROR during transaction: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect("cart.jsp?error=checkout_failed");
            }
        } catch (SQLException e) {
            System.out.println("ERROR: Database issue.");
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=database_error");
        }
    }
}