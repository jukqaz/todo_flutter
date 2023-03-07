import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_flutter/constant/route_name.dart';
import 'package:todo_flutter/provider/top_level_providers.dart';
import 'package:todo_flutter/repository/auth_repository.dart';
import 'package:todo_flutter/router/go_router_refresh_stream.dart';
import 'package:todo_flutter/screen/error_screen.dart';
import 'package:todo_flutter/screen/main_screen.dart';
import 'package:todo_flutter/screen/sign_in_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) => GoRouter(
      initialLocation: routeSignIn,
      debugLogDiagnostics: kDebugMode,
      errorBuilder: (context, state) => ErrorScreen(message: state.error),
      observers: [ref.watch(firebaseAnalyticsObserverProvider)],
      refreshListenable: GoRouterRefreshStream(ref.watch(authRepositoryProvider).authStateChanges),
      redirect: (context, state) {
        final areWeLoggingIn = state.location == routeSignIn;
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) return areWeLoggingIn ? null : routeSignIn;
        if (areWeLoggingIn) return routeMain;
        return null;
      },
      routes: [
        GoRoute(
          path: '/sign-in',
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const MainScreen(),
        ),
      ],
    );
