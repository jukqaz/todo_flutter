import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'top_level_providers.g.dart';

@riverpod
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) => FirebaseAuth.instance;

@riverpod
GoogleSignIn googleSignIn(GoogleSignInRef ref) => GoogleSignIn();

@riverpod
FirebaseAnalytics firebaseAnalytics(FirebaseAnalyticsRef ref) => FirebaseAnalytics.instance;

@riverpod
FirebaseAnalyticsObserver firebaseAnalyticsObserver(FirebaseAnalyticsObserverRef ref) =>
    FirebaseAnalyticsObserver(analytics: ref.watch(firebaseAnalyticsProvider));
