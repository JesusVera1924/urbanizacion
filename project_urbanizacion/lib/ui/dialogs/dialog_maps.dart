import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';

Future<String> showDialogMaps(BuildContext context) async {
  String resp = "";
  LatLng tappedPoint = const LatLng(-2.158294, -79.894655);
  Marker? marker;

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          void _onMapTapped(LatLng latLng) {
            // Elimina el marcador existente
            setState(() {
              marker = Marker(
                markerId: const MarkerId('1'),
                position: latLng,
                infoWindow: InfoWindow(
                  title: 'Ubicación seleccionada',
                  snippet:
                      'Latitud: ${latLng.latitude}, Longitud: ${latLng.longitude}',
                ),
                onTap: () {
                  resp = '${latLng.latitude} , ${latLng.longitude}';
                  // Acción que se realiza al tocar el marcador
                  print('Marcador tocado en $latLng');
                },
              );
            });
          }

          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "SELECCIONAR UBICACIÓN",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(thickness: 1),
                Text(
                  'Para seleccionar una ubicacion dar doble click sobre el mapa y seleccionar aceptar',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
            content: SizedBox(
                width: ScreenQueries.instance.width(context) / 2,
                height: ScreenQueries.instance.height(context) / 2,
                child: GoogleMap(
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: true,
                  mapToolbarEnabled: true,
                  fortyFiveDegreeImageryEnabled: true,
                  buildingsEnabled: true,
                  compassEnabled: true,
                  markers: marker != null ? <Marker>{marker!} : <Marker>{},
                  onTap: _onMapTapped,
                  initialCameraPosition: CameraPosition(
                    target: tappedPoint,
                    zoom: 12.0,
                  ),
                )),
            actions: [
              TextButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.black12;
                  }
                  return Colors.transparent;
                })),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold)),
              ),
              TextButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.black12;
                  }
                  return Colors.transparent;
                })),
                onPressed: () {
                  resp = "";
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
      });
  return resp;
}
