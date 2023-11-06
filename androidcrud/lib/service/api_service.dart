import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/estadoModel.dart';

class APIService {
  static var client = http.Client();

  static Future<List<EstadoModel>> getEstados() async {
    try {
      var url = Uri.parse('http://localhost:5000/Estado');
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        List<EstadoModel> estados = data.map((e) => EstadoModel.fromJson(e)).toList();
        return estados;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<bool> saveEstado(EstadoModel estado) async {
    try {
      var url = Uri.parse('http://localhost:5000/Estado');
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(estado.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<bool> deleteEstado(int estadoId) async {
    try {
      var url = Uri.parse('http://localhost:5000/Estado/$estadoId');
      var response = await client.delete(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
  static Future<bool> editEstado(EstadoModel estado) async {
    try {
      var url = Uri.parse('http://localhost:5000/Estado/${estado.id}');
      var response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(estado.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

}
