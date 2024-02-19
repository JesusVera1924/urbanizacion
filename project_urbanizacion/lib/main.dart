import 'package:flutter/material.dart';
import 'package:project_urbanizacion/layouts/auth/auth_layout.dart';
import 'package:project_urbanizacion/layouts/dashboard/dashboard_layout.dart';
import 'package:project_urbanizacion/layouts/splash/splash_layout.dart';
import 'package:project_urbanizacion/providers/auth_provider.dart';
import 'package:project_urbanizacion/providers/bach_provider.dart';
import 'package:project_urbanizacion/providers/committe_provider.dart';
import 'package:project_urbanizacion/providers/document_provider.dart';
import 'package:project_urbanizacion/providers/habitante_provider.dart';
import 'package:project_urbanizacion/providers/possession_provider.dart';
import 'package:project_urbanizacion/providers/sidemenu_provider.dart';
import 'package:project_urbanizacion/router/router.dart';
import 'package:project_urbanizacion/services/local_storage.dart';
import 'package:project_urbanizacion/services/navigation_service.dart';
import 'package:project_urbanizacion/services/notifications_service.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocalStorage.configurePrefs();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => HabitanteProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => CommitteProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => BachProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => DocumentProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => PossessionProvider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema Urbanización',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking) {
          return const SplashLayout();
        }

        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor:
                  MaterialStateProperty.all(Colors.grey.withOpacity(0.5)))),
    );
  }
}
