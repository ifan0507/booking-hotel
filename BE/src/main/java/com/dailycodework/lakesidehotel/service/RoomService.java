package com.dailycodework.lakesidehotel.service;

import com.dailycodework.lakesidehotel.exception.InternalServerException;
import com.dailycodework.lakesidehotel.exception.ResourceNotFoundException;
import com.dailycodework.lakesidehotel.model.Room;
import com.dailycodework.lakesidehotel.repository.RoomRepository;
import com.dailycodework.lakesidehotel.request.RoomRequest;

import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.sql.rowset.serial.SerialBlob;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Blob;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * @author Simpson Alfred
 */

@Service
@RequiredArgsConstructor
public class RoomService implements IRoomService {
    private final RoomRepository roomRepository;

    @Override
    public Room addNewRoom(RoomRequest roomRequest) throws SQLException, IOException {
        Room room = new Room();
        room.setRoomCode(roomRequest.getRoomCode());
        room.setRoomType(roomRequest.getRoomType());
        room.setRoomName(roomRequest.getRoomName());
        room.setRoomDescription(roomRequest.getRoomDescription());
        room.setRoomPrice(roomRequest.getRoomPrice());
        room.setTotal_guest(roomRequest.getTotal_guest());
        room.setAc(roomRequest.isAc());
        room.setTv(roomRequest.isTv());
        room.setMiniBar(roomRequest.isMiniBar());
        room.setBalcony(roomRequest.isBalcony());
        room.setJacuzzi(roomRequest.isJacuzzi());
        room.setKitchen(roomRequest.isKitchen());
        if (!roomRequest.getPhoto().isEmpty()) {
            byte[] photoBytes = roomRequest.getPhoto().getBytes();
            Blob photoBlob = new SerialBlob(photoBytes);
            room.setPhoto(photoBlob);
        }

        return roomRepository.save(room);
    }

    @Override
    public List<String> getAllRoomTypes() {
        return roomRepository.findDistinctRoomTypes();
    }

    @Override
    public List<Room> getAllRooms() {
        return roomRepository.findAll();
    }

    @Override
    public byte[] getRoomPhotoByRoomId(Long roomId) throws SQLException {
        Optional<Room> theRoom = roomRepository.findById(roomId);
        if (theRoom.isEmpty()) {
            throw new ResourceNotFoundException("Sorry, Room not found!");
        }
        Blob photoBlob = theRoom.get().getPhoto();
        if (photoBlob != null) {
            return photoBlob.getBytes(1, (int) photoBlob.length());
        }
        return null;
    }

    @Override
    public void deleteRoom(Long roomId) {
        Optional<Room> theRoom = roomRepository.findById(roomId);
        if (theRoom.isPresent()) {
            roomRepository.deleteById(roomId);
        }
    }

    @Override
    public Room updateRoom(Long roomId, RoomRequest roomRequest, byte[] photoBytes) {
        Room room = roomRepository.findById(roomId).get();

        if (room == null) {
            throw new InternalServerException("Fail updating room");
        }
        room.setRoomCode(roomRequest.getRoomCode());
        room.setRoomType(roomRequest.getRoomType());
        room.setRoomName(roomRequest.getRoomName());
        room.setRoomDescription(roomRequest.getRoomDescription());
        room.setRoomPrice(roomRequest.getRoomPrice());
        room.setTotal_guest(roomRequest.getTotal_guest());
        room.setBooked(roomRequest.isBooked());
        room.setAc(roomRequest.isAc());
        room.setTv(roomRequest.isTv());
        room.setMiniBar(roomRequest.isMiniBar());
        room.setBalcony(roomRequest.isBalcony());
        room.setJacuzzi(roomRequest.isJacuzzi());
        room.setKitchen(roomRequest.isKitchen());
        if (photoBytes != null && photoBytes.length > 0) {
            try {
                room.setPhoto(new SerialBlob(photoBytes));
            } catch (SQLException ex) {
                throw new InternalServerException("Fail updating room");
            }
        }

        return roomRepository.save(room);
    }

    @Override
    public Optional<Room> getRoomById(Long roomId) {
        return Optional.of(roomRepository.findById(roomId).get());
    }

    @Override
    public List<Room> getAvailableRooms(LocalDate checkInDate, LocalDate checkOutDate, String roomType) {
        return roomRepository.findAvailableRoomsByDatesAndType(checkInDate, checkOutDate, roomType);
    }

    @Override
    public List<Room> getByRoomType(String roomType) {
        return roomRepository.findByRoomType(roomType);
    }
}
