import 'package:flutter/material.dart';
import 'package:untitled/models/estadoModel.dart';
import 'package:untitled/service/api_service.dart';

class EstadoEditAdd extends StatefulWidget {
  final EstadoModel? estado;
  const EstadoEditAdd({Key? key, this.estado}) : super(key: key);

  @override
  _EstadoEditAddState createState() => _EstadoEditAddState();
}

class _EstadoEditAddState extends State<EstadoEditAdd> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.estado?.nombre ?? '');
    _descripcionController = TextEditingController(text: widget.estado?.descripcion ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.estado == null ? 'Añadir Registro' : 'Editar Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Save or Update the state and notify the State to refresh the list
                if (widget.estado == null) {
                  final newEstado = EstadoModel(
                    nombre: _nombreController.text,
                    descripcion: _descripcionController.text,
                    id: 0,
                  );
                  final success = await APIService.saveEstado(newEstado);
                  if (success) {
                    Navigator.pop(context, true);
                  }
                } else {
                  final editedEstado = EstadoModel(
                    id: widget.estado!.id,
                    nombre: _nombreController.text,
                    descripcion: _descripcionController.text,
                  );
                  final success = await APIService.editEstado(editedEstado);
                  if (success) {
                    Navigator.pop(context, true);
                  }
                }
              },
              child: Text(widget.estado == null ? 'Añadir' : 'Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
