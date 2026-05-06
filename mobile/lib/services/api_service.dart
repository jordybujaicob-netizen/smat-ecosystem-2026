import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/estacion.dart';
import 'auth_service.dart';

class ApiService {
  final String baseUrl = "http://localhost:8000";

  Future<List<Estacion>> fetchEstaciones() async {
    final token = await AuthService().getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/estaciones/'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Estacion.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar estaciones');
    }
  }

  // FIJATE AQUÍ: Se llama createEstacion
  Future<bool> createEstacion(String nombre, String ubicacion) async {
    final token = await AuthService().getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/estaciones/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'nombre': nombre, 'ubicacion': ubicacion}),
    );
    return response.statusCode == 201;
  }
}