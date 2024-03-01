import 'package:fluro/fluro.dart';
import 'package:project_urbanizacion/providers/auth_provider.dart';
import 'package:project_urbanizacion/providers/sidemenu_provider.dart';
import 'package:project_urbanizacion/router/router.dart';
import 'package:project_urbanizacion/ui/views/batch_view.dart';
import 'package:project_urbanizacion/ui/views/collection_view.dart';
import 'package:project_urbanizacion/ui/views/committe_view.dart';
import 'package:project_urbanizacion/ui/views/document_view.dart';
import 'package:project_urbanizacion/ui/views/fundraising_view.dart';
import 'package:project_urbanizacion/ui/views/habitante_view.dart';
import 'package:project_urbanizacion/ui/views/default_view.dart';
import 'package:project_urbanizacion/ui/views/login_view.dart';
import 'package:project_urbanizacion/ui/views/organization_view.dart';
import 'package:project_urbanizacion/ui/views/possession_view.dart';
import 'package:provider/provider.dart';

class DashboardHandlers {
  static Handler defaultHandlers = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(
        Flurorouter.defaulRoute, "Bienvenidos".toUpperCase());
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DefaultView();
    } else {
      return const LoginView();
    }
  });

  static Handler habitanteHandlers = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(
        Flurorouter.habitanteRoute, "Habitantes".toUpperCase());

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const HabitanteView();
    } else {
      return const LoginView();
    }
  });

  static Handler comiteHandlers = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.comiteRoute, "Comite".toUpperCase());
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CommitteView();
    } else {
      return const LoginView();
    }
  });

  static Handler organizationHandlers = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(
        Flurorouter.organizationRoute, "Organización".toUpperCase());
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const OrganizationView();
    } else {
      return const LoginView();
    }
  });

  static Handler batchHandlers = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.batchRoute, "Comite".toUpperCase());
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BatchtView();
    } else {
      return const LoginView();
    }
  });

  static Handler documentHandlers = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(
        Flurorouter.documentRoute, "Emision de documentos".toUpperCase());
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DocumentView();
    } else {
      return const LoginView();
    }
  });

  static Handler possessionHandlers = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(
        Flurorouter.possessionRoute, "Unificacion de lotes".toUpperCase());
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PossessionView();
    } else {
      return const LoginView();
    }
  });

  static Handler collectionHandlers = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(
        Flurorouter.collectionRoute, "Cobranza".toUpperCase());
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CollectionView();
    } else {
      return const LoginView();
    }
  });

  static Handler fundraisingHandlers = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(
        Flurorouter.fundraisingRoute, "Recaudacion de fondos".toUpperCase());
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const FundraisingView();
    } else {
      return const LoginView();
    }
  });
}
