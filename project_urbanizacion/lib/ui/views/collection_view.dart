// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_urbanizacion/providers/collection_provider.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/ui/components/white_card.dart';
import 'package:project_urbanizacion/ui/dialogs/dialog_acep_canc.dart';
import 'package:project_urbanizacion/utils/constantes.dart';
import 'package:project_urbanizacion/utils/date_formatter.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';
import 'package:project_urbanizacion/utils/util_view.dart';
import 'package:provider/provider.dart';

class CollectionView extends StatefulWidget {
  const CollectionView({Key? key}) : super(key: key);

  @override
  State<CollectionView> createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  //controladores primer tarjeta
  final valorTxtController = TextEditingController();
  final fchTxtController = TextEditingController();
  final obsTxtController = TextEditingController();

  int valueTpInit = 1;
  int valueVlInit = 1;

  //KEY DEL FORM
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    valorTxtController.dispose();
    fchTxtController.dispose();
    obsTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collectionProvider = Provider.of<CollectionProvider>(context);

    void selectDate(String cadena) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );
      if (picked != null) {
        switch (cadena) {
          case 'fecha':
            fchTxtController.text = UtilView.dateFormatDMY(picked.toString());
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
              title: "GENERACIÓN DE CUOTA",
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
                          width: ScreenQueries.instance.customWidth(context, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('Motivo de cuota',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              DropdownButtonFormField<int>(
                                value: valueTpInit,
                                menuMaxHeight: 230,
                                decoration: CustomInputs.boxInputDecoration3(
                                    icon: Icons.assignment_ind_rounded),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: UtilView.tpMotivo
                                    .map((key, value) {
                                      return MapEntry(
                                          value,
                                          DropdownMenuItem(
                                            value: key,
                                            child: SizedBox(
                                              width: ScreenQueries.instance
                                                  .customWidth(context, 7),
                                              child: Text(value,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: CustomLabels.h3),
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
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width:
                              ScreenQueries.instance.customWidth(context, 7.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('Fecha Maxima de pago',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                style: CustomLabels.h2,
                                controller: fchTxtController,
                                decoration:
                                    CustomInputs.boxInputDecorationDatePicker(
                                        labelText: "Fecha Nacimiento",
                                        fc: () => selectDate('fecha')),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^[0-9/]*$)')),
                                  DateFormatter()
                                ],
                                validator: (value) {
                                  return UtilView.validarFecha(value);
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
                                  child: Text('Valor',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              TextFormField(
                                controller: valorTxtController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(Constantes.decimal)),
                                  LengthLimitingTextInputFormatter(5),
                                ],
                                validator: (value) {
                                  if (value == null ||
                                      value == "" ||
                                      value == "0") {
                                    return "Ingresar un valor*";
                                  }
                                  return null;
                                },
                                style: CustomLabels.h2,
                                decoration: CustomInputs.txtInputDecoration2(
                                    hint: '', icon: Icons.monetization_on),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: ScreenQueries.instance.width(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text('Descripción de cuota',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))),
                          TextFormField(
                            style: CustomLabels.h2,
                            maxLines: 5,
                            controller: obsTxtController,
                            decoration: CustomInputs.txtInputDecoration2(
                                hint: '', icon: Icons.assignment),
                            validator: (value) {
                              if (value == null) {
                                return 'Por favor, introduzca una observacion';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, left: 8),
                      child: Wrap(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(
                                top: 3,
                              ),
                              child: Text(
                                  'Aplicar valor segun el tipo de la asociado',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))),
                          const SizedBox(width: 10),
                          ToggleSwitch(
                            initialLabelIndex: 0,
                            totalSwitches: 2,
                            labels: const ['Si', 'No'],
                            minHeight: 25,
                            onToggle: (index) {
                              valueVlInit = index!;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FilledButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              bool resp = await dialogAcepCanc(
                                  context,
                                  "ADVERTENCIA",
                                  Text(
                                      'Esta seguro que quiere generar la\ncobranza? Esa acción es irreversible',
                                      style: CustomLabels.h3),
                                  Icons.warning_rounded,
                                  Colors.amber);

                              if (resp) {
                                bool opt =
                                    await collectionProvider.saveReferencia(
                                        fchTxtController.text,
                                        valueTpInit,
                                        obsTxtController.text,
                                        valorTxtController.text);

                                if (opt) {
                                  formkey.currentState!.reset();
                                  UtilView.messageGeneral(
                                      context,
                                      "Cobro Generado",
                                      Icons.check_circle,
                                      Colors.green);
                                } else {
                                  UtilView.messageGeneral(
                                      context,
                                      "Error [Generar Cobro]",
                                      Icons.clear_rounded,
                                      Colors.red);
                                }
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                                return Colors.green;
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: const Text('Aceptar'),
                        ),
                        const SizedBox(width: 10),
                        FilledButton(
                          onPressed: () {
                            UtilView.messageGeneral(context, "Cancelado",
                                Icons.clear_rounded, Colors.red);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                                return Colors.redAccent;
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: const Text('Cancelar'),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
