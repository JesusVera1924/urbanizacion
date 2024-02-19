import 'package:flutter/material.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/providers/habitante_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Gc0032DTS extends DataGridSource {
  HabitanteProvider provider;
  List<DataGridRow> dataGridRows = [];

  Gc0032DTS(this.provider) {
    dataGridRows = provider.listHabitantes
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'dni', value: dataGridRow.secNic.trim()),
              DataGridCell<String>(
                  columnName: 'nombre', value: dataGridRow.nomNic.trim()),
              DataGridCell<Gc0032>(columnName: 'acciones', value: dataGridRow),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: <Widget>[
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4.0),
            child: Text(row.getCells()[0].value.toString())),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4.0),
            child: Text(row.getCells()[1].value.toString())),
        /*    Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
                onTap: () => provider.deleteRegistro(row.getCells()[3].value),
                child: const Icon(Icons.delete, color: Colors.red))), */
      ],
    );
  }
}
