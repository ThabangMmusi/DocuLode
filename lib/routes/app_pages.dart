import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:its_shared/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:its_shared/features/shell/presentation/pages/shell_page.dart';
import 'package:its_shared/features/upload_preview/presentation/views/upload_preview.dart';

import '../core/common/auth/presentation/bloc/auth_bloc.dart';
import '../features/settings/settings.dart';
import '../features/setup/presentation/views/course_settings_view.dart';
import '../features/shared/presentation/views/shared_view.dart';
import '../features/uploads/presentation/views/upload_file_view.dart';
import '../presentation/auth/desktop_auth.dart';
import '../presentation/auth/login_screen.dart';
import '../presentation/auth/successful_web_auth.dart';
import '../presentation/loaders/splash_screen.dart';
import '../services/firebase/firebase_service.dart';
part 'app_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

class AppRouter {
  AppRouter({required this.fireService, required this.authBloc});
  final FirebaseService fireService;
  final AuthBloc authBloc;
  String? intendedRoute;
  late final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, StatefulNavigationShell navigationShell) {
          return ShellPage(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                name: "DashBoard",
                path: Routes.home,
                builder: (context, state) => const DashboardPage(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.uploads,
                builder: (context, state) => const UploadFileView(),
                routes: [
                  GoRoute(
                    path: ":id",
                    builder: (context, state) => const UploadPreview(
                        url: "https://storage.googleapis.com/spushare-2023.appspot.com/uploads/5ZxhOl3PGTbPIvKUJPaKBn0UHe72/00206BF92355240717090418.pdf"),
                  ),
                ],
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.saves,
                builder: (context, state) => const Center(
                  child: Text("Saved"),
                ),
              ),
            ],
          ),
          
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.search,
                builder: (context, state) => const Center(
                  child: Text("search"),
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.settings,
                builder: (context, state) => const Center(
                  child: SettingsView(),
                ),
              ),
            ],
          ),
          
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.modules,
                builder: (context, state) => const Center(
                  child: Text("moduleshhhh"),
                ),
              ),
            ],
          ),
        ],
      ),
      
      GoRoute(
        path: Routes.shared,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return SharedView(id);
        },
      ),
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.setup,
        builder: (context, state) => const SetupView(),
      ),
      GoRoute(
        path: Routes.signIn,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.webAuth,
        builder: (context, state) => const LoginScreen(
          isDesktopAuth: true,
        ),
      ),
      GoRoute(
        path: Routes.awaitingWebAuth,
        builder: (context, state) => const DesktopAuthScreen(),
      ),
      GoRoute(
        path: Routes.webAuthSuccessful,
        builder: (context, state) => const SuccessfulWebAuth(),
      ),
    ],
    redirect: (context, state) {
      final bool authUnknown = authBloc.state.status == AuthStatus.unknown;
      final bool loggedIn = fireService.currentUser != null;
      final bool loggingIn = state.fullPath == Routes.signIn;
      final bool onAuthUnknown = state.fullPath == Routes.splash;
      final bool webAuth = state.fullPath == Routes.webAuth;
      final bool desktopLoggingIn = state.fullPath == Routes.awaitingWebAuth;

      if (desktopLoggingIn) {
        return loggedIn ? Routes.home : null;
      }
      if (webAuth && loggedIn) {
        return Routes.webAuthSuccessful;
      }
      if (webAuth && !loggedIn) {
        return null;
      }
      if (authUnknown && onAuthUnknown) return null;
      if (authUnknown) {
        intendedRoute = state.matchedLocation;
        return Routes.splash;
      }

      if (!loggedIn) {
        return loggingIn ? null : Routes.signIn;
      }
      if (loggedIn && intendedRoute != null) {
        final intendedRouteFinal = intendedRoute;
        intendedRoute = null;
        return intendedRouteFinal;
      }
      if (loggedIn && fireService.currentUser!.needSetup) {
        return Routes.setup;
      }
      if (loggedIn && loggingIn) {
        return Routes.home;
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(fireService.onUserChanged),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((currentUser) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
