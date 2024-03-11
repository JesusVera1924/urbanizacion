// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/providers/bach_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/ui/components/white_card.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_acep_canc.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_lotes.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_maps.dart';
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

  final idRTxtController = TextEditingController();
  final barrioTxtController = TextEditingController();
  final coordenadaTxtController = TextEditingController();

  //CONTROLADOR DEL FORMULARIO
  final formkey = GlobalKey<FormState>();
  //Enfoques de navegacion entre cajas
  late FocusNode focusId;
  late FocusNode focusMdmN;
  late FocusNode focusDirN;
  late FocusNode focusMdmS;
  late FocusNode focusDirS;
  late FocusNode focusMdmE;
  late FocusNode focusDirE;
  late FocusNode focusMdmO;
  late FocusNode focusDirO;
  late FocusNode focusIdTa;
  late FocusNode focusIdTr;
  late FocusNode focusBarrio;
  late FocusNode focusCordenada;

  @override
  void initState() {
    focusId = FocusNode();
    focusMdmN = FocusNode();
    focusDirN = FocusNode();
    focusMdmS = FocusNode();
    focusDirS = FocusNode();
    focusMdmE = FocusNode();
    focusDirE = FocusNode();
    focusMdmO = FocusNode();
    focusDirO = FocusNode();
    focusIdTa = FocusNode();
    focusIdTr = FocusNode();
    focusBarrio = FocusNode();
    focusCordenada = FocusNode();
    Provider.of<BachProvider>(context, listen: false).getObtenerTicket();
    super.initState();
  }

  @override
  void dispose() {
    //LIBERACION DE ENFOQUES
    focusId.dispose();
    focusMdmN.dispose();
    focusDirN.dispose();
    focusMdmS.dispose();
    focusDirS.dispose();
    focusMdmE.dispose();
    focusDirE.dispose();
    focusMdmO.dispose();
    focusDirO.dispose();
    focusIdTa.dispose();
    focusIdTr.dispose();
    focusBarrio.dispose();
    focusCordenada.dispose();
    //LIBERACION DE CONTROLADORES
    idTextEditingController.dispose();
    mdmNTxtController.dispose();
    dirNTxtController.dispose();
    mdmSTxtController.dispose();
    dirSTxtController.dispose();
    mdmETxtController.dispose();
    dirETxtController.dispose();
    mdmOTxtController.dispose();
    dirOTxtController.dispose();
    idRTxtController.dispose();
    barrioTxtController.dispose();
    coordenadaTxtController.dispose();
    formkey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bachProvider = Provider.of<BachProvider>(context);
    focusId.requestFocus();

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
                          focusNode: focusId,
                          onChanged: (value) async {
                            if (value.length == 10 ||
                                value.length == 13 ||
                                value.length == 15) {
                              var resp = await bachProvider.getLoteList(value);

                              if (resp) {
                                bachProvider.obj = await showDialogSelectLotes(
                                    context, bachProvider.listObj);
                                if (bachProvider.obj != null) {
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
                                  bachProvider.idATxtController.text =
                                      "${bachProvider.obj!.ntaLot}";
                                  idRTxtController.text =
                                      "${bachProvider.obj!.ntrLot}";
                                  barrioTxtController.text =
                                      bachProvider.obj!.bosLot;
                                  coordenadaTxtController.text =
                                      bachProvider.obj!.gpsLot;

                                  await bachProvider
                                      .getObtenerImgs(bachProvider.obj!.vtiLot);

                                  await bachProvider.showViewEvent();
                                  UtilView.messageGeneral(
                                      context,
                                      "$value Encontado",
                                      Icons.assignment_ind,
                                      Colors.green);
                                } else {
                                  idTextEditingController.clear();
                                }
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
                              bachProvider.idATxtController.clear();
                              idRTxtController.clear();
                              coordenadaTxtController.clear();
                              barrioTxtController.clear();
                              bachProvider.nameImg1 = "";
                              bachProvider.nameImg2 = "";
                              bachProvider.listImg1 = null;
                              bachProvider.listImg2 = null;
                              bachProvider.showViewEvent();
                            },
                            child:
                                const Icon(Icons.cancel, color: Colors.red))),
                  if (!bachProvider.isBloque) const Spacer(flex: 1),
                  if (!bachProvider.isBloque)
                    SizedBox(
                      width: 300,
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text('Datos del contribuyente',
                              style: CustomLabels.h4.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)), // Contenido del card
                          subtitle: Text(
                              "Nombres: ${bachProvider.habitante!.nomNic}"
                                  .toUpperCase(),
                              style: CustomLabels.h4
                                  .copyWith(fontWeight: FontWeight.bold)),
                          contentPadding: const EdgeInsets.all(1),
                          leading: const Icon(Icons.star,
                              size: 20), // Icono a la izquierda del título
                        ),
                      ),
                    )
                ],
              )),
          Row(
            children: [
              Expanded(
                child: WhiteCard(
                    title: "INFORMACION DE LOTE",
                    listWidget: const [],
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: ScreenQueries.instance
                                    .customWidth(context, 10),
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
                                      controller: bachProvider.idATxtController,
                                      focusNode: focusIdTa,
                                      style: CustomLabels.h2,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '',
                                              icon: Icons.contacts_rounded),
                                      enabled: false,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: ScreenQueries.instance
                                    .customWidth(context, 3.8),
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
                                      focusNode: focusIdTr,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '',
                                              icon: Icons.contacts_rounded),
                                      validator: (value) {
                                        if (value == null ||
                                            value.length <= 4) {
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
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: ScreenQueries.instance
                                    .customWidth(context, 10),
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
                                      focusNode: focusMdmN,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^(?:\+|-)?\d+$')),
                                        LengthLimitingTextInputFormatter(6),
                                      ],
                                      style: CustomLabels.h2,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '',
                                              icon: Icons.contacts_rounded),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: ScreenQueries.instance
                                    .customWidth(context, 3.8),
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
                                      focusNode: focusDirN,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^[a-zA-Z ]*$)')),
                                        LengthLimitingTextInputFormatter(50),
                                      ],
                                      style: CustomLabels.h2,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '',
                                              icon: Icons.contacts_rounded),
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
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: ScreenQueries.instance
                                    .customWidth(context, 10),
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
                                      focusNode: focusMdmS,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^(?:\+|-)?\d+$')),
                                        LengthLimitingTextInputFormatter(6),
                                      ],
                                      style: CustomLabels.h2,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '',
                                              icon: Icons.contacts_rounded),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: ScreenQueries.instance
                                    .customWidth(context, 3.8),
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
                                      focusNode: focusDirS,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^[a-zA-Z ]*$)')),
                                        LengthLimitingTextInputFormatter(50),
                                      ],
                                      style: CustomLabels.h2,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '',
                                              icon: Icons.contacts_rounded),
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
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: ScreenQueries.instance
                                    .customWidth(context, 10),
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
                                      focusNode: focusMdmE,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^(?:\+|-)?\d+$')),
                                        LengthLimitingTextInputFormatter(6),
                                      ],
                                      style: CustomLabels.h2,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '',
                                              icon: Icons.contacts_rounded),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: ScreenQueries.instance
                                    .customWidth(context, 3.8),
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
                                      focusNode: focusDirE,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^[a-zA-Z ]*$)')),
                                        LengthLimitingTextInputFormatter(50),
                                      ],
                                      style: CustomLabels.h2,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '',
                                              icon: Icons.contacts_rounded),
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
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: ScreenQueries.instance
                                    .customWidth(context, 10),
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
                                      focusNode: focusMdmO,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^(?:\+|-)?\d+$')),
                                        LengthLimitingTextInputFormatter(6),
                                      ],
                                      style: CustomLabels.h2,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '',
                                              icon: Icons.contacts_rounded),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: ScreenQueries.instance
                                    .customWidth(context, 3.8),
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
                                      focusNode: focusDirO,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^[a-zA-Z ]*$)')),
                                        LengthLimitingTextInputFormatter(50),
                                      ],
                                      style: CustomLabels.h2,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '',
                                              icon: Icons.contacts_rounded),
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
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: ScreenQueries.instance
                                    .customWidth(context, 5.5),
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
                                      focusNode: focusBarrio,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^[a-zA-Z ]*$)')),
                                        LengthLimitingTextInputFormatter(50)
                                      ],
                                      style: CustomLabels.h2,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '',
                                              icon: Icons.contacts_rounded),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                width: ScreenQueries.instance
                                    .customWidth(context, 5.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text('Coordena del lote',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12))),
                                    TextFormField(
                                      controller: coordenadaTxtController,
                                      focusNode: focusCordenada,
                                      style: CustomLabels.h2,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^[0-9.,-]*$)')),
                                        LengthLimitingTextInputFormatter(25),
                                      ],
                                      decoration: CustomInputs
                                          .boxInputDecorationIconAdd(
                                              icon: Icons.location_on_sharp,
                                              mensaje:
                                                  "Seleccionar coordenadas",
                                              fc: () async {
                                                String x = await showDialogMaps(
                                                    context);
                                                coordenadaTxtController.text =
                                                    x;
                                              }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 28, left: 10, bottom: 25),
                                child: FilledButton(
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      var opt = await dialogAcepCanc(
                                          context,
                                          "Notificación",
                                          Text('Deseas continuar?',
                                              style: CustomLabels.h3),
                                          Icons.assignment_turned_in_rounded,
                                          Colors.green);

                                      if (opt) {
                                        var resp =
                                            await bachProvider.saveReferencia(
                                                idTextEditingController.text,
                                                mdmNTxtController.text,
                                                dirNTxtController.text,
                                                mdmSTxtController.text,
                                                dirSTxtController.text,
                                                mdmETxtController.text,
                                                dirETxtController.text,
                                                mdmOTxtController.text,
                                                dirOTxtController.text,
                                                bachProvider
                                                    .idATxtController.text,
                                                idRTxtController.text,
                                                barrioTxtController.text,
                                                coordenadaTxtController.text);

                                        if (resp) {
                                          idTextEditingController.clear();
                                          mdmNTxtController.clear();
                                          dirNTxtController.clear();
                                          mdmSTxtController.clear();
                                          dirSTxtController.clear();
                                          mdmETxtController.clear();
                                          dirETxtController.clear();
                                          mdmOTxtController.clear();
                                          dirOTxtController.clear();
                                          bachProvider.idATxtController.clear();
                                          idRTxtController.clear();
                                          barrioTxtController.clear();
                                          coordenadaTxtController.clear();
                                          bachProvider.showViewEvent();
                                          UtilView.messageAccess(
                                              context,
                                              "Notificación",
                                              "Proceso Exitoso");
                                        } else {
                                          UtilView.messageError(context,
                                              "Error", "Error del formulario");
                                        }
                                      }
                                    } else {
                                      UtilView.messageError(context, "Error",
                                          "Error del formulario");
                                    }
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
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
                                margin: const EdgeInsets.only(
                                    top: 28, left: 10, bottom: 25),
                                child: FilledButton(
                                  onPressed: () async {
                                    idTextEditingController.clear();
                                    formkey.currentState!.reset();
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
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
                          )
                        ],
                      ),
                    )),
              ),
              Expanded(
                child: WhiteCard(
                    listWidget: const [],
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5)),
                          height: 200,
                          width: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Stack(
                            children: [
                              bachProvider.listImg1 != null
                                  ? Center(
                                      child: Image.memory(
                                        bachProvider.listImg1!,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : Center(
                                      child: Image.asset(
                                        'assets/no-image.jpg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                              if (bachProvider.listImg1 != null)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      bachProvider.limpiarImagen(1);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () async =>
                                await bachProvider.openFileExplorer(context, 1),
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.greenAccent;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                              mouseCursor:
                                  MaterialStateProperty.all<MouseCursor>(
                                      SystemMouseCursors.click),
                            ),
                            child: Text('SUBIR IMAGEN SATELITAL',
                                style: CustomLabels.h4.copyWith(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))),
                        const Divider(),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5)),
                          height: 200,
                          width: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Stack(
                            children: [
                              bachProvider.listImg2 != null
                                  ? Center(
                                      child: Image.memory(
                                        bachProvider.listImg2!,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : Center(
                                      child: Image.asset(
                                        'assets/no-image.jpg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                              if (bachProvider.listImg2 != null)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      bachProvider.limpiarImagen(2);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () async =>
                                await bachProvider.openFileExplorer(context, 2),
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.greenAccent;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                              mouseCursor:
                                  MaterialStateProperty.all<MouseCursor>(
                                      SystemMouseCursors.click),
                            ),
                            child: Text('SUBIR IMAGEN DEL LOTE',
                                style: CustomLabels.h4.copyWith(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))),
                        const Divider(),
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
