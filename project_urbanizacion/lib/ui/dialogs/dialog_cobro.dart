import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/providers/fundraising_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/utils/constantes.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';

Future<void> showDialogCobro(
    BuildContext context, FundraisingProvider provider) async {
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
                      onChanged: (value) {
                        setState(() => provider.selectHabitante = value);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (provider.selectHabitante != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      height: 50,
                      child: TextFormField(
                        decoration: CustomInputs.boxInputDecorationIconEvent(
                            label: "VALOR A ABONAR",
                            fc: () {},
                            icon: Icons.save),
                        style: CustomLabels.h2,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(Constantes.decimal)),
                          LengthLimitingTextInputFormatter(6),
                        ],
                      ),
                    ),
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
                onPressed: () {
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
}
