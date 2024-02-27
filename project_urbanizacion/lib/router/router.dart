import 'package:fluro/fluro.dart';
import 'package:project_urbanizacion/router/admin_handlers.dart';
import 'package:project_urbanizacion/router/dashboard_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  // Auth Router
  static String loginRoute = '/auth/login';
  //static String registerRoute = '/auth/register';

  // Dashboard
  static String defaulRoute = '/regularizacion';
  static String habitanteRoute = '/regularizacion/habitante';
  static String organizationRoute = '/regularizacion/organization';
  static String comiteRoute = '/regularizacion/comite';
  static String batchRoute = '/regularizacion/terreno';
  static String documentRoute = '/regularizacion/documento';
  static String possessionRoute = '/regularizacion/possession';
  static String collectionRoute = '/regularizacion/collection';

  static void configureRoutes() {
    // Auth Routes
    router.define(rootRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);

    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);

    /* router.define(registerRoute,
        handler: AdminHandlers.register, transitionType: TransitionType.none); */

    // Dashboard
    router.define(defaulRoute,
        handler: DashboardHandlers.defaultHandlers,
        transitionType: TransitionType.fadeIn);

    router.define(habitanteRoute,
        handler: DashboardHandlers.habitanteHandlers,
        transitionType: TransitionType.fadeIn);

    router.define(comiteRoute,
        handler: DashboardHandlers.comiteHandlers,
        transitionType: TransitionType.fadeIn);

    router.define(organizationRoute,
        handler: DashboardHandlers.organizationHandlers,
        transitionType: TransitionType.fadeIn);

    router.define(batchRoute,
        handler: DashboardHandlers.batchHandlers,
        transitionType: TransitionType.fadeIn);

    router.define(documentRoute,
        handler: DashboardHandlers.documentHandlers,
        transitionType: TransitionType.fadeIn);

    router.define(possessionRoute,
        handler: DashboardHandlers.possessionHandlers,
        transitionType: TransitionType.fadeIn);

    router.define(collectionRoute,
        handler: DashboardHandlers.collectionHandlers,
        transitionType: TransitionType.fadeIn);

    // 404
    //router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
