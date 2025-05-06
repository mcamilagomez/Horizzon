//Acá es hacer el fetch para obetener master
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/recommended.dart';
import 'package:http/http.dart' as http;
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/master.dart'; // Asegúrate de tener el parser
import 'api_constants.dart';

class RemoteDataSource {
  /// ✅ Generar hash
  Future<String> generateHash() async {
    final response = await http.get(Uri.parse(ApiConstants.generateHash));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['hash'];
    } else {
      throw Exception('Error generando hash');
    }
  }

  /// ✅ Añadir feedback
  Future<void> addFeedback(FeedbackbyUser feedback, int eventId) async {
    final body = {
      "userId": feedback.userId,
      "eventId": eventId,
      "stars": feedback.stars,
      "comment": feedback.comment,
    };

    final response = await http.post(
      Uri.parse(ApiConstants.addFeedback),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al agregar feedback');
    }
  }

  /// ✅ Reducir available_seats
  Future<int> decrementAvailableSeats(int eventId) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.decrementSeat}/$eventId/decrement-seat'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['available_seats'];
    } else {
      throw Exception('Error al reducir cupo');
    }
  }

  /// ✅ Aumentar available_seats
  Future<int> incrementAvailableSeats(int eventId) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.incrementSeat}/$eventId/increment-seat'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['available_seats'];
    } else {
      throw Exception('Error al aumentar cupo');
    }
  }

  /// ✅ Obtener full-data
  Future<Master> getFullData() async {
    final response = await http.get(Uri.parse(ApiConstants.fullData));
    if (response.statusCode != 200) {
      throw Exception('Error al obtener datos');
    }
    final List decoded = json.decode(response.body);
    // Aquí necesitas tener un parser para convertir el JSON completo a tu entidad `Master`
    // Ejemplo:
    return Master.fromJson(decoded); // Implementa `fromJson` en tu entidad
  }

  /// 🔁 Obtener recomendados desde la API
  Future<List<Recommended>> getRecommended() async {
    final response = await http.get(Uri.parse(ApiConstants.recommended));
    if (response.statusCode != 200) {
      throw Exception("Error al obtener recomendados");
    }

    final List<dynamic> data = json.decode(response.body);
    return data.map((id) => Recommended(id: id)).toList();
  }
}
