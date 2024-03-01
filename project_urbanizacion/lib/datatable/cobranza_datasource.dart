// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_urbanizacion/model/http/cobranza.dart';
import 'package:project_urbanizacion/providers/fundraising_provider.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_cobranza.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CobranzaDTS extends DataGridSource {
  final BuildContext context;
  final FundraisingProvider provider;
  List<DataGridRow> _dataGridRows = [];

  CobranzaDTS(this.context, this.provider) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows = provider.list.map<DataGridRow>((Cobranza team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: '1-titulo', value: team.titulo),
        DataGridCell<String>(columnName: '2-subtitulo', value: team.subtitulo),
        DataGridCell<String>(columnName: '3-cuota', value: "${team.couta}"),
        DataGridCell<double>(columnName: '4-total', value: team.total),
        DataGridCell<double>(
            columnName: '5-porcentaje',
            value: ((team.total / (team.contar * team.couta))) * 100),
        DataGridCell<Cobranza>(columnName: '6-acciones', value: team)
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
        height: 15,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: FAProgressBar(
            currentValue: 100.0 - row.getCells()[4].value,
            size: 25,
            maxValue: 100,
            changeColorValue: 100,
            changeProgressColor: Colors.green,
            backgroundColor: Colors.grey,
            progressColor: Colors.lightBlue,
            animatedDuration: const Duration(milliseconds: 1000),
            direction: Axis.horizontal,
            verticalDirection: VerticalDirection.up,
            displayText: '%',
            formatValueFixed: 1),
      ),
      InkWell(
          onTap: () async {
            await provider.getListDet(row.getCells()[5].value.movimiento);
            await showDialogCobranza(context, provider);
          },
          child: const Tooltip(
              message: "DETALLE", child: Icon(Icons.assignment_add)))
    ];

    return list;
  }
}
