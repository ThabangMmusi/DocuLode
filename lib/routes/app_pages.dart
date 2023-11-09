import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth/auth_bloc.dart';
import '../presentation/Account/account_widgets.dart';
import '../presentation/account/account_view.dart';
import '../presentation/auth/desktop_auth.dart';
import '../presentation/auth/login_screen.dart';
import '../presentation/auth/sucessful_web_auth.dart';
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
  late final GoRouter router = GoRouter(
      initialLocation: Routes.home,
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
              // navigatorKey: _sectionANavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                  // The screen to display as the root in the first tab of the
                  // bottom navigation bar.
                  name: "DashBoard",
                  path: Routes.home,
                  builder: (context, state) => buildPages(0),
                ),
              ],
            ),

            // The route branch for the third tab of the bottom navigation bar.
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  // The screen to display as the root in the third tab of the
                  // bottom navigation bar.
                  path: Routes.uploads,
                  builder: (context, state) => buildPages(1),
                ),
              ],
            ),

            // The route branch for the second tab of the bottom navigation bar.
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.search,
                  builder: (context, state) => buildPages(2),
                ),
              ],
            ),

            // The route branch for the third tab of the bottom navigation bar.
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  // The screen to display as the root in the third tab of the
                  // bottom navigation bar.
                  path: Routes.profile,
                  builder: (context, state) => buildPages(3),
                ),
              ],
            ),
          ],
        ),
        // GoRoute(
        //   path: Routes.splash,
        //   builder: (context, state) => const SplashScreen(),
        // ),
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
        final bool loggedIn = fireService.currentUser != null;
        final bool loggingIn = state.fullPath == Routes.signIn;
        final bool webLoggingIn = state.fullPath == Routes.webAuth;
        final bool desktopLoggingIn = state.fullPath == Routes.awaitingWebAuth;

        if (desktopLoggingIn) {
          return loggedIn ? Routes.home : null;
        }
        if (webLoggingIn && loggedIn) {
          return Routes.webAuthSuccessful;
        }
        if (webLoggingIn && !loggedIn) {
          return null;
        }
        if (!loggedIn) {
          return loggingIn ? null : Routes.signIn;
        }
        if (loggingIn) {
          return Routes.home;
        }
        return null;
      },
      refreshListenable:
          GoRouterRefreshStream(fireService.onUserChanged, authBloc));
}

// https://github.com/flutter/flutter/issues/108128
// https://github.com/csells/go_router/discussions/122
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream, AuthBloc authBloc) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (currentUser) {
        authBloc.add(AuthUserChanged(user: currentUser));
        notifyListeners();
      },
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
