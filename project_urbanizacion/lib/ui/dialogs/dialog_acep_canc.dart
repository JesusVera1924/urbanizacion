import 'package:flutter/material.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';

Future<bool> dialogAcepCanc(BuildContext context, String title, Widget body,
    IconData iconData, Color color) async {
  bool op = false;

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Row(
            children: [
              Icon(iconData, color: color, size: 24),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(title,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ),
            ],
          ),
          content: body,
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
                onPressed: () {
                  op = true;
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar', style: CustomLabels.h3)),
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
                  op = false;
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar', style: CustomLabels.h3)),
          ],
        );
      });
  return op;
}
