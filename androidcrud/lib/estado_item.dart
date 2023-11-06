import 'package:flutter/material.dart';
import 'models/estadoModel.dart';

class EstadoItem extends StatelessWidget {
  final EstadoModel model;
  final void Function(EstadoModel model) onDelete; // Utiliza 'model' en lugar de 'estado'

  EstadoItem({
    required this.model, // Usa 'model' en lugar de 'estado'
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.nombre),
      subtitle: Text(model.descripcion),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          onDelete(model); // Usa 'model' en lugar de 'estado' aquí
        },
      ),
    );
  }
}
