import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaController extends ChangeNotifier {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> marcadores = {};
  CameraPosition posicaoCamera =
      const CameraPosition(target: LatLng(-23.562436, -46.655005), zoom: 18);

  bool shouldMoveCamera = true;

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> movimentarCamera() async {
    if (shouldMoveCamera) {
      try {
        final GoogleMapController googleMapController = await _controller.future;
        await googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(posicaoCamera),
        );
        shouldMoveCamera = false;
      } catch (e) {
        log('Erro ao movimentar a câmera: $e');
      }
    }
  }

  Future<void> getLatLng(double lat, double lng) async {
    final LatLng latLng = LatLng(lat, lng);
    log(latLng.toString());

    final Marker marcador = Marker(
      markerId: MarkerId("marcador-${latLng.latitude}-${latLng.longitude}"),
      position: latLng,
      infoWindow: const InfoWindow(title: 'titulo'),
    );

    marcadores.add(marcador);
    posicaoCamera = CameraPosition(target: latLng, zoom: 18);
    shouldMoveCamera = true; // Adiciona esta linha para garantir que a câmera se mova
    await movimentarCamera();

    notifyListeners();
  }
}
