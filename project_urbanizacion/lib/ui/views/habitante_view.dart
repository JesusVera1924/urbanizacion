// ignore_for_file: use_build_context_synchronously
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/providers/habitante_provider.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
/* import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:project_urbanizacion/style/palette.dart';
import 'package:project_urbanizacion/datatable/referencia_datasource.dart';
import 'package:project_urbanizacion/datatable/referencia_fam_datasource.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart'; */
import 'package:project_urbanizacion/ui/components/white_card.dart';
import 'package:flutter/material.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_acep_canc.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_busqueda.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_referencia1.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_referencia2.dart';
import 'package:project_urbanizacion/utils/date_formatter.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';
import 'package:email_validator/email_validator.dart';
import 'package:project_urbanizacion/utils/util_view.dart';
import 'package:provider/provider.dart';

class HabitanteView extends StatefulWidget {
  const HabitanteView({super.key});

  @override
  State<HabitanteView> createState() => _HabitanteViewState();
}

class _HabitanteViewState extends State<HabitanteView> {
  //CONTROLADORES
  final idTextEditingController = TextEditingController();
  final nombreTextEditingController = TextEditingController();
  final correoTextEditingController = TextEditingController();
  final telefonoTextEditingController = TextEditingController();
  final fechaTextEditingController = TextEditingController();
  final obsTextEditingController = TextEditingController();

  //INDICADORES COMBO
  int valueInit = 1;
  int valueCls = 1;
  int valueSx = 1;

  //KEY DEL FORM
  final formkey = GlobalKey<FormState>();

  //FOCUS TEXT
  late FocusNode focusCb1;
  late FocusNode focusNumero;
  late FocusNode focusName;
  late FocusNode focusSexo;
  late FocusNode focusTelefono;
  late FocusNode focusCorreo;
  late FocusNode focusFecha;
  late FocusNode focusClasif;
  late FocusNode focusObs;

  @override
  void initState() {
    //INIZIALIZAR VARIABLES DE FOCUS SEGUN LA DOCUMENTACION
    focusCb1 = FocusNode();
    focusNumero = FocusNode();
    focusName = FocusNode();
    focusSexo = FocusNode();
    focusTelefono = FocusNode();
    focusCorreo = FocusNode();
    focusFecha = FocusNode();
    focusClasif = FocusNode();
    focusObs = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    //LIBERACION DEL FOCUS SEGUN LA DOCUMENTACION
    focusCb1.dispose();
    focusNumero.dispose();
    focusName.dispose();
    focusSexo.dispose();
    focusTelefono.dispose();
    focusCorreo.dispose();
    focusFecha.dispose();
    focusClasif.dispose();
    focusObs.dispose();
    //LIBERACION DEL LOS CONTROLADORES SEGUN LA DOCUMENTACION
    idTextEditingController.dispose();
    nombreTextEditingController.dispose();
    correoTextEditingController.dispose();
    telefonoTextEditingController.dispose();
    fechaTextEditingController.dispose();
    obsTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habitanteProvider = Provider.of<HabitanteProvider>(context);

    //primer focus a reflejar
    focusCb1.requestFocus();

    void selectDate(String cadena) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2025),
      );
      if (picked != null) {
        switch (cadena) {
          case 'fecha':
            fechaTextEditingController.text =
                UtilView.dateFormatDMY(picked.toString());
            break;
          default:
        }
      }
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            WhiteCard(
              title: "REGISTRO DE HABITANTES".toUpperCase(),
              listWidget: [
                InkWell(
                    onTap: () async {
                      final selectGc0032 =
                          await dialogBusqueda(context, habitanteProvider);
                      if (selectGc0032 != null) {
                        valueInit = int.parse(selectGc0032.clsNic);
                        valueSx = int.parse(selectGc0032.sexNic);
                        idTextEditingController.text = selectGc0032.secNic;
                        nombreTextEditingController.text = selectGc0032.nomNic;
                        correoTextEditingController.text = selectGc0032.bznNic;
                        telefonoTextEditingController.text =
                            selectGc0032.tmvNic;
                        fechaTextEditingController.text =
                            UtilView.convertDateToString(selectGc0032.fNNic);
                        obsTextEditingController.text = selectGc0032.obsNic;
                        habitanteProvider.isUpdate = true;

                        setState(() {});
                      }
                    },
                    child: const Icon(Icons.search, color: Colors.blueGrey))
              ],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              dropdownDni,
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
                                        child: Text('Identificación',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12))),
                                    TextFormField(
                                      controller: idTextEditingController,
                                      focusNode: focusNumero,
                                      enabled: !habitanteProvider.isUpdate,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^(?:\+|-)?\d+$')),
                                        LengthLimitingTextInputFormatter(15),
                                      ],
                                      style: CustomLabels.h2,
                                      onEditingComplete: () {
                                        focusName.requestFocus();
                                      },
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
                              textFieldNombre
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Wrap(
                              children: [
                                dropdownSexo,
                                textFieldTelefono,
                                textFieldCorreo
                              ],
                            ),
                          ),
                          Wrap(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                width: ScreenQueries.instance
                                    .customWidth(context, 7.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text('Fecha Nacimiento',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12))),
                                    TextFormField(
                                      controller: fechaTextEditingController,
                                      focusNode: focusFecha,
                                      style: CustomLabels.h2,
                                      decoration: CustomInputs
                                          .boxInputDecorationDatePicker(
                                              labelText: "Fecha Nacimiento",
                                              fc: () => selectDate('fecha')),
                                      onEditingComplete: () {
                                        focusClasif.requestFocus();
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^[0-9/]*$)')),
                                        DateFormatter()
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              dropdownClasificacion,
                              Container(
                                margin: const EdgeInsets.only(top: 23),
                                child: FilledButton(
                                  onPressed: () async {
                                    habitanteProvider.isView =
                                        habitanteProvider.isUpdate
                                            ? false
                                            : true;
                                    await dialogReferencia1(
                                        context, habitanteProvider);
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                      (Set<MaterialState> states) {
                                        return Colors.indigoAccent;
                                      },
                                    ),
                                  ),
                                  child: Text(
                                      habitanteProvider.isUpdate
                                          ? "${habitanteProvider.listRef.length} Actualizar referencias"
                                          : habitanteProvider.listRef.isEmpty
                                              ? '+ Referencias'
                                              : "${habitanteProvider.listRef.length} Referencias",
                                      style: const TextStyle(fontSize: 12)),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                margin: const EdgeInsets.only(top: 23),
                                child: FilledButton(
                                  onPressed: () async {
                                    habitanteProvider.isView =
                                        habitanteProvider.isUpdate
                                            ? false
                                            : true;
                                    await dialogReferencia2(
                                        context, habitanteProvider);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                      (Set<MaterialState> states) {
                                        return Colors.indigoAccent;
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
                                  child: Text(
                                      habitanteProvider.isUpdate
                                          ? "${habitanteProvider.listRefFamiliares.length} Actualizar ref familiares"
                                          : habitanteProvider
                                                  .listRefFamiliares.isEmpty
                                              ? '+ Referencias familiares'
                                              : '${habitanteProvider.listRefFamiliares.length} Referencias familiares',
                                      style: const TextStyle(fontSize: 12)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: textFieldObs),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FilledButton(
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      String? resp;
                                      var oprtD = await dialogAcepCanc(
                                          context,
                                          "Notificación",
                                          Text('Deseas continuar?',
                                              style: CustomLabels.h3),
                                          Icons.assignment_turned_in_rounded,
                                          Colors.green);

                                      if (oprtD) {
                                        if (habitanteProvider.isUpdate) {
                                          resp = await habitanteProvider
                                              .updateHabitante(
                                                  valueInit,
                                                  idTextEditingController.text,
                                                  nombreTextEditingController
                                                      .text,
                                                  valueSx,
                                                  fechaTextEditingController
                                                      .text,
                                                  telefonoTextEditingController
                                                      .text,
                                                  correoTextEditingController
                                                      .text,
                                                  valueCls,
                                                  obsTextEditingController
                                                      .text);
                                        } else {
                                          resp = await habitanteProvider
                                              .saveHabitante(
                                                  valueInit,
                                                  idTextEditingController.text,
                                                  nombreTextEditingController
                                                      .text,
                                                  valueSx,
                                                  telefonoTextEditingController
                                                      .text,
                                                  correoTextEditingController
                                                      .text,
                                                  valueCls,
                                                  obsTextEditingController
                                                      .text);
                                        }

                                        if (resp != null) {
                                          idTextEditingController.clear();

                                          correoTextEditingController.clear();
                                          telefonoTextEditingController.clear();
                                          fechaTextEditingController.clear();
                                          obsTextEditingController.clear();

                                          UtilView.messageAccess(
                                              context,
                                              habitanteProvider.isUpdate
                                                  ? "Actualización Exitosa"
                                                  : "Guardado Exitoso",
                                              "HABITANTE: ${nombreTextEditingController.text}");
                                          nombreTextEditingController.clear();
                                          habitanteProvider.clearVal();
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
                                  child: Text(habitanteProvider.isUpdate
                                      ? "Actualizar"
                                      : 'Guardar'),
                                ),
                                const SizedBox(width: 10),
                                FilledButton(
                                  onPressed: () {
                                    idTextEditingController.clear();
                                    nombreTextEditingController.clear();
                                    correoTextEditingController.clear();
                                    telefonoTextEditingController.clear();
                                    fechaTextEditingController.clear();
                                    obsTextEditingController.clear();

                                    habitanteProvider.isUpdate = false;
                                    habitanteProvider.clearVal();

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
                      )),
                  /* VerticalDivider(thickness: 3, color: Colors.grey[600]), */
                  /*   DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          ButtonsTabBar(
                              backgroundColor: Colors.green[700],
                              unselectedBackgroundColor: Colors.blueGrey,
                              labelStyle: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                              unselectedLabelStyle:
                                  const TextStyle(color: Colors.white),
                              borderWidth: 1,
                              unselectedBorderColor: Colors.black,
                              radius: 6.0,
                              height: 36,
                              tabs: [
                                Tab(
                                    text:
                                        "Referencias: ${habitanteProvider.listRef.length} "),
                                Tab(
                                    text:
                                        'Referencias familiares: ${habitanteProvider.listRefFamiliares.length}'),
                              ]),
                          SizedBox(
                            height: 285,
                            width: ScreenQueries.instance
                                .customWidth(context, 2.9),
                            child: Expanded(
                              child: TabBarView(children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SfDataGridTheme(
                                    data: SfDataGridThemeData(
                                        headerColor: Palette.azulMarino),
                                    child: SfDataGrid(
                                        headerRowHeight: 30,
                                        rowHeight: 40,
                                        source:
                                            ReferenciaDTS(habitanteProvider),
                                        columns: [
                                          GridColumn(
                                              columnName: 'dni',
                                              columnWidthMode: ColumnWidthMode
                                                  .fitByCellValue,
                                              label: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 1.5),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'DNI'.toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                          GridColumn(
                                              columnName: 'nombre',
                                              columnWidthMode:
                                                  ColumnWidthMode.fill,
                                              label: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 1.5),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'NOMBRE'.toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                          GridColumn(
                                              columnName: 'fecha',
                                              columnWidthMode:
                                                  ColumnWidthMode.fill,
                                              label: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'FECHA'.toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                          GridColumn(
                                              columnName: 'acciones',
                                              width: 85,
                                              label: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'ACCIONES'.toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                        ]),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SfDataGridTheme(
                                    data: SfDataGridThemeData(
                                        headerColor: Palette.azulMarino),
                                    child: SfDataGrid(
                                        headerRowHeight: 30,
                                        rowHeight: 40,
                                        source:
                                            ReferenciaFamDTS(habitanteProvider),
                                        columns: [
                                          GridColumn(
                                              columnName: 'dni',
                                              columnWidthMode: ColumnWidthMode
                                                  .fitByCellValue,
                                              label: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 1.5),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'DNI'.toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                          GridColumn(
                                              columnName: 'nombre',
                                              columnWidthMode:
                                                  ColumnWidthMode.fill,
                                              label: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 1.5),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'NOMBRE'.toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                          GridColumn(
                                              columnName: 'telefono',
                                              columnWidthMode: ColumnWidthMode
                                                  .fitByCellValue,
                                              label: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'TELEFONO'.toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                          GridColumn(
                                              columnName: 'vinculo',
                                              columnWidthMode:
                                                  ColumnWidthMode.fill,
                                              label: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'VINCULO'.toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                          GridColumn(
                                              columnName: 'acciones',
                                              width: 80,
                                              label: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'ACCIONES'.toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                        ]),
                                  ),
                                ),
                              ]),
                            ),
                          )
                      
                        ],
                      ))
               */
                ],
              ),
            )
          ],
        ));
  }

  Widget get dropdownDni {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: ScreenQueries.instance.customWidth(context, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text('Tipo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          DropdownButtonFormField<int>(
            value: valueInit,
            menuMaxHeight: 230,
            focusNode: focusCb1,
            decoration: CustomInputs.boxInputDecoration3(
                icon: Icons.assignment_ind_rounded),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: UtilView.tipoIdentificacion
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
              valueInit = value!;
              focusNumero.requestFocus();
              idTextEditingController.text = "";
              idTextEditingController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: idTextEditingController.text.length);
            },
          ),
        ],
      ),
    );
  }

  Widget get textFieldNombre {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: ScreenQueries.instance.customWidth(context, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text('Nombre',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          TextFormField(
            controller: nombreTextEditingController,
            style: CustomLabels.h2,
            focusNode: focusName,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^[a-zA-Z ]*$)')),
              LengthLimitingTextInputFormatter(50),
            ],
            validator: (value) {
              if (value == null) {
                return 'Por favor, introduzca un nombre';
              }
              return null;
            },
            onEditingComplete: () {
              focusSexo.requestFocus();
            },
            decoration: CustomInputs.txtInputDecoration2(
                hint: "Ingresar..", icon: Icons.person),
          ),
        ],
      ),
    );
  }

  Widget get dropdownClasificacion {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.5),
      width: !ScreenQueries.instance.isMobile(context)
          ? ScreenQueries.instance
              .width2(ScreenQueries.instance.width(context), 2)
          : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text('Clasificación',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          DropdownButtonFormField<int>(
            value: valueCls,
            menuMaxHeight: 230,
            focusNode: focusClasif,
            decoration: CustomInputs.boxInputDecoration3(
                icon: Icons.assignment_ind_rounded),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: UtilView.tipoClasificacion
                .map((key, value) {
                  return MapEntry(
                      value,
                      DropdownMenuItem(
                        value: key,
                        child: SizedBox(
                          width: ScreenQueries.instance.width(context) < 1200
                              ? 70
                              : 140,
                          child: Text(value,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: CustomLabels.h3),
                        ),
                      ));
                })
                .values
                .toList(),
            onChanged: (value) {
              valueCls = value!;
              focusObs.requestFocus();
            },
          ),
        ],
      ),
    );
  }

  Widget get dropdownSexo {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: ScreenQueries.instance.customWidth(context, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text('Sexo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          DropdownButtonFormField<int>(
            value: valueSx,
            menuMaxHeight: 230,
            focusNode: focusSexo,
            decoration: CustomInputs.boxInputDecoration3(
                icon: Icons.assignment_ind_rounded),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: UtilView.tipoSexo
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
              valueSx = value!;
              focusTelefono.requestFocus();

              idTextEditingController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: idTextEditingController.text.length);
            },
          ),
        ],
      ),
    );
  }

  Widget get textFieldCorreo {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: ScreenQueries.instance.customWidth(context, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text('Correo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          TextFormField(
            controller: correoTextEditingController,
            style: CustomLabels.h2,
            validator: (value) {
              if (!EmailValidator.validate(value ?? '')) {
                return 'Email no válido';
              }

              return null;
            },
            focusNode: focusCorreo,
            onEditingComplete: () {
              focusFecha.requestFocus();
            },
            decoration: CustomInputs.txtInputDecoration2(
                hint: "Ingresar..", icon: Icons.attach_email_rounded),
          ),
        ],
      ),
    );
  }

  Widget get textFieldTelefono {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: ScreenQueries.instance.customWidth(context, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text('Telefono',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          TextFormField(
            controller: telefonoTextEditingController,
            focusNode: focusTelefono,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^(?:\+|-)?\d+$')),
              LengthLimitingTextInputFormatter(15),
            ],
            style: CustomLabels.h2,
            onEditingComplete: () {
              focusCorreo.requestFocus();
            },
            decoration: CustomInputs.txtInputDecoration2(
                hint: "Ingresar..", icon: Icons.phone_android_rounded),
            validator: (value) {
              if (value == null || value.length <= 9) {
                return 'Por favor, introduzca un numero de telefono valido';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget get textFieldObs {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: ScreenQueries.instance.customWidth(context, 2.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text('Observación',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          TextFormField(
            controller: obsTextEditingController,
            focusNode: focusObs,
            style: CustomLabels.h2,
            maxLines: 4,
            decoration: CustomInputs.txtInputDecoration2(
                hint: '(Opcional)', icon: Icons.assignment),
          ),
        ],
      ),
    );
  }
}
