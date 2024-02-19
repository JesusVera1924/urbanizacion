import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/http/menu_response.dart';
import 'package:project_urbanizacion/services/local_storage.dart';

class SideMenuProvider extends ChangeNotifier {
  static late AnimationController menuController;
  static bool isOpen = false;
  String _textMenu = '';
  String _currentPage = '';
  String? codEmp;

  static bool enableItems = true;
  //
  final api = SolicitudApi();
  List<MenuResponse> menuList = [];
  List<MenuResponse> menusubList = [];
  List<MenuResponse> item = [];

  String get currentPage {
    return _currentPage;
  }

  String get textMenu {
    return _textMenu;
  }

  void setCurrentPageUrl(String routeName, String title) {
    _currentPage = routeName;
    _textMenu = title;
    Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }

  static Animation<double> movement = Tween<double>(begin: -230, end: 0)
      .animate(
          CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static void openMenu() {
    isOpen = true;
    menuController.forward();
  }

  static void closeMenu() {
    isOpen = false;
    menuController.reverse();
  }

  static void toggleMenu() {
    (isOpen) ? menuController.reverse() : menuController.forward();

    isOpen = !isOpen;
  }

  initList() async {
    codEmp = LocalStorage.prefs.getString('emp');
    //final usuario = LocalStorage.prefs.getString('dni');
    //final token = LocalStorage.prefs.getString('token');

    List<MenuResponse> listResponse = [];

    menuList = listResponse.where((element) => element.clsPry == "G").toList();
    menusubList =
        listResponse.where((element) => element.clsPry == "M").toList();

    item = listResponse.where((element) => element.clsPry == "I").toList();
  }

  updateModel() {
    // ignore: unused_local_variable
    final idModulo = LocalStorage.prefs.getString('idModule');
  }
}
