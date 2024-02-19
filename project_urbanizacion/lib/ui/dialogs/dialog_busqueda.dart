// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/providers/habitante_provider.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_acep_canc.dart';
import 'package:project_urbanizacion/utils/util_view.dart';

Future<Gc0032?> dialogBusqueda(
    BuildContext context, HabitanteProvider provider) async {
  Gc0032? objeto;

  Future<List<Gc0032>> getFakeRequestData(String query) async {
    return await provider.getAllSearch(query);
  }

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "BUSQUEDA DE HABITANTES",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          objeto = null;
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.cancel,
                            color: Colors.red, size: 35))
                  ],
                ),
                const Divider(thickness: 1),
              ],
            ),
            content: SizedBox(
                width: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: CustomDropdown<Gc0032>.searchRequest(
                        futureRequest: getFakeRequestData,
                        hintText: 'Seleccione uno',
                        searchHintText: "Busqueda",
                        onChanged: (value) {
                          setState(() {
                            objeto = value;
                          });
                        },
                      ),
                    ),
                    if (objeto != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return Colors.red;
                                    }
                                    return Colors.redAccent;
                                  })),
                              onPressed: () async {
                                final x = await dialogAcepCanc(
                                    context,
                                    "NOTIFICACIÓN :)",
                                    Text(
                                        'Estas seguro de eliminar el registro?',
                                        style: CustomLabels.h2),
                                    Icons.dangerous,
                                    Colors.red);
                                if (x) {
                                  String resp =
                                      await provider.deleteHabitante(objeto!);
                                  if (resp == "200-OK") {
                                    UtilView.messageAccess(
                                        context,
                                        "NOTIFICACION",
                                        "Se ha eliminado el habitante");
                                  }
                                  objeto = null;
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text('ELIMINAR',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return Colors.green;
                                    }
                                    return Colors.greenAccent;
                                  })),
                              onPressed: () async {
                                await provider
                                    .getReferencias(objeto!.secNic.trim());
                                Navigator.of(context).pop();
                              },
                              child: const Text('MODIFICAR',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      )
                  ],
                )),
          );
        });
      });

  return objeto;
}
