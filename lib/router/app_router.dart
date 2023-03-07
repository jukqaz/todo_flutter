import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
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
  routes: [
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => MainScreen(),
    ),
  ],
);
