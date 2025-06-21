package com.dailycodework.lakesidehotel.request;

import java.math.BigDecimal;
import java.sql.Blob;

import org.springframework.web.multipart.MultipartFile;

import com.dailycodework.lakesidehotel.model.Aminiti;

import jakarta.persistence.Lob;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter

public class RoomRequest {
    private String roomCode;
    private String roomType;
    private String roomName;
    private BigDecimal roomPrice;
    private boolean isBooked = false;
    @Lob
    private String roomDescription;

    MultipartFile photo;

    private boolean ac;
    private boolean tv;
    private boolean miniBar;
    private boolean balcony;
    private boolean jacuzzi;
    private boolean kitchen;
}
