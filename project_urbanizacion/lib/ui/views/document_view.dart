// ignore_for_file: use_build_context_synchronously

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/providers/document_provider.dart';
import 'package:project_urbanizacion/providers/habitante_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/ui/components/white_card.dart';
import 'package:project_urbanizacion/utils/date_formatter.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';
import 'package:project_urbanizacion/utils/util_view.dart';
import 'package:provider/provider.dart';

class DocumentView extends StatefulWidget {
  const DocumentView({Key? key}) : super(key: key);

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  //controladores primer tarjeta

  final idDocTxtController = TextEditingController();
  final docTFcxtController = TextEditingController();
  final idTxtController = TextEditingController();

//controladores segunda tarjeta
  final mdmNTxtController = TextEditingController();
  final dirNTxtController = TextEditingController();
  final mdmSTxtController = TextEditingController();
  final dirSTxtController = TextEditingController();
  final mdmETxtController = TextEditingController();
  final dirETxtController = TextEditingController();
  final mdmOTxtController = TextEditingController();
  final dirOTxtController = TextEditingController();
  final idATxtController = TextEditingController();
  final idRTxtController = TextEditingController();
  final barrioTxtController = TextEditingController();
  final obsLtTxtController = TextEditingController();

  //controladores tercer tarjeta
  int valueInit = 1;
  Gc0032? objeto;
  final valTxtController = TextEditingController();
  final obsTxtController = TextEditingController();

  //CONTROLADOR DEL FORMULARIO
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    idTxtController.dispose();
    idDocTxtController.dispose();
    docTFcxtController.dispose();
    mdmNTxtController.dispose();
    dirNTxtController.dispose();
    mdmSTxtController.dispose();
    dirSTxtController.dispose();
    mdmETxtController.dispose();
    dirETxtController.dispose();
    mdmOTxtController.dispose();
    dirOTxtController.dispose();
    idATxtController.dispose();
    idRTxtController.dispose();
    barrioTxtController.dispose();
    obsLtTxtController.dispose();
    valTxtController.dispose();
    obsTxtController.dispose();
    formkey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habitanteProvider = Provider.of<HabitanteProvider>(context);
    final documentProvider = Provider.of<DocumentProvider>(context);
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
            docTFcxtController.text = UtilView.dateFormatDMY(picked.toString());
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
                title: "INFORMACIÓN DE DOCUMENTO",
                listWidget: const [],
                child: Wrap(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: ScreenQueries.instance.customWidth(context, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text('Numero documento',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))),
                          TextFormField(
                            controller: idDocTxtController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^(?:\+|-)?\d+$')),
                              LengthLimitingTextInputFormatter(15)
                            ],
                            style: CustomLabels.h2,
                            decoration: CustomInputs.txtInputDecoration2(
                                hint: '',
                                icon: Icons.wallet_membership_rounded),
                            validator: (value) {
                              if (value == null || value == "") {
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
                      width: ScreenQueries.instance.customWidth(context, 10),
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
                            controller: docTFcxtController,
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
                      width: ScreenQueries.instance.customWidth(context, 10),
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
                            onChanged: (value) async {
                              if (value.length == 10 ||
                                  value.length == 13 ||
                                  value.length == 15) {
                                var resp =
                                    await documentProvider.getLote(value);

                                if (resp) {
                                  mdmNTxtController.text =
                                      "${documentProvider.obj!.mtnLot}";
                                  dirNTxtController.text =
                                      documentProvider.obj!.dtnLot;
                                  mdmSTxtController.text =
                                      "${documentProvider.obj!.mtsLot}";
                                  dirSTxtController.text =
                                      documentProvider.obj!.dtsLot;
                                  mdmETxtController.text =
                                      "${documentProvider.obj!.mteLot}";
                                  dirETxtController.text =
                                      documentProvider.obj!.dteLot;
                                  mdmOTxtController.text =
                                      "${documentProvider.obj!.mtoLot}";
                                  dirOTxtController.text =
                                      documentProvider.obj!.dtoLot;
                                  idATxtController.text =
                                      "${documentProvider.obj!.ntaLot}";
                                  idRTxtController.text =
                                      "${documentProvider.obj!.ntrLot}";
                                  barrioTxtController.text =
                                      documentProvider.obj!.bosLot;

                                  documentProvider.showViewEvent();
                                  UtilView.messageGeneral(
                                      context,
                                      "$value Encontado",
                                      Icons.assignment_ind,
                                      Colors.green);
                                }
                              }
                            },
                            style: CustomLabels.h2,
                            decoration: CustomInputs.txtInputDecoration2(
                                hint: '', icon: Icons.assignment_ind),
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
                )),
            WhiteCard(
                title: "INFORMACION DE LOTE",
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
                                  child: Text('Medida Norte (m)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller: mdmNTxtController,
                                enabled: documentProvider.isBloque,
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
                          width:
                              ScreenQueries.instance.customWidth(context, 3.5),
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
                                enabled: documentProvider.isBloque,
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
                                enabled: documentProvider.isBloque,
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
                          width:
                              ScreenQueries.instance.customWidth(context, 3.5),
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
                                enabled: documentProvider.isBloque,
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
                                enabled: documentProvider.isBloque,
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
                          width:
                              ScreenQueries.instance.customWidth(context, 3.5),
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
                                enabled: documentProvider.isBloque,
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
                                enabled: documentProvider.isBloque,
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
                          width:
                              ScreenQueries.instance.customWidth(context, 3.5),
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
                                enabled: documentProvider.isBloque,
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
                                controller: idATxtController,
                                enabled: documentProvider.isBloque,
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
                                enabled: documentProvider.isBloque,
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
                              ScreenQueries.instance.customWidth(context, 5.6),
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
                                enabled: documentProvider.isBloque,
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
                                decoration:
                                    CustomInputs.boxInputDecorationIconAdd(
                                        icon: Icons.assignment_add,
                                        mensaje: "Observación extendida",
                                        fc: () {
                                          //evento de dialogo de las demas observaciones
                                        }),
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
                                    icon: Icons.monetization_on),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: UtilView.tipoPagos
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
                                  valueInit = value as int;
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 6, right: 6, bottom: 4),
                          height: 40,
                          width: ScreenQueries.instance.customWidth(context, 6),
                          child: CustomDropdown<Gc0032>.searchRequest(
                            futureRequest: habitanteProvider.getRequestData,
                            closedHeaderPadding: const EdgeInsets.all(10),
                            decoration: CustomDropdownDecoration(
                                closedFillColor: Colors.grey[500],
                                expandedFillColor: Colors.blueGrey,
                                headerStyle: CustomLabels.h3,
                                hintStyle: CustomLabels.h3,
                                listItemStyle: CustomLabels.h3),
                            hintText: 'Seleccionar encargado del pago',
                            searchHintText: "Busqueda",
                            noResultFoundText: "No se encontro resultados",
                            onChanged: (value) {
                              objeto = value;
                            },
                            validator: (p0) {
                              if (objeto == null) {
                                return "Este campo es obligatorio";
                              }
                              return null;
                            },
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
                                      RegExp(r'^[+-]?\d*[\.,]?\d+$')),
                                  LengthLimitingTextInputFormatter(5),
                                ],
                                style: CustomLabels.h2,
                                decoration: CustomInputs.txtInputDecoration2(
                                    hint: '', icon: Icons.monetization_on),
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
                                    hint: '', icon: Icons.assignment_add),
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
                                  var resp =
                                      await documentProvider.saveReferencia(
                                          idDocTxtController.text,
                                          docTFcxtController.text,
                                          idTxtController.text,
                                          mdmNTxtController.text,
                                          dirNTxtController.text,
                                          mdmSTxtController.text,
                                          dirSTxtController.text,
                                          mdmETxtController.text,
                                          dirETxtController.text,
                                          mdmOTxtController.text,
                                          dirOTxtController.text,
                                          idATxtController.text,
                                          idRTxtController.text,
                                          obsLtTxtController.text,
                                          "$valueInit",
                                          objeto!.nomNic,
                                          obsTxtController.text,
                                          valTxtController.text);

                                  if (resp) {
                                    idDocTxtController.clear();
                                    docTFcxtController.clear();
                                    idTxtController.clear();
                                    mdmNTxtController.clear();
                                    dirNTxtController.clear();
                                    mdmSTxtController.clear();
                                    dirSTxtController.clear();
                                    mdmETxtController.clear();
                                    dirETxtController.clear();
                                    mdmOTxtController.clear();
                                    dirOTxtController.clear();
                                    idATxtController.clear();
                                    idRTxtController.clear();
                                    obsLtTxtController.clear();
                                    barrioTxtController.clear();
                                    obsTxtController.clear();
                                    valTxtController.clear();
                                    objeto = null;
                                    valueInit = 1;

                                    UtilView.messageAccess(context,
                                        "Notificación", "Proceso Exitoso");
                                  } else {
                                    UtilView.messageError(context, "Error",
                                        "Error del formulario");
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
                                idDocTxtController.clear();
                                docTFcxtController.clear();
                                idTxtController.clear();
                                mdmNTxtController.clear();
                                dirNTxtController.clear();
                                mdmSTxtController.clear();
                                dirSTxtController.clear();
                                mdmETxtController.clear();
                                dirETxtController.clear();
                                mdmOTxtController.clear();
                                dirOTxtController.clear();
                                idATxtController.clear();
                                idRTxtController.clear();
                                obsLtTxtController.clear();
                                barrioTxtController.clear();
                                obsTxtController.clear();
                                valTxtController.clear();
                                objeto = null;
                                valueInit = 1;
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
