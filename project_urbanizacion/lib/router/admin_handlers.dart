import 'package:fluro/fluro.dart';
import 'package:project_urbanizacion/providers/auth_provider.dart';
import 'package:project_urbanizacion/ui/views/default_view.dart';
import 'package:project_urbanizacion/ui/views/login_view.dart';
import 'package:provider/provider.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginView();
    } else {
      return const DefaultView();
    }
  });
}
