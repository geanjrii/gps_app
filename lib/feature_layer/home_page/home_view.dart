import 'package:flutter/material.dart';
import 'package:gps_app/home_page/home_controller.dart';
import 'package:gps_app/mapa/mapa_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _homeController = HomeController();

  @override
  void dispose() {
    _homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gps Esp Mapa"),
      ),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: _homeController.posStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Carregando...'),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados'));
          } else if (snapshot.hasData) {
            final dados = snapshot.data!;
            final lat = double.parse(dados["Latitude"].toString());
            final lng = double.parse(dados["Longitude"].toString());
            return Mapa(latitude: lat, longitude: lng);
          } else {
            return const Center(child: Text('Nenhum dado disponível'));
          }
        },
      ),
    );
  }
}
