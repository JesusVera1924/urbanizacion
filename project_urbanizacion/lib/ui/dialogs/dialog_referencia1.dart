import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project_urbanizacion/datatable/referencia_datasource.dart';
import 'package:project_urbanizacion/providers/habitante_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/style/palette.dart';
import 'package:project_urbanizacion/utils/date_formatter.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';
import 'package:project_urbanizacion/utils/util_view.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future<void> dialogReferencia1(
    BuildContext context, HabitanteProvider provider) async {
  final formKeyDetailtNota = GlobalKey<FormState>();

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          void selectDate(String cadena) async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2025),
            );
            if (picked != null) {
              setState(() {
                switch (cadena) {
                  case 'fecha':
                    provider.txtFecha.text =
                        UtilView.dateFormatDMY(picked.toString());

                    break;
                  default:
                }
              });
            }
          }

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
                        "NUEVAS REFERENCIAS",
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
                        label: Text(provider.isView ? 'CONSULTAR' : "AGREGAR",
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
                                constraints: BoxConstraints(
                                    maxWidth: !ScreenQueries.instance
                                            .isMobile(context)
                                        ? ScreenQueries.instance.width2(
                                            ScreenQueries.instance
                                                .width(context),
                                            1.3)
                                        : double.infinity),
                                child: DropdownButtonFormField<int>(
                                  value: provider.selectDni,
                                  menuMaxHeight: 230,
                                  decoration: CustomInputs.boxInputDecoration2(
                                      label: "Tp identificacion",
                                      icon: Icons.person),
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
                                    provider.selectDni = value!;
                                  },
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: TextFormField(
                                    controller: provider.txtIdentificacion,
                                    decoration:
                                        CustomInputs.boxInputDecoration2(
                                            label: "Identificación",
                                            icon: Icons.person),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Ingresar identificación';
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
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: TextFormField(
                              controller: provider.txtNombre,
                              decoration: CustomInputs.boxInputDecoration2(
                                  label: "Nombre", icon: Icons.person),
                              style: CustomLabels.h2,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'(^[a-zA-Z ]*$)')),
                                LengthLimitingTextInputFormatter(50),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nombre requerido';
                                }
                                return null;
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: TextFormField(
                                    controller: provider.txtFecha,
                                    style: CustomLabels.h2,
                                    decoration: CustomInputs
                                        .boxInputDecorationDatePicker(
                                            labelText: "Fecha Nacimiento",
                                            fc: () => selectDate('fecha')),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'(^[0-9/]*$)')),
                                      DateFormatter()
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 10) {
                                        return 'Fecha Nacimiento requerido';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: DropdownButtonFormField<int>(
                                    value: provider.selectSexo,
                                    menuMaxHeight: 230,
                                    decoration:
                                        CustomInputs.boxInputDecoration2(
                                            label: "Seleccionar Sexo",
                                            icon: Icons.people_alt_sharp),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: CustomLabels.h3,
                                                ),
                                              ));
                                        })
                                        .values
                                        .toList(),
                                    onChanged: (value) {
                                      provider.selectSexo = value!;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
                : Container(
                    height: 300,
                    width: 650,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: provider.listRef.isEmpty
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
                                source: ReferenciaDTS(provider),
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
                                      columnName: 'fecha',
                                      columnWidthMode: ColumnWidthMode.fill,
                                      label: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'FECHA'.toUpperCase(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  GridColumn(
                                      columnName: 'acciones',
                                      width: 85,
                                      allowEditing: false,
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
                      provider.addReferencia();
                      provider.clearValDialog();

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
