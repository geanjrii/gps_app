import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gps_app/feature_layer/home_page/home_view.dart';
import 'package:gps_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/* 

flutter pub add cloud_firestore geolocator google_maps_flutter geocoding

 */