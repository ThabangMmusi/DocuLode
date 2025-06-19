import 'dart:async';

import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/core/utils/logger.dart';
import 'package:doculode/features/azure_sign_in/presentation/pages/sign_in_screen.dart';
import 'package:doculode/features/profile_setup/presentation/pages/profile_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doculode/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:doculode/features/shell/presentation/pages/shell_page.dart';
import 'package:doculode/features/upload_preview/presentation/views/upload_preview.dart';

import 'package:doculode/features/settings/presentation/views/views.dart';
import 'package:doculode/features/shared/presentation/views/shared_view.dart';
import 'package:doculode/features/uploads/presentation/views/upload_file_view.dart';
import 'package:doculode/presentation/loaders/splash_screen.dart';
part 'app_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

class AppRouter {
  AppRouter({required this.dataService});
  final DatabaseService dataService;
  String? intendedRoute;
  late final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    // debugLogDiagnostics: true,
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
                        url:
                            "https://storage.googleapis.com/spushare-2023.appspot.com/uploads/5ZxhOl3PGTbPIvKUJPaKBn0UHe72/00206BF92355240717090418.pdf"),
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
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: Routes.signIn,
        builder: (context, state) => const SignInWithAzureScreen(),
      ),
      // GoRoute(
      //   path: Routes.webAuth,
      //   builder: (context, state) => const LoginScreen(
      //     isDesktopAuth: true,
      //   ),
      // ),
    ],
    redirect: (context, state) {
      // Use only fireService (DatabaseService) for user state
      final bool authUnknown =
          dataService.currentUser == null && !dataService.hasCheckedInitialUser;
      final bool loggedIn = dataService.currentUser != null;
      final bool loggingIn = state.fullPath == Routes.signIn;
      final bool onSplash = state.fullPath == Routes.splash;
      log("current path: ${state.fullPath}");
      // 1. Wait for auth state to be known before redirecting
      if (authUnknown) {
        // Only allow splash while waiting for auth
        if (!onSplash) {
          intendedRoute = state.matchedLocation;
          return Routes.splash;
        }
        return null;
      }

      // 2. Not logged in: redirect to sign in, but don't loop
      if (!loggedIn) {
        if (state.fullPath != Routes.signIn) {
          Future.delayed(const Duration(milliseconds: 600), () {
            router.go(Routes.signIn);
          });
        }
        return null;
      }

      // 3. Logged in: handle post-login redirection
      if (loggedIn &&
          intendedRoute != null &&
          intendedRoute != state.fullPath) {
        final route = intendedRoute;
        intendedRoute = null;
        return route;
      }

      // 4. Require setup if needed
      if (loggedIn && dataService.currentUser!.needSetup && state.fullPath != Routes.setup) {
        // Introduce a delay before navigating to setup
        Future.delayed(const Duration(milliseconds: 1000), () {
          router.go(Routes.setup);
        });
        return null; // Return null to prevent immediate redirection
      }

      // 5. Prevent logged-in users from seeing the sign-in page
      if (loggedIn && loggingIn) {
        // Introduce a delay before navigating to home
        Future.delayed(const Duration(milliseconds: 1000), () {
          router.go(Routes.home);
        });
        return null; // Return null to prevent immediate redirection
      }

      // 6. Default: no redirect
      return null;
    },
    refreshListenable: GoRouterRefreshStream(dataService.onUserChanged),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
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
