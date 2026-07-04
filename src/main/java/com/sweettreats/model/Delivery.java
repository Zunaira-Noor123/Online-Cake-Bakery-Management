package com.sweettreats.model;

import java.sql.Timestamp;

public class Delivery {
    private int id;
    private int orderId;
    private Integer deliveryPersonId; // Nullable
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Delivery(int id, int orderId, Integer deliveryPersonId, String status, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.orderId = orderId;
        this.deliveryPersonId = deliveryPersonId;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getId() {
        return id;
    }

    public int getOrderId() {
        return orderId;
    }

    public Integer getDeliveryPersonId() {
        return deliveryPersonId;
    }

    public String getStatus() {
        return status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
}