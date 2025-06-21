package com.dailycodework.lakesidehotel.response;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.tomcat.util.codec.binary.Base64;

import com.dailycodework.lakesidehotel.model.Aminiti;

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
    private String photo;

    @Lob
    private String roomDescription;

    private Aminiti aminiti;
    private List<BookingResponse> bookings;

    public RoomResponse(Long id, String roomCode, String roomName, String roomType, BigDecimal roomPrice,
            String roomDescripton, Aminiti aminiti) {
        this.id = id;
        this.roomCode = roomCode;
        this.roomType = roomType;
        this.roomName = roomName;
        this.roomDescription = roomDescripton;
        this.roomPrice = roomPrice;
        this.aminiti = aminiti;
    }

    public RoomResponse(Long id, String roomType, BigDecimal roomPrice, boolean isBooked,
            byte[] photoBytes, List<BookingResponse> bookings) {
        this.id = id;
        this.roomType = roomType;
        this.roomPrice = roomPrice;
        this.isBooked = isBooked;
        this.photo = photoBytes != null ? Base64.encodeBase64String(photoBytes) : null;
        this.bookings = bookings;
    }

}
