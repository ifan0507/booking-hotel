package com.dailycodework.lakesidehotel.request;

import java.math.BigDecimal;
import org.springframework.web.multipart.MultipartFile;
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
    private int total_guest;
    private boolean isBooked;
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
