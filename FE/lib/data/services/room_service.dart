import 'dart:convert';

import 'package:fe/core/utils/api.dart';
import 'package:fe/data/models/room.dart';
import 'package:http/http.dart' as http;

class RoomService extends Api {
  Future<List<Room>> getAllRoom() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/rooms/all-rooms'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        List<Room> rooms =
            jsonData.map((roomJson) => Room.fromJson(roomJson)).toList();

        return rooms;
      } else {
        throw Exception(
            'Failed to load rooms. Status code : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fatching rooms');
    }
  }

  Future<String?> createRoom(Room room) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/rooms/add/new-room'),
      );

      request.fields['roomCode'] = room.roomCode.toString();
      request.fields['roomType'] = room.roomType.toString();
      request.fields['roomName'] = room.roomName.toString();
      request.fields['roomDescription'] = room.roomDescription.toString();
      request.fields['roomPrice'] = room.roomPrice.toString();
      request.fields['isBooked'] = room.isBooked.toString();
      request.fields['ac'] = room.ac.toString();
      request.fields['tv'] = room.tv.toString();
      request.fields['miniBar'] = room.miniBar.toString();
      request.fields['jacuzzi'] = room.jacuzzi.toString();
      request.fields['balcony'] = room.balcony.toString();
      request.fields['kitchen'] = room.kitchen.toString();

      if (room.photoFile == null) {
        return "Photo is required";
      }

      final fileLength = await room.photoFile!.length();
      if (fileLength > 500 * 1024) {
        return "Photo size must not exceed 500KB";
      }

      if (room.photoFile != null && room.photoFile!.existsSync()) {
        var photo = await http.MultipartFile.fromPath(
          'photo',
          room.photoFile!.path,
          filename: room.photoFile!.path.split("/").last,
        );
        request.files.add(photo);
      }

      request.headers.addAll({
        ...getToken(),
      });
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return null;
      } else {
        print('[ERROR] Failed to create room. Status: ${response.statusCode}');
        print('[ERROR] Response: ${response.body}');
        return '${response.body}';
      }
    } catch (e) {
      print('[EXCEPTION] Error creating room: $e');
      return '$e';
    }
  }

  Future<String?> deleteRoom(int id) async {
    try {
      final request = await http.delete(
          Uri.parse('$baseUrl/rooms/delete/room/$id'),
          headers: getToken());

      if (request.statusCode == 200 ||
          request.statusCode == 201 ||
          request.statusCode == 204) {
        return null;
      } else {
        print('[ERROR] Response: ${request.body}');
        return '${request.body}';
      }
    } catch (e) {
      print('[EXCEPTION] Error deleting room: $e');
      return '$e';
    }
  }
}
