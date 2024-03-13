import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_urbanizacion/utils/constantes.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //const Icon(Icons.corporate_fare_sharp, color: Color(0xff7A6BF5)),
          const SizedBox(width: 10),
          Text(
            Constantes.selectEmpresa.nomEmp,
            style: GoogleFonts.montserratAlternates(
                fontSize: 20, fontWeight: FontWeight.w200, color: Colors.white),
          )
        ],
      ),
    );
  }
}
