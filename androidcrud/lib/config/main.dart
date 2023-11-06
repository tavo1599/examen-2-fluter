import 'package:flutter/material.dart';
import 'package:untitled/EstadoPagoList.dart';
import 'package:untitled/EstadoEditAdd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const EstadoPagoList(),
        '/add-estado': (context) => const EstadoEditAdd(),
        '/edit-estado': (context) => const EstadoEditAdd(),
      },
    );
  }
}
