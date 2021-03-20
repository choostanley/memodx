import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../pickers/user_image_picker.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String userName,
    String title,
    int reg,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final bool isLoading;
  AuthForm(this.submitFn, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _password = '';
  String _title = null;
  int _reg = null;
  File _userImageFile;
  static List<String> _dropdownTitles = [
    'Dr',
    'Mr',
    'Mdm',
    'Ms',
    'Sister',
    'Sn',
  ];
  // final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
  //   functionName: 'verifyMMC',
  // )..timeout = const Duration(seconds: 5);
  final String merits =
      'https://meritsmmc.moh.gov.my/search/registeredDoctor?name=';

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Add an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();

      if (!_isLogin) {
        try {
          var response =
              await http.get(merits + _userName.trim().split(' ').join('+'));
          var upperName = _userName.trim().toUpperCase();
          List<String> lines = LineSplitter.split(response.body);
          var nameLine = lines.firstWhere((line) => line.contains(upperName));
          var name1 =
              nameLine.split('<').firstWhere((l) => l.contains(upperName));
          var name2 = name1.split('>').firstWhere((l) => l.contains(upperName));
          List<String> urls = [];
          if (nameLine != null && upperName == name2) {
            lines.where((l) => l.contains('viewDoctor')).forEach((l) {
              var viewDr =
                  l.split(';').firstWhere((l) => l.contains('viewDoctor'));
              urls.add(viewDr
                  .split('&')
                  .firstWhere((l) => l.contains('viewDoctor')));
            });
            if (await checkRegNum(urls)) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('''Valid credentials. 
                      An email has just been sent to you. 
                      Click the link provided to complete registration.'''),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
              widget.submitFn(
                _userEmail.trim(),
                _password.trim(),
                _userName.trim(),
                _title,
                _reg,
                _userImageFile,
                _isLogin,
                context,
              );
            } else {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Check credentials and register again.'),
                  backgroundColor: Theme.of(context).errorColor,
                ),
              );
            }
          } else {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Check credentials and register again.'),
                backgroundColor: Theme.of(context).errorColor,
              ),
            );
          }
        } catch (e) {
          // print(e);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Registration error occured. Try again or contact admin.'),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
      } else {
        widget.submitFn(
          _userEmail.trim(),
          _password.trim(),
          _userName.trim(),
          _title,
          _reg,
          _userImageFile,
          _isLogin,
          context,
        );
      }
    }
  }

  Future<bool> checkRegNum(List<String> urls) async {
    for (var i = 0; i < urls.length; i++) {
      var res = await http.get(urls[i]);
      List<String> lines = LineSplitter.split(res.body);
      var full =
          lines.firstWhere((l) => l.contains('Full Registration Number'));
      var provi = lines
          .firstWhere((l) => l.contains('Provisional Registration Number'));
      if (full != null) {
        if (full.contains(_reg.toString()))
          return true;
        else
          continue;
      } else if (provi != null) {
        if (provi.contains(_reg.toString()))
          return true;
        else
          continue;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  textCapitalization: TextCapitalization.none,
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Enter valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email address',
                  ),
                  onSaved: (value) {
                    _userEmail = value;
                  },
                ),
                if (!_isLogin)
                  DropdownButtonFormField<String>(
                    key: ValueKey('title'),
                    decoration: InputDecoration(
                        hoverColor: Theme.of(context).primaryColor,
                        labelText: 'Title',
                        labelStyle: _title == null
                            ? null
                            : TextStyle(color: Theme.of(context).primaryColor)),
                    value: _title,
                    validator: (value) =>
                        value == null ? 'Please fill in your title' : null,
                    onChanged: (String newValue) {
                      print(newValue);
                      // Focus.of(context).nextFocus();
                      FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {
                        _title = newValue;
                        // phoneController.text = _dropdownValue.countryCode;
                      });
                    },
                    items: _dropdownTitles.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Fullname must be at least 4 chars long';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Fullname',
                    ),
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('reg'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'MMC number must be at least 5 chars long';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'MMC no.',
                    ),
                    onSaved: (value) {
                      _reg = int.parse(value);
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value.isEmpty || value.length < 6) {
                      return 'Password must be atleast 6 chars long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  onSaved: (value) {
                    _password = value;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                if (!widget.isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin
                        ? 'Create an account'
                        : 'Already have an account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
