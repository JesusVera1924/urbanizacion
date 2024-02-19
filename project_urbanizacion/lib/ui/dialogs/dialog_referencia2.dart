import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project_urbanizacion/datatable/referencia_fam_datasource.dart';
import 'package:project_urbanizacion/providers/habitante_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/style/palette.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';
import 'package:project_urbanizacion/utils/util_view.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future<void> dialogReferencia2(
    BuildContext context, HabitanteProvider provider) async {
  final formKeyDetailtNota = GlobalKey<FormState>();

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "NUEVAS REFERENCIAS FAMILIARES",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                        onPressed: () {
                          provider.actualizarView();
                          setState(() {});
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                              return Colors.green;
                            },
                          ),
                        ),
                        icon: Icon(
                            provider.isView
                                ? Icons.assignment
                                : Icons.assignment_add,
                            size: 20,
                            color: Colors.black),
                        label: Text(provider.isView ? "CONSULTAR" : "AGREGAR",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)))
                  ],
                ),
                const Divider(thickness: 1),
              ],
            ),
            content: provider.isView
                ? SizedBox(
                    width: 600,
                    child: Form(
                      key: formKeyDetailtNota,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                width: ScreenQueries.instance
                                    .customWidth(context, 8),
                                child: TextFormField(
                                  controller: provider.txtIdentificacion2,
                                  decoration: CustomInputs.boxInputDecoration2(
                                      label: "Identificación",
                                      icon: Icons.assignment_ind_rounded),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Campo requerido*';
                                    }
                                    return null;
                                  },
                                  style: CustomLabels.h2,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(?:\+|-)?\d+$')),
                                    LengthLimitingTextInputFormatter(15),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: TextFormField(
                                    controller: provider.txtNombre2,
                                    decoration:
                                        CustomInputs.boxInputDecoration2(
                                            label: "Nombre",
                                            icon: Icons.person),
                                    style: CustomLabels.h2,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo requerido*';
                                      }
                                      return null;
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'(^[a-zA-Z ]*$)')),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                width: ScreenQueries.instance
                                    .customWidth(context, 8),
                                child: TextFormField(
                                  controller: provider.txtTelefono,
                                  decoration: CustomInputs.boxInputDecoration2(
                                      label: "Telefono",
                                      icon: Icons.phone_android_rounded),
                                  style: CustomLabels.h2,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Campo requerido*';
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(?:\+|-)?\d+$')),
                                    LengthLimitingTextInputFormatter(15),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: TextFormField(
                                    controller: provider.txtVinculo,
                                    style: CustomLabels.h2,
                                    decoration:
                                        CustomInputs.boxInputDecoration2(
                                            label: "Ingresar Parentesco",
                                            icon: Icons.switch_account_rounded),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo requerido*';
                                      }
                                      return null;
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'(^[a-zA-Z ]*$)')),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: TextFormField(
                              controller: provider.txtCorreo,
                              decoration: CustomInputs.boxInputDecoration2(
                                  label: "Correo", icon: Icons.email),
                              validator: (value) {
                                if (!EmailValidator.validate(value ?? '')) {
                                  return 'Email no válido';
                                }
                                return null;
                              },
                              style: CustomLabels.h2,
                            ),
                          ),
                        ],
                      ),
                    ))
                : Container(
                    height: 300,
                    width: 650,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: provider.listRefFamiliares.isEmpty
                        ? Center(
                            child: Column(
                            children: [
                              SizedBox(
                                  height: 200,
                                  child: Lottie.asset('animate/caberni.json')),
                              Text(
                                'NO HAY REGISTROS A MOSTRAR',
                                style: GoogleFonts.roboto(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ))
                        : SfDataGridTheme(
                            data: SfDataGridThemeData(
                                headerColor: Palette.azulMarino),
                            child: SfDataGrid(
                                headerRowHeight: 30,
                                rowHeight: 40,
                                source: ReferenciaFamDTS(provider),
                                allowEditing: true,
                                navigationMode: GridNavigationMode.cell,
                                selectionMode: SelectionMode.single,
                                editingGestureType:
                                    EditingGestureType.doubleTap,
                                columns: [
                                  GridColumn(
                                      columnName: 'dni',
                                      allowEditing: false,
                                      columnWidthMode:
                                          ColumnWidthMode.fitByCellValue,
                                      label: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 1.5),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'DNI'.toUpperCase(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  GridColumn(
                                      columnName: 'nombre',
                                      columnWidthMode: ColumnWidthMode.fill,
                                      label: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 1.5),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'NOMBRE'.toUpperCase(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  GridColumn(
                                      columnName: 'telefono',
                                      columnWidthMode:
                                          ColumnWidthMode.fitByCellValue,
                                      label: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'TELEFONO'.toUpperCase(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  GridColumn(
                                      columnName: 'vinculo',
                                      columnWidthMode: ColumnWidthMode.fill,
                                      label: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'VINCULO'.toUpperCase(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  GridColumn(
                                      columnName: 'acciones',
                                      allowEditing: false,
                                      width: 80,
                                      label: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'ELIMINAR'.toUpperCase(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                ]),
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
                  if (provider.isUpdate) {
                    UtilView.messageAccess(
                        context, "NOTIFICACIÓN", "actualizacion correcta");
                    Navigator.of(context).pop();
                  } else {
                    if (formKeyDetailtNota.currentState!.validate()) {
                      provider.addReferenciaFamiliar();
                      UtilView.messageAccess(
                          context, "PROCESO EXITO", "Referencia  agregada");
                      Navigator.of(context).pop();
                    }
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
