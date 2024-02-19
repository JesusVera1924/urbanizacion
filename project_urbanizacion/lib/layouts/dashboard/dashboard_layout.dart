import 'package:flutter/material.dart';
import 'package:project_urbanizacion/layouts/dashboard/widget/sidebar.dart';
import 'package:project_urbanizacion/providers/sidemenu_provider.dart';
import 'package:project_urbanizacion/style/palette.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;

  const DashboardLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SideMenuProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Row(
            children: [
              if (size.width >= 700 && SideMenuProvider.enableItems)
                const Sidebar(),
              // Contenedor de nuestro view
              Expanded(child: Container(child: widget.child))
            ],
          ),
          /*   if (size.width < 700)
            AnimatedBuilder(
              animation: SideMenuProvider.menuController,
              builder: (context, _) => Stack(
                children: [
                  if (SideMenuProvider.isOpen)
                    Opacity(
                      opacity: SideMenuProvider.opacity.value,
                      child: GestureDetector(
                        onTap: () => SideMenuProvider.closeMenu(),
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  Transform.translate(
                      offset: Offset(SideMenuProvider.movement.value, 0),
                      child: const Sidebar())
                ],
              ),
            )
         */
        ],
      ),
    );
  }
}
