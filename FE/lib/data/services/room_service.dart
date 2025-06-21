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

        print('JSON Data: $jsonData');

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
          'POST', Uri.parse('$baseUrl/rooms/add/new-room'));

      if (room.roomType != null) {
        request.fields['roomType'] = room.roomType!;
      }
      if (room.roomPrice != null) {
        request.fields['roomPrice'] = room.roomPrice.toString();
      }
      if (room.isBooked != null) {
        request.fields['isBooked'] = room.isBooked.toString();
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
        print('Room created successfully');
        return response.body;
      } else {
        print('Failed to create room. Status: ${response.statusCode}');
        print('Response: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error creating room: $e');
      return null;
    }
  }
}
