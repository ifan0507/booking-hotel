package com.dailycodework.lakesidehotel.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.time.LocalDate;

/**
 * @author Simpson Alfred
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BookingResponse {

    private Long id;

    private LocalDate bookingDate;

    private LocalDate checkInDate;

    private LocalDate checkOutDate;

    private String guestFullName;

    private String guestEmail;

    private BigInteger phone_number;

    private String bookingConfirmationCode;

    private BigDecimal total_price;

    private RoomResponse room;

    public BookingResponse(Long id, LocalDate bookingDate, LocalDate checkInDate, LocalDate checkOutDate,
            String bookingConfirmationCode, String guestFullName, String guestEmail, BigInteger phone_number,
            BigDecimal total_price) {
        this.id = id;
        this.bookingDate = bookingDate;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.bookingConfirmationCode = bookingConfirmationCode;
        this.guestFullName = guestFullName;
        this.guestEmail = guestEmail;
        this.phone_number = phone_number;
        this.total_price = total_price;
    }
}
