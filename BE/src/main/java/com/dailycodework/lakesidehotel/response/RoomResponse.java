package com.dailycodework.lakesidehotel.response;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.tomcat.util.codec.binary.Base64;

import jakarta.persistence.Lob;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author Simpson Alfred
 */
@Data
@NoArgsConstructor
public class RoomResponse {
    private Long id;
    private String roomCode;
    private String roomName;
    private String roomType;
    private BigDecimal roomPrice;
    private boolean isBooked;
    private boolean ac = false;
    private boolean tv = false;
    private boolean miniBar = false;
    private boolean balcony = false;
    private boolean jacuzzi = false;
    private boolean kitchen = false;
    private String photo;

    @Lob
    private String roomDescription;

    private List<BookingResponse> bookings;

    public RoomResponse(Long id, String roomCode, String roomName, String roomType, BigDecimal roomPrice,
            boolean isBooked,
            String roomDescription, boolean ac, boolean tv, boolean miniBar, boolean balcony, boolean jacuzzi,
            boolean kitchen) {
        this.id = id;
        this.roomCode = roomCode;
        this.roomType = roomType;
        this.roomName = roomName;
        this.roomDescription = roomDescription;
        this.roomPrice = roomPrice;
        this.isBooked = isBooked;
        this.ac = ac;
        this.tv = tv;
        this.miniBar = miniBar;
        this.balcony = balcony;
        this.jacuzzi = jacuzzi;
        this.kitchen = kitchen;
    }

    public RoomResponse(Long id, String roomCode, String roomName, String roomType, BigDecimal roomPrice,
            boolean isBooked, boolean ac, boolean tv,
            boolean miniBar, boolean balcony, boolean jacuzzi, boolean kitchen,
            byte[] photoBytes, List<BookingResponse> bookings) {
        this.id = id;
        this.roomCode = roomCode;
        this.roomName = roomName;
        this.roomType = roomType;
        this.roomPrice = roomPrice;
        this.isBooked = isBooked;
        this.photo = photoBytes != null ? Base64.encodeBase64String(photoBytes) : null;
        this.bookings = bookings;
        this.ac = ac;
        this.tv = tv;
        this.miniBar = miniBar;
        this.balcony = balcony;
        this.jacuzzi = jacuzzi;
        this.kitchen = kitchen;
    }

}
