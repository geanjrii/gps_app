import 'dart:async';

import 'package:gps_app/domain_layer/firebase_repository_imp.dart';

class HomeController {
  final StreamController<Map<String, dynamic>> _controller = StreamController<Map<String, dynamic>>.broadcast();
  final FirebaseRepository  _firebaseService = FirebaseRepository();

  Stream<Map<String, dynamic>> get posStream => _controller.stream;

  HomeController() {
    _adicionarListenerViagens();
  }

  void _adicionarListenerViagens() {
    _firebaseService.getLocStream().listen((dados) {
      _controller.add(dados);
    });
  }

  void dispose() {
    _controller.close();
  }
}
