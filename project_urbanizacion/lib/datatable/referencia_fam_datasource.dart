import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/model/gc0032c.dart';
import 'package:project_urbanizacion/providers/habitante_provider.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';

import 'package:collection/collection.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReferenciaFamDTS extends DataGridSource {
  HabitanteProvider provider;
  List<DataGridRow> dataGridRows = [];
  int index = 0;
  TextEditingController editingController = TextEditingController();
  dynamic newCellValue;

  ReferenciaFamDTS(this.provider) {
    dataGridRows = provider.listRefFamiliares.map<DataGridRow>((dataGridRow) {
      index++;
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'dni', value: dataGridRow.secIru.trim()),
        DataGridCell<String>(
            columnName: 'nombre', value: dataGridRow.nomIru.trim()),
        DataGridCell<String>(columnName: 'telefono', value: dataGridRow.tmvIru),
        DataGridCell<String>(columnName: 'vinculo', value: dataGridRow.vinIru),
        DataGridCell<Gc0032C>(columnName: 'acciones', value: dataGridRow),
        DataGridCell<int>(columnName: 'index', value: index),
      ]);
    }).toList();
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
            child: Text(row.getCells()[0].value.toString(),
                style: CustomLabels.h4)),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4.0),
            child: Text(row.getCells()[1].value.toString(),
                style: CustomLabels.h4)),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4.0),
            child: Text(row.getCells()[2].value.toString(),
                style: CustomLabels.h4)),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4.0),
            child: Text(row.getCells()[3].value.toString(),
                style: CustomLabels.h4)),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
                onTap: () {
                  provider.deleteRegistroFamiliares(row.getCells()[4].value);
                  dataGridRows.removeAt(row.getCells()[5].value - 1);
                  notifyDataSourceListeners();
                },
                child: const Icon(Icons.delete, color: Colors.red))),
      ],
    );
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    newCellValue = null;

    return _buildTextFieldWidget(displayText, column, submitCell);
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column) async {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == 'nombre') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'nombre', value: newCellValue);
      for (var e in provider.listRefFamiliares) {
        if (e.secIru ==
            dataGridRows[dataRowIndex].getCells()[0].value.toString()) {
          e.nomIru = newCellValue;
        }
      }
    } else if (column.columnName == 'telefono') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'telefono', value: newCellValue);
      for (var e in provider.listRefFamiliares) {
        if (e.secIru ==
            dataGridRows[dataRowIndex].getCells()[0].value.toString()) {
          e.tmvIru = newCellValue;
        }
      }
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'vinculo', value: newCellValue);
      for (var e in provider.listRefFamiliares) {
        if (e.secIru ==
            dataGridRows[dataRowIndex].getCells()[0].value.toString()) {
          e.vinIru = newCellValue;
        }
      }
    }
  }

  RegExp _getRegExp(String columnName) {
    return columnName == 'telefono' ? RegExp('[0-9]') : RegExp('[a-zA-Z ]');
  }

  Widget _buildTextFieldWidget(
      String displayText, GridColumn column, CellSubmit submitCell) {
    final RegExp regExp = _getRegExp(column.columnName);

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: TextAlign.left,
        autocorrect: false,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
        style: CustomLabels.h4,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(regExp)
        ],
        onChanged: (String value) {
          if (value.isNotEmpty) {
            newCellValue = value;
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          submitCell();
        },
      ),
    );
  }
}
