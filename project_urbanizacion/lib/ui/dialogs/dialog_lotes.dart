import 'package:flutter/material.dart';
import 'package:project_urbanizacion/model/gc0032Lot.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';

Future<Gc0032LOT?> showDialogSelectLotes(
    BuildContext context, List<Gc0032LOT> list) async {
  Gc0032LOT? respuesta;
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
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
                    "LISTA DE LOTES",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    "Se encontraron varios terrenos, Seleccione uno de los encontrados",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                ),
                Divider(thickness: 1),
              ],
            ),
            content: SizedBox(
                width: ScreenQueries.instance.width(context) / 2,
                height: ScreenQueries.instance.height(context) / 2,
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4, // Elevación del card
                      margin:
                          const EdgeInsets.all(8), // Margen alrededor del card
                      child: ListTile(
                        title: Text(
                            'Especificaciónes del lote #$index'), // Contenido del card
                        subtitle: Text(list[index].bosLot),
                        leading: const Icon(
                            Icons.star), // Icono a la izquierda del título
                        trailing: const Icon(
                            Icons.arrow_forward), // Icono a la derecha del card
                        onTap: () {
                          respuesta = list[index];
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
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
                onPressed: () => Navigator.of(context).pop(),
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
  return respuesta;
}
