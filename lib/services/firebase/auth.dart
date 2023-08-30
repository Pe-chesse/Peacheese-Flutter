import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peach_market/widgets/dialog/default.dart';
import 'package:peach_market/widgets/dialog/email_verify.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class PeacheeseFirebaseAuth {

  static Future<String?> getTokenGoogle(GoogleSignInAccount? googleUser) async {
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    if (googleUser != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
      return await user.user?.getIdToken(true);
    }
    return null;
  }

  static Future<String?> getTokenApple(
      AuthorizationCredentialAppleID appleCredential) async {
    final credential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return await user.user?.getIdToken(true);
  }

  static Future google() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    return await getTokenGoogle(googleUser);
  }

  static Future apple() async {
    final appleUser = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    return await getTokenApple(appleUser);
  }

  static Future emailSignIn(
      BuildContext context, String email, String password) async {
    try {
      final UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (!user.user!.emailVerified) {
        throw FirebaseAuthException(code: 'email-unverify');
      }
      throw FirebaseAuthException(code: 'successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const DefaultMessageDialog(title: '사용자를 찾을 수 없습니다.')
            .show(context);
      } else if (e.code == 'wrong-password') {
        return const DefaultMessageDialog(title: '비밀번호가 올바르지 않습니다.')
            .show(context);
      } else if (e.code == 'email-unverify') {
        return const EmailVerifyDialog().show(context);
      }
    }
  }

  static Future guest()async{
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  static Future emailSignUp(
      BuildContext context, String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user?.sendEmailVerification();
      throw FirebaseAuthException(code: 'success-sign-up');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const DefaultMessageDialog(
          title: '비밀번호 양식',
          content: Text('비밀번호가 너무 쉽습니다.'),
        ).show(context);
      } else if (e.code == 'email-already-in-use') {
        return const DefaultMessageDialog(
          title: '이미 사용중인 이메일',
          content: Text('기입된 이메일은 이미 사용중인 이메일입니다.'),
        ).show(context);
      } else if (e.code == 'success-sign-up') {
        return DefaultMessageDialog(
          title: '회원가입 완료',
          content: Text('$email\n인증요청을 전송했습니다\n\n메일 내부의 링크를 클릭하시면 인증이 완료됩니다.'),
        ).show(context);
      }
    }
  }

  static Future forgotPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
          (value) =>
              const DefaultMessageDialog(content: Text('인증 메일을 전송했습니다.\n메일을 확인하세요.'), title: '인증메일 발송',)
                  .show(context));
    } on FirebaseAuthException catch (e) {
      DefaultMessageDialog(title: e.code.replaceAll('-', ' '), content: Text(e.message??''))
          .show(context);
    }
  }

  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
