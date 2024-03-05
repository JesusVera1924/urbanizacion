import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/providers/document_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';

Future<void> showDialogAddComentario(
    BuildContext context, DocumentProvider provider) async {
  final formKeyDetailtNota = GlobalKey<FormState>();

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
                    "AGREGAR COMENTARIOS",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(thickness: 1),
              ],
            ),
            content: SizedBox(
                width: ScreenQueries.instance.width(context) / 2,
                child: Form(
                  key: formKeyDetailtNota,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: ScreenQueries.instance.customWidth(context, 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('Observación 1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12))),
                            TextFormField(
                              controller: provider.obs1TxtController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'(^[a-zA-Z ]*$)')),
                                LengthLimitingTextInputFormatter(50),
                              ],
                              style: CustomLabels.h2,
                              decoration: CustomInputs.txtInputDecoration2(
                                  hint: '', icon: Icons.contacts_rounded),
                              validator: (value) {
                                if (value == null) {
                                  return 'Por favor, introduzca un valor';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: ScreenQueries.instance.customWidth(context, 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('Observación 2',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12))),
                            TextFormField(
                              controller: provider.obs2TxtController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'(^[a-zA-Z ]*$)')),
                                LengthLimitingTextInputFormatter(50),
                              ],
                              style: CustomLabels.h2,
                              decoration: CustomInputs.txtInputDecoration2(
                                  hint: '', icon: Icons.contacts_rounded),
                              validator: (value) {
                                if (value == null) {
                                  return 'Por favor, introduzca un valor';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: ScreenQueries.instance.customWidth(context, 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('Observación 3',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12))),
                            TextFormField(
                              controller: provider.obs3TxtController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'(^[a-zA-Z ]*$)')),
                                LengthLimitingTextInputFormatter(50),
                              ],
                              style: CustomLabels.h2,
                              decoration: CustomInputs.txtInputDecoration2(
                                  hint: '', icon: Icons.contacts_rounded),
                              validator: (value) {
                                if (value == null) {
                                  return 'Por favor, introduzca un valor';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: ScreenQueries.instance.customWidth(context, 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('Observación 4',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12))),
                            TextFormField(
                              controller: provider.obs4TxtController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'(^[a-zA-Z ]*$)')),
                                LengthLimitingTextInputFormatter(50),
                              ],
                              style: CustomLabels.h2,
                              decoration: CustomInputs.txtInputDecoration2(
                                  hint: '', icon: Icons.contacts_rounded),
                              validator: (value) {
                                if (value == null) {
                                  return 'Por favor, introduzca un valor';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
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
                onPressed: () => Navigator.of(context).pop(),
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
}
