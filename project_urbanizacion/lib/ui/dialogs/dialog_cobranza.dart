import 'package:flutter/material.dart';
import 'package:project_urbanizacion/datatable/gc0020cob_datasource.dart';
import 'package:project_urbanizacion/providers/fundraising_provider.dart';
import 'package:project_urbanizacion/style/palette.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future<void> showDialogCobranza(
    BuildContext context, FundraisingProvider provider) async {
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
                    "DETALLE DE COBRANZA",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(thickness: 1),
              ],
            ),
            content: Container(
              height: 300,
              width: 650,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: SfDataGridTheme(
                data: SfDataGridThemeData(headerColor: Palette.azulMarino),
                child: SfDataGrid(
                    headerRowHeight: 30,
                    rowHeight: 40,
                    source: Gc0020CobDTS(context, provider),
                    allowEditing: true,
                    navigationMode: GridNavigationMode.cell,
                    selectionMode: SelectionMode.single,
                    allowExpandCollapseGroup: true,
                    columns: [
                      GridColumn(
                          columnName: '1-cedula',
                          allowEditing: false,
                          columnWidthMode: ColumnWidthMode.fitByCellValue,
                          label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1.5),
                              alignment: Alignment.center,
                              child: Text(
                                'IDENTIFICACION'.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))),
                      GridColumn(
                          columnName: '2-titulo',
                          columnWidthMode: ColumnWidthMode.fill,
                          label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1.5),
                              alignment: Alignment.center,
                              child: Text(
                                'TITULO'.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))),
                      GridColumn(
                          columnName: '3-valor',
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              alignment: Alignment.center,
                              child: Text(
                                'VALOR'.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))),
                      GridColumn(
                          columnName: '4-recaudado',
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              alignment: Alignment.center,
                              child: Text(
                                'ABONADO'.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))),
                      GridColumn(
                          columnName: '5-pendiente',
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              alignment: Alignment.center,
                              child: Text(
                                'PENDIENTE'.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))),
                      GridColumn(
                          columnName: '6-acciones',
                          width: 40,
                          allowEditing: false,
                          label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              alignment: Alignment.center,
                              child: Text(
                                ''.toUpperCase(),
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
                onPressed: () {},
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
