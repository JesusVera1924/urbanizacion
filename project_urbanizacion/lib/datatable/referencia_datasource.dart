import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';
import 'package:project_urbanizacion/model/gc0032a.dart';
import 'package:project_urbanizacion/providers/habitante_provider.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/utils/util_view.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReferenciaDTS extends DataGridSource {
  HabitanteProvider provider;
  List<DataGridRow> dataGridRows = [];
  TextEditingController editingController = TextEditingController();
  dynamic newCellValue;
  bool isDatePickerVisible = false;
  int x = 0;

  ReferenciaDTS(this.provider) {
    dataGridRows = provider.listRef.map<DataGridRow>((dataGridRow) {
      x++;
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'dni', value: dataGridRow.secRdh.trim()),
        DataGridCell<String>(
            columnName: 'nombre', value: dataGridRow.nomRdh.trim()),
        DataGridCell<String>(
            columnName: 'fecha',
            value: UtilView.convertDateToString(dataGridRow.fncRdh)),
        DataGridCell<Gc0032A>(columnName: 'acciones', value: dataGridRow),
        DataGridCell<int>(columnName: 'index', value: x),
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
            child: Text(
              row.getCells()[0].value.toString(),
              style: CustomLabels.h4,
            )),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4.0),
            child: Text(
              row.getCells()[1].value.toString(),
              style: CustomLabels.h4,
            )),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4.0),
            child: Text(
              row.getCells()[2].value.toString(),
              style: CustomLabels.h4,
            )),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
                onTap: () {
                  provider.deleteRegistro(row.getCells()[3].value);
                  dataGridRows.removeAt(row.getCells()[4].value - 1);
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

    if (column.columnName == 'fecha') {
      return _buildDateTimePicker(displayText, submitCell);
    } else {
      return _buildTextFieldWidget(displayText, column, submitCell);
    }
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

    if (column.columnName == 'fecha') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(
              columnName: 'fecha',
              value: UtilView.convertDateToString(newCellValue));

      for (var e in provider.listRef) {
        if (e.secRdh == dataGridRows[dataRowIndex].getCells()[0].value.toString()) {
          e.fncRdh = newCellValue;
        }
      }
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'nombre', value: newCellValue);
      for (var e in provider.listRef) {
        if (e.secRdh == dataGridRows[dataRowIndex].getCells()[0].value.toString()) {
          e.nomRdh = newCellValue;
        }
      }
    }
  }

  RegExp _getRegExp(String columnName) {
    return columnName == 'dni' ? RegExp('[0-9]') : RegExp('[a-zA-Z ]');
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

  /// Building a [DatePicker] for datetime column.
  Widget _buildDateTimePicker(String displayText, CellSubmit submitCell) {
    final DateTime selectedDate = UtilView.convertStringToDate(displayText);
    final DateTime firstDate = DateTime.parse('1999-01-01');
    final DateTime lastDate = DateTime.parse('2024-02-10');

    //displayText = DateFormat('MM/dd/yyyy').format(DateTime.parse(displayText));
    return Builder(
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Focus(
            autofocus: true,
            focusNode: FocusNode()
              ..addListener(() async {
                if (!isDatePickerVisible) {
                  isDatePickerVisible = true;
                  await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: firstDate,
                      lastDate: lastDate,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: Theme.of(context),
                          child: child!,
                        );
                      }).then((DateTime? value) {
                    newCellValue = value;

                    /// Call [CellSubmit] callback to fire the canSubmitCell and
                    /// onCellSubmit to commit the new value in single place.
                    submitCell();
                    isDatePickerVisible = false;
                  });
                }
              }),
            child: Text(
              displayText,
              textAlign: TextAlign.right,
              style: CustomLabels.h4,
            ),
          ),
        );
      },
    );
  }
}
