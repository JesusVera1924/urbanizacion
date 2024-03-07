import 'package:flutter/material.dart';
import 'package:project_urbanizacion/datatable/cobranza_datasource.dart';
import 'package:project_urbanizacion/providers/fundraising_provider.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/ui/components/white_card.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FundraisingView extends StatefulWidget {
  const FundraisingView({Key? key}) : super(key: key);

  @override
  State<FundraisingView> createState() => _FundraisingViewState();
}

class _FundraisingViewState extends State<FundraisingView> {
  @override
  void initState() {
    Provider.of<FundraisingProvider>(context, listen: false).getAllList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FundraisingProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          WhiteCard(
              listWidget: [
                ToggleSwitch(
                  initialLabelIndex: provider.index,
                  totalSwitches: 3,
                  fontSize: 12,
                  minWidth: 100,
                  minHeight: 30,
                  labels: const ['Todos', 'Pendientes', 'Cerrados'],
                  onToggle: (index) {
                    provider.index = index!;
                    provider.getAllListFiltar();
                  },
                ),
              ],
              title: "REALIZAR COBRANZA",
              child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                      headerColor: Colors.blueGrey,
                      selectionColor:
                          Theme.of(context).primaryColor.withOpacity(0.3),
                      filterIconColor: Colors.black,
                      filterIconHoverColor: Colors.white),
                  child: SfDataGrid(
                      columnWidthMode: ColumnWidthMode.none,
                      headerRowHeight: 40,
                      rowHeight: 40,
                      source: CobranzaDTS(context, provider),
                      columns: _buildDataGridForSize(context)))),
        ],
      ),
    );
  }
}

List<GridColumn> _buildDataGridForSize(BuildContext context) {
  List<GridColumn> list = [
    GridColumn(
      columnName: '1-titulo',
      columnWidthMode: ColumnWidthMode.fill,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('MOTIVO',
            style: CustomLabels.h2, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '2-subtitulo',
      columnWidthMode: ColumnWidthMode.fill,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('OBSERVACION',
            style: CustomLabels.h2, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '3-cuota',
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('CUOTA',
            style: CustomLabels.h2, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '4-total',
      width: 90,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('PENDIENTE',
            style: CustomLabels.h2, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '5-porcentaje',
      columnWidthMode: ColumnWidthMode.fill,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('PORCENTAJE DE LA COBRANZA',
            style: CustomLabels.h2, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '6-acciones',
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.centerLeft,
        child: Text('ACCIONES',
            style: CustomLabels.h2, overflow: TextOverflow.ellipsis),
      ),
    ),
  ];

  return list;
}
