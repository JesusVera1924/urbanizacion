// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/providers/bach_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/ui/components/white_card.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';
import 'package:project_urbanizacion/utils/util_view.dart';
import 'package:provider/provider.dart';

class BatchtView extends StatefulWidget {
  const BatchtView({Key? key}) : super(key: key);

  @override
  State<BatchtView> createState() => _BatchtViewState();
}

class _BatchtViewState extends State<BatchtView> {
  //controladores
  final idTextEditingController = TextEditingController();
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

  //CONTROLADOR DEL FORMULARIO
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    idTextEditingController.dispose();
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
    formkey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bachProvider = Provider.of<BachProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          WhiteCard(
              listWidget: const [],
              child: Row(
                children: [
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
                          controller: idTextEditingController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^(?:\+|-)?\d+$')),
                            LengthLimitingTextInputFormatter(15),
                          ],
                          enabled: bachProvider.isBloque,
                          style: CustomLabels.h2,
                          onChanged: (value) async {
                            if (value.length == 10 ||
                                value.length == 13 ||
                                value.length == 15) {
                              var resp = await bachProvider.getLote(value);

                              if (resp) {
                                idTextEditingController.text =
                                    bachProvider.obj!.secNic;
                                mdmNTxtController.text =
                                    "${bachProvider.obj!.mtnLot}";
                                dirNTxtController.text =
                                    bachProvider.obj!.dtnLot;
                                mdmSTxtController.text =
                                    "${bachProvider.obj!.mtsLot}";
                                dirSTxtController.text =
                                    bachProvider.obj!.dtsLot;
                                mdmETxtController.text =
                                    "${bachProvider.obj!.mteLot}";
                                dirETxtController.text =
                                    bachProvider.obj!.dteLot;
                                mdmOTxtController.text =
                                    "${bachProvider.obj!.mtoLot}";
                                dirOTxtController.text =
                                    bachProvider.obj!.dtoLot;
                                idATxtController.text =
                                    "${bachProvider.obj!.ntaLot}";
                                idRTxtController.text =
                                    "${bachProvider.obj!.ntrLot}";
                                barrioTxtController.text =
                                    bachProvider.obj!.bosLot;

                                bachProvider.showViewEvent();
                                UtilView.messageGeneral(
                                    context,
                                    "$value Encontado",
                                    Icons.assignment_ind,
                                    Colors.green);
                              }
                            }
                          },
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
                  if (!bachProvider.isBloque)
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: InkWell(
                            onTap: () {
                              idTextEditingController.clear();
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
                              barrioTxtController.clear();
                              bachProvider.showViewEvent();
                            },
                            child: const Icon(Icons.cancel, color: Colors.red)))
                ],
              )),
          WhiteCard(
              title: "INFORMACION DE LOTE",
              listWidget: const [],
              child: Form(
                key: formkey,
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
                          margin: const EdgeInsets.only(top: 25, left: 10),
                          child: FilledButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                var resp = await bachProvider.saveReferencia(
                                    idTextEditingController.text,
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
                                    barrioTxtController.text);

                                if (resp) {
                                  idTextEditingController.clear();
                                  formkey.currentState!.reset();
                                  UtilView.messageAccess(context,
                                      "Notificación", "Proceso Exitoso");
                                } else {
                                  UtilView.messageError(
                                      context, "Error", "Error del formulario");
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
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              backgroundColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                                  return Colors.indigoAccent;
                                },
                              ),
                            ),
                            child: Text(
                                bachProvider.isBloque
                                    ? "Guardar"
                                    : "Actualizar",
                                style: const TextStyle(fontSize: 12)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 25, left: 10),
                          child: FilledButton(
                            onPressed: () async {
                              idTextEditingController.clear();
                              formkey.currentState!.reset();
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
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
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
