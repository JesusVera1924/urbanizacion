import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Column(
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Text('Inicio de Sesión del Sistema',
                    style: GoogleFonts.kadwa(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              const FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Digita tus creedenciales',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
