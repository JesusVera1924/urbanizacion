import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashLayout extends StatelessWidget {
  const SplashLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200, child: Lottie.asset('animate/loading.json')),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text('Cargando...',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
