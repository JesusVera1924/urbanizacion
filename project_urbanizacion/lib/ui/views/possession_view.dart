// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/providers/bach_provider.dart';
import 'package:project_urbanizacion/providers/possession_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/ui/components/white_card.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_acep_canc.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_terreno.dart';
import 'package:project_urbanizacion/utils/date_formatter.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';
import 'package:project_urbanizacion/utils/util_view.dart';
import 'package:provider/provider.dart';

class PossessionView extends StatefulWidget {
  const PossessionView({Key? key}) : super(key: key);

  @override
  State<PossessionView> createState() => _PossessionViewState();
}

class _PossessionViewState extends State<PossessionView> {
  //PRRIMERA TARJETA CONTROLADORES
  int valueTpInit = 1;

  final fechaTxtController = TextEditingController();
  final idTxtController = TextEditingController();

  final idATxtController = TextEditingController();
  final idRTxtController = TextEditingController();
  final obsLtTxtController = TextEditingController();

  //CONTROLADOR DEL FORMULARIO
  final formkey = GlobalKey<FormState>();

  //controladores tercer tarjeta
  int valueInit = 1;

  final valTxtController = TextEditingController();
  final obsTxtController = TextEditingController();
  final encTxtController = TextEditingController();

  @override
  void initState() {
    Provider.of<PossessionProvider>(context, listen: false).getObtenerTicket();
    Provider.of<BachProvider>(context, listen: false).getObtenerTicket();
    super.initState();
  }

  @override
  void dispose() {
    fechaTxtController.dispose();
    idTxtController.dispose();
    idATxtController.dispose();
    idRTxtController.dispose();
    obsLtTxtController.dispose();
    valTxtController.dispose();
    obsTxtController.dispose();
    encTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final batchProvider = Provider.of<BachProvider>(context);
    final possessionProvider = Provider.of<PossessionProvider>(context);

    void selectDate(String cadena) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null) {
        switch (cadena) {
          case 'fecha':
            fechaTxtController.text = UtilView.dateFormatDMY(picked.toString());
            break;
          default:
        }
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: formkey,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            WhiteCard(
                title: "TRANSFERENCIA/UNIFICACION DE LOTES",
                listWidget: const [],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: Text('Numero de transferencia',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller:
                                    possessionProvider.numeroTxtController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(?:\+|-)?\d+$')),
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                style: CustomLabels.h2,
                                enabled: false,
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
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width:
                              ScreenQueries.instance.customWidth(context, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('Tipo de motivo',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              DropdownButtonFormField<int>(
                                value: valueTpInit,
                                menuMaxHeight: 230,
                                decoration: CustomInputs.boxInputDecoration3(
                                    icon: Icons.assignment_ind_rounded),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: UtilView.tipoClase
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
                                  valueTpInit = value as int;
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
                                  child: Text('Fecha documento',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller: fechaTxtController,
                                style: CustomLabels.h2,
                                decoration:
                                    CustomInputs.boxInputDecorationDatePicker(
                                        labelText: "Fecha Documento",
                                        fc: () => selectDate('fecha')),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^[0-9/]*$)')),
                                  DateFormatter()
                                ],
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return 'Por favor, introduzca una fecha';
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
                                  child: Text('Identificación',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller: idTxtController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(?:\+|-)?\d+$')),
                                  LengthLimitingTextInputFormatter(15)
                                ],
                                style: CustomLabels.h2,
                                decoration: CustomInputs.txtInputDecoration2(
                                    hint: '', icon: Icons.contacts_rounded),
                                validator: (value) {
                                  if (value == null || value.length <= 9) {
                                    return 'Por favor, introduzca una identificacion valida';
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
                )),
            WhiteCard(
                title: "INFORMACION DE LOTE",
                listWidget: [
                  TextButton(
                      onPressed: () async {
                        if (idTxtController.text != "") {
                          await showDialogAddTerreno(
                              context, batchProvider, idTxtController.text);
                        } else {
                          UtilView.messageInfo(context, "Advertencia",
                              "[Identificación]\nNo puede ir vacio");
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue), // Color del texto del botón
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors
                                  .greenAccent; // Color de overlay al pasar el mouse
                            }
                            return Colors
                                .transparent; // Si no está en estado hover, usa el color predeterminado
                          },
                        ),
                        mouseCursor: MaterialStateProperty.all<MouseCursor>(
                          SystemMouseCursors
                              .click, // Cambia el cursor al pasar sobre el botón
                        ),
                        // Otros estilos de botón
                      ),
                      child: Text('Crear Terreno',
                          style: CustomLabels.h4.copyWith(
                              decoration: TextDecoration.underline,
                              color: Colors.black)))
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: Text('# Terreno asignado',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller: idATxtController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(?:\+|-)?\d+$')),
                                  LengthLimitingTextInputFormatter(5)
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
                              ScreenQueries.instance.customWidth(context, 2.6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('Observación',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller: obsLtTxtController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^[a-zA-Z ]*$)')),
                                  LengthLimitingTextInputFormatter(50)
                                ],
                                style: CustomLabels.h2,
                                decoration: CustomInputs.txtInputDecoration2(
                                    hint: '', icon: Icons.contacts_rounded),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            WhiteCard(
                title: "INFORMACIÓN DE PAGO",
                listWidget: const [],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width:
                              ScreenQueries.instance.customWidth(context, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('Formas de pago',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              DropdownButtonFormField<int>(
                                value: valueInit,
                                menuMaxHeight: 230,
                                decoration: CustomInputs.boxInputDecoration3(
                                    icon: Icons.assignment_ind_rounded),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: UtilView.tipoPagos
                                    .map((key, value) {
                                      return MapEntry(
                                          value,
                                          DropdownMenuItem(
                                            value: key,
                                            child: Text(
                                              value,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomLabels.h3,
                                            ),
                                          ));
                                    })
                                    .values
                                    .toList(),
                                onChanged: (value) {
                                  valueInit = value as int;
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: ScreenQueries.instance.customWidth(context, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('Encargado de pago',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller: encTxtController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^[a-zA-Z ]*$)')),
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                style: CustomLabels.h2,
                                decoration: CustomInputs.txtInputDecoration2(
                                    hint: '', icon: Icons.person),
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
                                  child: Text('Valor Pagado',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller: valTxtController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(?:\+|-)?\d+$')),
                                  LengthLimitingTextInputFormatter(5),
                                ],
                                style: CustomLabels.h2,
                                decoration: CustomInputs.txtInputDecoration2(
                                    hint: '', icon: Icons.contacts_rounded),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: ScreenQueries.instance.customWidth(context, 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('Observacion de pago',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller: obsTxtController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^[a-zA-Z ]*$)')),
                                  LengthLimitingTextInputFormatter(50)
                                ],
                                style: CustomLabels.h2,
                                decoration: CustomInputs.txtInputDecoration2(
                                    hint: '', icon: Icons.contacts_rounded),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: FilledButton(
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  var respuesta = await dialogAcepCanc(
                                      context,
                                      "Notificación",
                                      Text('Deseas continuar?',
                                          style: CustomLabels.h3),
                                      Icons.assignment_turned_in_rounded,
                                      Colors.green);

                                  if (respuesta) {
                                    var resp =
                                        await possessionProvider.saveReferencia(
                                            "$valueTpInit",
                                            fechaTxtController.text,
                                            idTxtController.text,
                                            idATxtController.text,
                                            idRTxtController.text,
                                            "",
                                            obsLtTxtController.text,
                                            "$valueInit",
                                            encTxtController.text,
                                            obsTxtController.text,
                                            valTxtController.text);

                                    if (resp) {
                                      formkey.currentState!.reset();
                                      UtilView.messageAccess(context,
                                          "Notificación", "Proceso Exitoso");
                                    } else {
                                      UtilView.messageError(context, "Error",
                                          "Error del formulario");
                                    }
                                  }
                                } else {
                                  UtilView.messageError(
                                      context, "Error", "Error del formulario");
                                }
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (Set<MaterialState> states) {
                                    return Colors.indigoAccent;
                                  },
                                ),
                              ),
                              child: const Text("Guardar",
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: FilledButton(
                              onPressed: () async {
                                formkey.currentState!.reset();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (Set<MaterialState> states) {
                                    return Colors.red;
                                  },
                                ),
                              ),
                              child: const Text("Cancelar",
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
