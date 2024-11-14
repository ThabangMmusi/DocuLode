import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:its_shared/features/upload_edit/presentation/views/upload_edit_view.dart';
import 'package:its_shared/features/upload_preview/presentation/views/upload_preview.dart';

import '../core/bloc/auth/auth_bloc.dart';
import '../features/setup/presentation/views/setup_view.dart';
import '../features/shared/presentation/views/shared_view.dart';
import '../presentation/account/account_view.dart';
import '../presentation/account/home/home.dart';
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
          // Return the widget that implements the custom shell (in this case
          // using a BottomNavigationBar). The StatefulNavigationShell is passed
          // to be able access the state of the shell and to navigate to other
          // branches in a stateful way.
          return MainAccountView(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          // The route branch for the first tab of the bottom navigation bar.
          StatefulShellBranch(
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                name: "DashBoard",
                path: Routes.home,
                builder: (context, state) => const HomeView(),
              ),
            ],
          ),

          // The route branch for the third tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.uploads,
                builder: (context, state) => const UploadFileView(),
                routes: [
                  GoRoute(
                    path: ":id",
                    builder: (context, state) => const UploadPreview(
                        url:
                            "https://storage.googleapis.com/spushare-2023.appspot.com/uploads/5ZxhOl3PGTbPIvKUJPaKBn0UHe72/00206BF92355240717090418.pdf"),
                  ),
                ],
              ),
            ],
          ),

          // The route branch for the second tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.search,
                builder: (context, state) => const Center(
                  child: Text("Saved"),
                ),
              ),
            ],
          ),
// The route branch for the second tab of the bottom navigation bar.
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

          // The route branch for the third tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the third tab of the
                // bottom navigation bar.
                path: Routes.modules,
                builder: (context, state) => const Center(
                  child: Text("modules"),
                ),
              ),
            ],
          ),
        ],
      ),
      // GoRoute(
      //     path: Routes.shared,
      //     builder: (context, state) => Text("data"),
      //     routes: [

      //     ]),
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
        builder: (context, tate) => const SuccessfulWebAuth(),
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

// https://github.com/flutter/flutter/issues/108128
// https://github.com/csells/go_router/discussions/122
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription =
        stream.asBroadcastStream().listen((currentUser) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
