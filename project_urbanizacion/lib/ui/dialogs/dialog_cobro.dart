// ignore_for_file: use_build_context_synchronously

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/providers/fundraising_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/utils/constantes.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';
import 'package:project_urbanizacion/utils/util_view.dart';

Future<String> showDialogCobro(
    BuildContext context, FundraisingProvider provider, String id) async {
  TextEditingController txt = TextEditingController();
  String valueInit = "EF";
  String resp = "0";
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
                    "GENERAR COBRANZA",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(thickness: 1),
              ],
            ),
            content: Container(
              width: ScreenQueries.instance.width(context) / 3,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    height: 40,
                    child: CustomDropdown<Gc0032>.searchRequest(
                      futureRequest: provider.getRequestData,
                      decoration: CustomDropdownDecoration(
                          closedFillColor: Colors.grey[500],
                          expandedFillColor: Colors.blueGrey,
                          headerStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          hintStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          listItemStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      hintText: 'Seleccionar los nombres del comite',
                      searchHintText: "Busqueda",
                      noResultFoundText: "No se encontro resultados",
                      onChanged: (value) async {
                        setState(() => provider.selectHabitante = value);
                        bool opt = await provider.getCobranza(id);
                        if (!opt) {
                          UtilView.messageError(
                              context, "NOTIFICACIÓN", "NO ENCONTRADO");
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (provider.selectHabitante != null)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: DropdownButtonFormField<String>(
                              value: valueInit,
                              menuMaxHeight: 230,
                              decoration: CustomInputs.boxInputDecoration3(
                                  icon: Icons.monetization_on),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: UtilView.tipoOtrosPagos
                                  .map((key, value) {
                                    return MapEntry(
                                        value,
                                        DropdownMenuItem(
                                          value: key,
                                          child: Text(value,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomLabels.h3),
                                        ));
                                  })
                                  .values
                                  .toList(),
                              onChanged: (value) {
                                valueInit = value as String;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            height: 50,
                            child: TextFormField(
                              controller: txt,
                              decoration:
                                  CustomInputs.boxInputDecorationIconEvent(
                                      label: "VALOR A ABONAR",
                                      fc: () async {
                                        if (txt.text != "") {
                                          bool opt =
                                              await provider.savePass(txt.text);
                                          if (opt) {
                                            UtilView.messageAccess(
                                                context,
                                                "Notificación",
                                                "Proceso Exitoso");
                                            resp = txt.text;
                                            Navigator.of(context).pop();
                                          } else {
                                            UtilView.messageError(context,
                                                "Notificación", "Error..");
                                          }
                                        }
                                      },
                                      icon: Icons.save),
                              style: CustomLabels.h2,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(Constantes.decimal)),
                                LengthLimitingTextInputFormatter(6),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
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
  return resp;
}
