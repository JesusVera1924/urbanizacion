// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? width;
  final List<Widget> listWidget;

  const WhiteCard(
      {Key? key,
      this.title,
      this.width,
      required this.child,
      required this.listWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    title!,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                for (final _fieldValue in listWidget) ...[_fieldValue]
              ],
            ),
            const Divider()
          ],
          child
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
          ]);
}
