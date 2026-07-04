package com.sweettreats.model;

public class DeliveryPerson {
    private int id; // Unique identifier for the delivery person
    private String username; // Username of the delivery person
    private String email; // Email of the delivery person
    private String phone; // Phone number of the delivery person

    // Constructors
    public DeliveryPerson() {}

    public DeliveryPerson(int id, String username, String email, String phone) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.phone = phone;
    }

    // Getter and Setter methods
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    // Override toString() for displaying delivery person information
    @Override
    public String toString() {
        return "DeliveryPerson [id=" + id + ", username=" + username + ", email=" + email + ", phone=" + phone + "]";
    }
}