import 'dart:convert';

class EstadoModel {
  final int id; // Cambiar a 'int'
  final String nombre;
  final String descripcion;

  EstadoModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory EstadoModel.fromJson(Map<String, dynamic> json) {
    return EstadoModel(
      id: json['id'] as int, // Interpretar 'id' como 'int'
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}
