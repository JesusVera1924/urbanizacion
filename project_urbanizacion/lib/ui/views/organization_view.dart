// ignore_for_file: use_build_context_synchronously

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/providers/committe_provider.dart';
import 'package:project_urbanizacion/providers/habitante_provider.dart';
import 'package:project_urbanizacion/providers/organization_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/ui/components/white_card.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_acep_canc.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';
import 'package:project_urbanizacion/utils/util_view.dart';
import 'package:provider/provider.dart';

class OrganizationView extends StatefulWidget {
  const OrganizationView({Key? key}) : super(key: key);

  @override
  State<OrganizationView> createState() => _OrganizationViewState();
}

class _OrganizationViewState extends State<OrganizationView> {
  //controladores de caja de textos

  //LISTA DE NOMBRES

  List<String> listFecha = [];
  String fechaInicial = "";

  //CONTROLADOR DEL FORMULARIO
  final formkey = GlobalKey<FormState>();

  //FOCUS TEXT
  late FocusNode focusIdEmpresa;
  late FocusNode focusId;
  late FocusNode focusName;
  late FocusNode focusDir;
  late FocusNode focusEmail;
  late FocusNode focusTlf;
  late FocusNode focusRepLeg;
  late FocusNode focusComite;

  //OBJETO SELECCIONADO
  Gc0032? objeto;

  @override
  void initState() {
    focusIdEmpresa = FocusNode();
    focusId = FocusNode();
    focusName = FocusNode();
    focusDir = FocusNode();
    focusEmail = FocusNode();
    focusTlf = FocusNode();
    focusRepLeg = FocusNode();
    focusComite = FocusNode();
    listFecha = UtilView.generarListaRangoAnios(2020, 2024);
    fechaInicial = listFecha[listFecha.length - 1];
    Provider.of<CommitteProvider>(context, listen: false).getRequestData();
    super.initState();
  }

  @override
  void dispose() {
    //liberacion de enfoques
    focusIdEmpresa.dispose();
    focusId.dispose();
    focusName.dispose();
    focusDir.dispose();
    focusEmail.dispose();
    focusTlf.dispose();
    focusRepLeg.dispose();
    focusComite.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habitanteProvider = Provider.of<HabitanteProvider>(context);
    final committeProvider = Provider.of<OrganizationProvider>(context);

    focusIdEmpresa.requestFocus();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          WhiteCard(
              listWidget: [
                InkWell(
                    onTap: () {},
                    child: const Icon(Icons.search, color: Colors.blueGrey))
              ],
              title: "CREAR ORGANIZACIÓN",
              child: Row(
                children: [
                  SizedBox(
                    width: ScreenQueries.instance.width(context) / 1.9,
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                width: ScreenQueries.instance
                                    .customWidth(context, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text('Cod.Empresa',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12))),
                                    TextFormField(
                                      controller:
                                          committeProvider.idETxtController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(2)
                                      ],
                                      focusNode: focusIdEmpresa,
                                      style: CustomLabels.h2,
                                      onEditingComplete: () =>
                                          focusIdEmpresa.requestFocus(),
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '',
                                              icon: Icons.contacts_rounded),
                                      validator: (value) {
                                        if (value == null || value == "") {
                                          return 'Por favor, introduzca un identificacion';
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
                                    .customWidth(context, 10),
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
                                      controller:
                                          committeProvider.idTxtController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^(?:\+|-)?\d+$')),
                                        LengthLimitingTextInputFormatter(15),
                                      ],
                                      focusNode: focusId,
                                      style: CustomLabels.h2,
                                      onEditingComplete: () =>
                                          focusName.requestFocus(),
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: '0000000000',
                                              icon: Icons.contacts_rounded),
                                      validator: (value) {
                                        if (value == null ||
                                            value.length <= 9) {
                                          return 'Por favor, introduzca un identificacion valido';
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
                                    .customWidth(context, 3.4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text('Nombre de organizacion',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12))),
                                    TextFormField(
                                      controller:
                                          committeProvider.nombreTxtController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^[a-zA-Z ]*$)')),
                                        LengthLimitingTextInputFormatter(50),
                                      ],
                                      focusNode: focusName,
                                      style: CustomLabels.h2,
                                      onEditingComplete: () =>
                                          focusDir.requestFocus(),
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: "Ingresar..",
                                              icon: Icons.person),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Por favor, introduzca un nombre';
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
                                    .customWidth(context, 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text('Dirección',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12))),
                                    TextFormField(
                                      controller: committeProvider
                                          .direccionTxtController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(50),
                                      ],
                                      focusNode: focusDir,
                                      style: CustomLabels.h2,
                                      onEditingComplete: () =>
                                          focusEmail.requestFocus(),
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: "Ingresar..",
                                              icon: Icons.directions),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Por favor, introduzca un direccion';
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
                                    .customWidth(context, 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text('Correo',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12))),
                                    TextFormField(
                                      controller:
                                          committeProvider.correoTxtController,
                                      style: CustomLabels.h2,
                                      focusNode: focusEmail,
                                      validator: (value) {
                                        if (!EmailValidator.validate(
                                            value ?? '')) {
                                          return 'Email no válido';
                                        }
                                        return null;
                                      },
                                      onEditingComplete: () => focusTlf.rect,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: "Ingresar..",
                                              icon: Icons.attach_email_rounded),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                width: ScreenQueries.instance
                                    .customWidth(context, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text('Telefono',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12))),
                                    TextFormField(
                                      controller:
                                          committeProvider.celularTxtController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^(?:\+|-)?\d+$')),
                                        LengthLimitingTextInputFormatter(15),
                                      ],
                                      style: CustomLabels.h2,
                                      focusNode: focusTlf,
                                      onEditingComplete: () =>
                                          focusRepLeg.requestFocus(),
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: "Ingresar..",
                                              icon:
                                                  Icons.phone_android_rounded),
                                      validator: (value) {
                                        if (value == null ||
                                            value.length <= 9) {
                                          return 'Por favor, introduzca un numero de telefono valido';
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
                                    .customWidth(context, 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text('Representante legal',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12))),
                                    TextFormField(
                                      controller: committeProvider
                                          .representanteTxtController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^[a-zA-Z ]*$)')),
                                        LengthLimitingTextInputFormatter(50),
                                      ],
                                      focusNode: focusRepLeg,
                                      style: CustomLabels.h2,
                                      decoration:
                                          CustomInputs.txtInputDecoration2(
                                              hint: "Ingresar..",
                                              icon: Icons.person),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Por favor, introduzca un representante';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 8),
                                height: 40,
                                width: ScreenQueries.instance
                                    .customWidth(context, 5),
                                child: CustomDropdown<Gc0032>.searchRequest(
                                  futureRequest:
                                      habitanteProvider.getRequestData,
                                  decoration: CustomDropdownDecoration(
                                      closedFillColor: Colors.grey[500],
                                      expandedFillColor: Colors.blueGrey,
                                      headerStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      hintStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      listItemStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  hintText:
                                      'Seleccionar los nombres del comite',
                                  searchHintText: "Busqueda",
                                  noResultFoundText:
                                      "No se encontro resultados",
                                  onChanged: (value) {
                                    if (committeProvider.list.length < 5) {
                                      committeProvider.agregarObjList(value);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 13, left: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FilledButton(
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      String? opt =
                                          await committeProvider.saveComite();
                                      if (opt != null) {
                                        UtilView.messageAccess(context,
                                            "Enhorabuena", "Petición exitosa");
                                      } else {
                                        UtilView.messageError(context, "Error",
                                            "Error del formulario");
                                      }
                                    } else {
                                      UtilView.messageError(context, "Error",
                                          "Error del formulario");
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                      (Set<MaterialState> states) {
                                        return Colors.green;
                                      },
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  child: const Text('Guardar'),
                                ),
                                const SizedBox(width: 10),
                                FilledButton(
                                  onPressed: () {
                                    committeProvider.nombreTxtController
                                        .clear();
                                    committeProvider.direccionTxtController
                                        .clear();
                                    committeProvider.celularTxtController
                                        .clear();
                                    committeProvider.correoTxtController
                                        .clear();
                                    committeProvider.idTxtController.clear();
                                    committeProvider.representanteTxtController
                                        .clear();

                                    UtilView.messageGeneral(
                                        context,
                                        "Cancelado",
                                        Icons.clear_rounded,
                                        Colors.red);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                      (Set<MaterialState> states) {
                                        return Colors.redAccent;
                                      },
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  child: const Text('Cancelar'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text('LISTADO DEL COMITE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12))),
                      Container(
                          width: ScreenQueries.instance.width(context) / 5,
                          height: 230,
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: Colors.grey, width: 2.0))),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.only(left: 8),
                          child: ListView.builder(
                            itemCount: committeProvider.list.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.grey[300]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${index + 1} - ${committeProvider.list[index]}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          committeProvider
                                              .eliminarObjList(index);
                                        },
                                        child: const Icon(Icons.delete,
                                            color: Colors.red))
                                  ],
                                ),
                              );
                            },
                          )),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
