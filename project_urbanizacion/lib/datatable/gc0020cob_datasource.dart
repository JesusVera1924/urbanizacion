import 'package:flutter/material.dart';
import 'package:project_urbanizacion/model/gc0020Cob.dart';
import 'package:project_urbanizacion/providers/fundraising_provider.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Gc0020CobDTS extends DataGridSource {
  final BuildContext context;
  final FundraisingProvider provider;
  List<DataGridRow> _dataGridRows = [];

  Gc0020CobDTS(this.context, this.provider) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows = provider.listDet.map<DataGridRow>((Gc0020Cob team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: '1-cedula', value: team.secNic),
        DataGridCell<String>(columnName: '2-titulo', value: team.girador),
        DataGridCell<String>(columnName: '3-valor', value: "${team.valMov}"),
        DataGridCell<String>(
            columnName: '4-recaudado', value: "${team.sdoMov}"),
        DataGridCell<String>(
            columnName: '5-pendiente', value: "${team.valMov - team.sdoMov}"),
        DataGridCell<Gc0020Cob>(columnName: '6-acciones', value: team)
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: _buildDataGridForDts(row));
  }

  List<Widget> _buildDataGridForDts(DataGridRow row) {
    List<Widget> list = [
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(4.0),
          child:
              Text(row.getCells()[0].value.toString(), style: CustomLabels.h4)),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child:
              Text(row.getCells()[1].value.toString(), style: CustomLabels.h4)),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child:
              Text(row.getCells()[2].value.toString(), style: CustomLabels.h4)),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child: Text("${row.getCells()[3].value}", style: CustomLabels.h4)),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child: Text("${row.getCells()[4].value}", style: CustomLabels.h4)),
    ];

    return list;
  }

  @override
  Widget? buildGroupCaptionCellWidget(
      RowColumnIndex rowColumnIndex, String summaryValue) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          summaryValue,
          style: CustomLabels.h3,
        ));
  }
}
