import 'package:flutter/material.dart';
import 'package:project_urbanizacion/model/http/historial.dart';
import 'package:project_urbanizacion/providers/fundraising_provider.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HistorialDTS extends DataGridSource {
  final BuildContext context;
  final FundraisingProvider provider;
  List<DataGridRow> _dataGridRows = [];

  HistorialDTS(this.context, this.provider) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows = provider.listHist.map<DataGridRow>((Historial team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(
            columnName: 'Identificación', value: team.cabecera.secNic),
        DataGridCell<String>(
            columnName: '2-titulo', value: team.cabecera.girador),
        DataGridCell<String>(
            columnName: '3-valor', value: "${team.cabecera.valMov}"),
        DataGridCell<double>(
            columnName: '4-recaudado',
            value: team.detalle.fold(0.0,
                (previousValue, element) => previousValue! + element.valMov)),
        DataGridCell<String>(
            columnName: '5-pendiente', value: "${team.cabecera.sdoMov}"),
        DataGridCell<Historial>(columnName: '6-acciones', value: team)
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
          alignment: Alignment.centerLeft,
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
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child: Text("${row.getCells()[5].value.detalle.length}",
              style: CustomLabels.h4.copyWith(fontWeight: FontWeight.bold))),
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
