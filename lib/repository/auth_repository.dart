import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:todo_flutter/provider/top_level_providers.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepository(
      googleSignIn: ref.watch(googleSignInProvider),
      firebaseAuth: ref.watch(firebaseAuthProvider),
    );

@riverpod
String? getEmail(GetEmailRef ref) => ref.watch(firebaseAuthProvider).currentUser?.email;

class AuthRepository {
  AuthRepository({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  Stream get authStateChanges => firebaseAuth.authStateChanges();

  Future<bool> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final result = await firebaseAuth.signInWithCredential(credential);
      return result.user != null;
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }

  Future<bool> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final credential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final result = await firebaseAuth.signInWithCredential(credential);
      return result.user != null;
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
      return true;
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }
}
