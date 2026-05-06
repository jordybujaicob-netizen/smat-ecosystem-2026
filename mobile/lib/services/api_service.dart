import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:8000";

  Future crearEstacion(String nombre, String ubicacion) async {
    final token = await AuthService().getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/estaciones/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'nombre': nombre, 'ubicacion': ubicacion}),
    );
    return response.statusCode == 200;
  }
}