import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_urbanizacion/layouts/auth/widgets/custom_title.dart';
import 'package:project_urbanizacion/layouts/auth/widgets/links_bar.dart';
import 'package:project_urbanizacion/style/palette.dart';
import 'package:project_urbanizacion/utils/screen_size.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
      // isAlwaysShown: true,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [_DesktopBody(child: child), const LinksBar()],
      ),
    ));
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.95,
      decoration: buildBoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: ScreenQueries.instance.customWidth(
                context,
                size.width < 1000
                    ? size.width < 400
                        ? 1
                        : 2
                    : 3),
            height: size.height * 0.8,
            decoration: BoxDecoration(
                color: Palette.backgroundColor,
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              children: [
                const CustomTitle(),
                SizedBox(
                    height: 200, child: Lottie.asset('animate/block.json')),
                Expanded(child: child),
              ],
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
        image:
            DecorationImage(image: AssetImage('fondo.jpg'), fit: BoxFit.cover));
  }
}
