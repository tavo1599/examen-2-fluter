import 'package:flutter/material.dart';
import 'package:untitled/models/estadoModel.dart';
import 'package:untitled/service/api_service.dart';
import 'EstadoEditAdd.dart';
import 'estado_item.dart';

class EstadoPagoList extends StatefulWidget {
  const EstadoPagoList({Key? key});

  @override
  State<EstadoPagoList> createState() => _EstadoPagoListState();
}

class _EstadoPagoListState extends State<EstadoPagoList> {
  late Future<List<EstadoModel>> estadosFuture = APIService.getEstados();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<List<EstadoModel>>(
        future: estadosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(
              child: Text('Error fetching data'),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          EstadoItem(
                            model: snapshot.data![index],
                            onDelete: (EstadoModel model) async {
                              final success = await APIService.deleteEstado(model.id);
                              if (success) {
                                setState(() {
                                  snapshot.data!.remove(model);
                                });
                              } else {
                                // Handle delete error
                              }
                            },
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EstadoEditAdd(estado: snapshot.data![index]),
                                ),
                              );

                              if (result != null && result) {
                                setState(() {
                                  estadosFuture = APIService.getEstados();
                                });
                              }
                            },
                            child: Text('Editar'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EstadoEditAdd(estado: null),
                      ),
                    );

                    if (result != null && result) {
                      setState(() {
                        estadosFuture = APIService.getEstados();
                      });
                    }
                  },
                  child: Text('Crear Estado'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
