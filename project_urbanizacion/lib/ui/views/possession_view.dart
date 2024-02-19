import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/providers/habitante_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/ui/components/white_card.dart';
import 'package:project_urbanizacion/utils/date_formatter.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';
import 'package:project_urbanizacion/utils/util_view.dart';
import 'package:provider/provider.dart';

class PossessionView extends StatefulWidget {
  const PossessionView({Key? key}) : super(key: key);

  @override
  State<PossessionView> createState() => _PossessionViewState();
}

class _PossessionViewState extends State<PossessionView> {
  //PRRIMERA TARJETA CONTROLADORES
  int valueTpInit = 1;
  final numeroTxtController = TextEditingController();
  final fechaTxtController = TextEditingController();
  final idTxtController = TextEditingController();

  final idATxtController = TextEditingController();
  final idRTxtController = TextEditingController();
  final obsLtTxtController = TextEditingController();

  //CONTROLADOR DEL FORMULARIO
  final formkey = GlobalKey<FormState>();

  //controladores tercer tarjeta
  int valueInit = 1;
  Gc0032? objeto;
  final obsTxtController = TextEditingController();

  @override
  void dispose() {
    numeroTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habitanteProvider = Provider.of<HabitanteProvider>(context);

    void selectDate(String cadena) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null) {
        switch (cadena) {
          case 'fecha':
            fechaTxtController.text = UtilView.dateFormatDMY(picked.toString());
            break;
          default:
        }
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          WhiteCard(
              title: "TRANSFERENCIA/UNIFICACION DE LOTES",
              listWidget: const [],
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width:
                              ScreenQueries.instance.customWidth(context, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('Motivo',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              DropdownButtonFormField<int>(
                                value: valueTpInit,
                                menuMaxHeight: 230,
                                decoration: CustomInputs.boxInputDecoration3(
                                    icon: Icons.assignment_ind_rounded),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: UtilView.tipoClase
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
                                  valueTpInit = value as int;
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: ScreenQueries.instance.customWidth(context, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('Numero de transferencia',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller: numeroTxtController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(?:\+|-)?\d+$')),
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                style: CustomLabels.h2,
                                decoration: CustomInputs.txtInputDecoration2(
                                    hint: '', icon: Icons.contacts_rounded),
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return 'Por favor, introduzca un valor';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width:
                              ScreenQueries.instance.customWidth(context, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('Fecha documento',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller: fechaTxtController,
                                style: CustomLabels.h2,
                                decoration:
                                    CustomInputs.boxInputDecorationDatePicker(
                                        labelText: "Fecha Documento",
                                        fc: () => selectDate('fecha')),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^[0-9/]*$)')),
                                  DateFormatter()
                                ],
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return 'Por favor, introduzca una fecha';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width:
                              ScreenQueries.instance.customWidth(context, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('Identificación',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller: idTxtController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(?:\+|-)?\d+$')),
                                  LengthLimitingTextInputFormatter(15)
                                ],
                                style: CustomLabels.h2,
                                decoration: CustomInputs.txtInputDecoration2(
                                    hint: '', icon: Icons.contacts_rounded),
                                validator: (value) {
                                  if (value == null || value.length <= 9) {
                                    return 'Por favor, introduzca una identificacion valida';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          WhiteCard(
              title: "INFORMACION DE LOTE",
              listWidget: const [],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: ScreenQueries.instance.customWidth(context, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('# terreno asignado',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12))),
                            TextFormField(
                              controller: idATxtController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(?:\+|-)?\d+$')),
                                LengthLimitingTextInputFormatter(5),
                              ],
                              style: CustomLabels.h2,
                              decoration: CustomInputs.txtInputDecoration2(
                                  hint: '', icon: Icons.contacts_rounded),
                              validator: (value) {
                                if (value == null || value.length <= 4) {
                                  return 'Por favor, introduzca una identificacion valida';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: ScreenQueries.instance.customWidth(context, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('# terreno Regularizado',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12))),
                            TextFormField(
                              controller: idRTxtController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(?:\+|-)?\d+$')),
                                LengthLimitingTextInputFormatter(5),
                              ],
                              style: CustomLabels.h2,
                              decoration: CustomInputs.txtInputDecoration2(
                                  hint: '', icon: Icons.contacts_rounded),
                              validator: (value) {
                                if (value == null || value.length <= 4) {
                                  return 'Por favor, introduzca una identificacion valida';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: ScreenQueries.instance.customWidth(context, 2.6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('Observación',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12))),
                            TextFormField(
                              controller: obsLtTxtController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'(^[a-zA-Z ]*$)')),
                                LengthLimitingTextInputFormatter(50)
                              ],
                              style: CustomLabels.h2,
                              decoration: CustomInputs.txtInputDecoration2(
                                  hint: '', icon: Icons.contacts_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          WhiteCard(
              title: "INFORMACIÓN DE PAGO",
              listWidget: const [],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: ScreenQueries.instance.customWidth(context, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('Formas de pago',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12))),
                            DropdownButtonFormField<int>(
                              value: valueInit,
                              menuMaxHeight: 230,
                              decoration: CustomInputs.boxInputDecoration3(
                                  icon: Icons.assignment_ind_rounded),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: UtilView.tipoPagos
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
                                valueInit = value as int;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                        height: 40,
                        width: ScreenQueries.instance.customWidth(context, 6),
                        child: CustomDropdown<Gc0032>.searchRequest(
                          futureRequest: habitanteProvider.getRequestData,
                          closedHeaderPadding: const EdgeInsets.all(10),
                          decoration: CustomDropdownDecoration(
                              closedFillColor: Colors.grey[500],
                              expandedFillColor: Colors.blueGrey,
                              headerStyle: CustomLabels.h3,
                              hintStyle: CustomLabels.h3,
                              listItemStyle: CustomLabels.h3),
                          hintText: 'Seleccionar encargado del pago',
                          searchHintText: "Busqueda",
                          noResultFoundText: "No se encontro resultados",
                          onChanged: (value) {
                            objeto = value;
                          },
                          validator: (p0) {
                            if (objeto == null) {
                              return "Este campo es obligatorio";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: ScreenQueries.instance.customWidth(context, 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('Observacion de pago',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12))),
                            TextFormField(
                              controller: obsTxtController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'(^[a-zA-Z ]*$)')),
                                LengthLimitingTextInputFormatter(50)
                              ],
                              style: CustomLabels.h2,
                              decoration: CustomInputs.txtInputDecoration2(
                                  hint: '', icon: Icons.contacts_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: FilledButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                              } else {
                                UtilView.messageError(
                                    context, "Error", "Error del formulario");
                              }
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              backgroundColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                                  return Colors.indigoAccent;
                                },
                              ),
                            ),
                            child: const Text("Guardar",
                                style: TextStyle(fontSize: 12)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: FilledButton(
                            onPressed: () async {
                              formkey.currentState!.reset();
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              backgroundColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                                  return Colors.red;
                                },
                              ),
                            ),
                            child: const Text("Cancelar",
                                style: TextStyle(fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
