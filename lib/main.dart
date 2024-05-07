import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
     final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
    return  MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(onPressed: ()async  {
            try{
              final Position position = await _determinePosition();
            print(position);
            }
            catch(e){
             print('Enciende la ubicacion illo');
            }
          }, child: Text('Ubicación')),
        ),
      ),
    );
  }
}


Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permisson;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Servicio de ubicación desactivado');
    }
    permisson = await Geolocator.checkPermission();
    if(permisson == LocationPermission.denied){
      permisson = await Geolocator.requestPermission();
      if(permisson == LocationPermission.denied){
        return Future.error('Permiso de ubicación denegado');
      }
    }
    if(permisson == LocationPermission.deniedForever){
      return Future.error('Permiso de ubicación denegado permanentemente');
    }

    return await Geolocator.getCurrentPosition();
}