// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/providers/bach_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';
import 'package:project_urbanizacion/utils/util_view.dart';

Future<void> showDialogAddTerreno(
    BuildContext context, BachProvider provider, String cedula) async {
  final formKeyDetailtNota = GlobalKey<FormState>();
  final mdmNTxtController = TextEditingController();
  final dirNTxtController = TextEditingController();
  final mdmSTxtController = TextEditingController();
  final dirSTxtController = TextEditingController();
  final mdmETxtController = TextEditingController();
  final dirETxtController = TextEditingController();
  final mdmOTxtController = TextEditingController();
  final dirOTxtController = TextEditingController();
  final idRTxtController = TextEditingController();
  final barrioTxtController = TextEditingController();

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
                    "CRAER REFERENCIA DE TERRENO",
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
                      Wrap(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width:
                                ScreenQueries.instance.customWidth(context, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text('Medida Norte (m)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                TextFormField(
                                  controller: mdmNTxtController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(?:\+|-)?\d+$')),
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  style: CustomLabels.h2,
                                  decoration: CustomInputs.txtInputDecoration2(
                                      hint: '', icon: Icons.contacts_rounded),
                                  validator: (value) {
                                    if (value == null || value == "") {
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
                            width: ScreenQueries.instance
                                .customWidth(context, 2.8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text('Direccion Norte',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                TextFormField(
                                  controller: dirNTxtController,
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
                            width:
                                ScreenQueries.instance.customWidth(context, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text('Medida Sur (m)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                TextFormField(
                                  controller: mdmSTxtController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(?:\+|-)?\d+$')),
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  style: CustomLabels.h2,
                                  decoration: CustomInputs.txtInputDecoration2(
                                      hint: '', icon: Icons.contacts_rounded),
                                  validator: (value) {
                                    if (value == null || value == "") {
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
                            width: ScreenQueries.instance
                                .customWidth(context, 2.8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text('Direccion Sur',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                TextFormField(
                                  controller: dirSTxtController,
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
                            width:
                                ScreenQueries.instance.customWidth(context, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text('Medida Este (m)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                TextFormField(
                                  controller: mdmETxtController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(?:\+|-)?\d+$')),
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  style: CustomLabels.h2,
                                  decoration: CustomInputs.txtInputDecoration2(
                                      hint: '', icon: Icons.contacts_rounded),
                                  validator: (value) {
                                    if (value == null || value == "") {
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
                            width: ScreenQueries.instance
                                .customWidth(context, 2.8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text('Direccion Este',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                TextFormField(
                                  controller: dirETxtController,
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
                            width:
                                ScreenQueries.instance.customWidth(context, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text('Medida Oeste (m)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                TextFormField(
                                  controller: mdmOTxtController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(?:\+|-)?\d+$')),
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  style: CustomLabels.h2,
                                  decoration: CustomInputs.txtInputDecoration2(
                                      hint: '', icon: Icons.contacts_rounded),
                                  validator: (value) {
                                    if (value == null || value == "") {
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
                            width: ScreenQueries.instance
                                .customWidth(context, 2.8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text('Direccion Oeste',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                TextFormField(
                                  controller: dirOTxtController,
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
                      Wrap(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width:
                                ScreenQueries.instance.customWidth(context, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text('# Terreno asignado',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                TextFormField(
                                  controller: provider.idATxtController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(?:\+|-)?\d+$')),
                                    LengthLimitingTextInputFormatter(5),
                                  ],
                                  style: CustomLabels.h2,
                                  decoration: CustomInputs.txtInputDecoration2(
                                      hint: '', icon: Icons.contacts_rounded),
                                  validator: (value) {
                                    if (value == null || value.length <= 4) {
                                      return 'Por favor, introduzca una identificacion valida';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width:
                                ScreenQueries.instance.customWidth(context, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text('# Terreno Regularizado',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                TextFormField(
                                  controller: idRTxtController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(?:\+|-)?\d+$')),
                                    LengthLimitingTextInputFormatter(5),
                                  ],
                                  style: CustomLabels.h2,
                                  decoration: CustomInputs.txtInputDecoration2(
                                      hint: '', icon: Icons.contacts_rounded),
                                  validator: (value) {
                                    if (value == null || value.length <= 4) {
                                      return 'Por favor, introduzca una identificacion valida';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width:
                                ScreenQueries.instance.customWidth(context, 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text('Barrio o sector',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                TextFormField(
                                  controller: barrioTxtController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'(^[a-zA-Z ]*$)')),
                                    LengthLimitingTextInputFormatter(50)
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
                onPressed: () async {
                  var resp = await provider.saveReferencia(
                      cedula,
                      mdmNTxtController.text,
                      dirNTxtController.text,
                      mdmSTxtController.text,
                      dirSTxtController.text,
                      mdmETxtController.text,
                      dirETxtController.text,
                      mdmOTxtController.text,
                      dirOTxtController.text,
                      provider.idATxtController.text,
                      idRTxtController.text,
                      barrioTxtController.text);

                  if (resp) {
                    UtilView.messageAccess(
                        context, "Notificación", "Proceso Exitoso");
                  } else {
                    UtilView.messageError(
                        context, "Error", "Error del formulario");
                  }
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
