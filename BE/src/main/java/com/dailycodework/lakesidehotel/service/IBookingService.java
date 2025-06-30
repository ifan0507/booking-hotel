package com.dailycodework.lakesidehotel.service;

import com.dailycodework.lakesidehotel.model.BookedRoom;
import com.dailycodework.lakesidehotel.response.BookingResponse;

import java.util.List;
import java.util.Map;

/**
 * @author Simpson Alfred
 */

public interface IBookingService {
    Map<String, String> cancelBooking(Long bookingId);

    Map<String, String> checkOutBooking(Long roomId);

    List<BookedRoom> getAllBookingsByRoomId(Long roomId);

    BookingResponse saveBooking(Long roomId, BookedRoom bookingRequest);

    BookedRoom findByBookingConfirmationCode(String confirmationCode);

    List<BookedRoom> getAllBookings();

    List<BookedRoom> getBookingsByUserEmail(String email);
}
