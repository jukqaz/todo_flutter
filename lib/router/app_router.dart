import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/repository/auth_repository.dart';
import 'package:todo_flutter/router/go_router_refresh_stream.dart';
import 'package:todo_flutter/screen/error_screen.dart';
import 'package:todo_flutter/screen/main_screen.dart';
import 'package:todo_flutter/screen/sign_in_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/sign-in',
  debugLogDiagnostics: kDebugMode,
  errorBuilder: (context, state) => ErrorScreen(message: state.error),
  observers: [
    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
  ],
  refreshListenable: GoRouterRefreshStream(AuthRepository().authStateChanges),
  redirect: (context, state) {
    final areWeLoggingIn = state.location == '/sign-in';
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return areWeLoggingIn ? null : '/sign-in';
    if (areWeLoggingIn) return '/';
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
