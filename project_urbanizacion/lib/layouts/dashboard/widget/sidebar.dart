import 'package:flutter/material.dart';
import 'package:project_urbanizacion/layouts/dashboard/widget/logo.dart';
import 'package:project_urbanizacion/layouts/dashboard/widget/menu_item_s.dart';
import 'package:project_urbanizacion/providers/auth_provider.dart';
import 'package:project_urbanizacion/providers/sidemenu_provider.dart';
import 'package:project_urbanizacion/router/router.dart';
import 'package:project_urbanizacion/services/local_storage.dart';
import 'package:project_urbanizacion/services/navigation_service.dart';
import 'package:project_urbanizacion/ui/components/text_separator.dart';

import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  navigateTo(String routeName, {String module = ''}) {
    LocalStorage.prefs.setString('idModule', module);
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  void initState() {
    //INIZIALIZAR CONSULTA DEL MENU
    //Provider.of<SideMenuProvider>(context, listen: false).initList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 240,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: 'main'),
          //GENERACION DEL MENU
          MenuItemSideBar(
            text: 'INICIO'.toUpperCase(),
            icon: Icons.home,
            onPressed: () => navigateTo(Flurorouter.defaulRoute),
            isActive: SideMenuProvider.enableItems
                ? sideMenuProvider.currentPage == Flurorouter.defaulRoute
                : false,
          ),

          MenuItemSideBar(
            text: 'HABITANTE'.toUpperCase(),
            icon: Icons.man_rounded,
            onPressed: () => navigateTo(Flurorouter.habitanteRoute),
            isActive: SideMenuProvider.enableItems
                ? sideMenuProvider.currentPage == Flurorouter.habitanteRoute
                : false,
          ),

          MenuItemSideBar(
              text: 'ORGANIZACIÓN'.toUpperCase(),
              icon: Icons.groups_outlined,
              onPressed: () => navigateTo(Flurorouter.comiteRoute),
              isActive: SideMenuProvider.enableItems
                  ? sideMenuProvider.currentPage == Flurorouter.comiteRoute
                  : false),

          MenuItemSideBar(
            text: 'GENERAR INF.LOTE'.toUpperCase(),
            icon: Icons.account_balance_wallet_rounded,
            onPressed: () => navigateTo(Flurorouter.batchRoute),
            isActive: SideMenuProvider.enableItems
                ? sideMenuProvider.currentPage == Flurorouter.batchRoute
                : false,
          ),
          MenuItemSideBar(
            text: "DOCUMENTO".toUpperCase(),
            icon: Icons.edit_document,
            onPressed: () => navigateTo(Flurorouter.documentRoute),
            isActive: SideMenuProvider.enableItems
                ? sideMenuProvider.currentPage == Flurorouter.documentRoute
                : false,
          ),
          MenuItemSideBar(
            text: 'TRANSFERENCIA'.toUpperCase(),
            icon: Icons.transfer_within_a_station_rounded,
            onPressed: () => navigateTo(Flurorouter.possessionRoute),
            isActive: SideMenuProvider.enableItems
                ? sideMenuProvider.currentPage == Flurorouter.possessionRoute
                : false,
          ),
          MenuItemSideBar(
              text: 'COBRANZA'.toUpperCase(),
              icon: Icons.currency_exchange_outlined,
              onPressed: () => navigateTo(Flurorouter.collectionRoute),
              isActive: SideMenuProvider.enableItems
                  ? sideMenuProvider.currentPage == Flurorouter.collectionRoute
                  : false),

          const SizedBox(height: 40),
          const TextSeparator(text: 'Admin'),

          MenuItemSideBar(
              text: 'CONFIGURACIÓN'.toUpperCase(),
              icon: Icons.settings,
              onPressed: () => navigateTo(Flurorouter.organizationRoute),
              isActive: SideMenuProvider.enableItems
                  ? sideMenuProvider.currentPage ==
                      Flurorouter.organizationRoute
                  : false),

          const SizedBox(height: 40),
          const TextSeparator(text: 'Salir'),
          MenuItemSideBar(
              text: 'Cerrar Sesion',
              icon: Icons.exit_to_app_outlined,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xff092044),
        Color(0xff092048),
      ]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
