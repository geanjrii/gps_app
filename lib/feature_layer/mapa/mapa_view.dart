import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_app/mapa/mapa_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class Mapa extends StatefulWidget {
  final double latitude;
  final double longitude;

  const Mapa({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  late final MapaController _mapaController;

  @override
  void initState() {
    super.initState();
    _mapaController = MapaController();
    _checkLocationPermission();

    _mapaController.addListener(_listener);
    _mapaController.getLatLng(widget.latitude, widget.longitude);
  }

  @override
  void dispose() {
    _mapaController.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    setState(() {});
  }

  Future<void> _checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.location.request();
      if (status.isDenied || status.isPermanentlyDenied) {
        _showPermissionDeniedDialog();
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Denied'),
          content: Text('Location permission is required to use this feature.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: _mapaController.marcadores,
        mapType: MapType.normal,
        initialCameraPosition: _mapaController.posicaoCamera,
        onMapCreated: _mapaController.onMapCreated,
      ),
    );
  }
}
