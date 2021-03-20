import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    String title,
    int reg,
    File imageFile,
    bool isLogin,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (!authResult.user.isEmailVerified) {
          _auth.signOut();
          Scaffold.of(ctx).showSnackBar(
            SnackBar(
              content: Text(
                  'An email has just been sent to you. Click the link provided to complete registration.'),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
        setState(() {
          _isLoading = false;
        });
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await authResult.user.sendEmailVerification();
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(authResult.user.uid + '.jpg');
        await ref.putFile(imageFile).onComplete;
        final url = await ref.getDownloadURL();
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'username': username,
          'email': email,
          'title': title,
          'reg': reg,
          'imageUrl': url,
        });
        _auth.signOut();
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(
                'An email has just been sent to you. Click the link provided to complete registration.'),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );

        setState(() {
          _isLoading = false;
        });
      }
    } on PlatformException catch (error) {
      var message = 'Error occured. Check your credentials';
      if (error.message != null) {
        message = error.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
