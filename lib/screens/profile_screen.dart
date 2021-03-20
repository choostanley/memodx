import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _password = '';
  String _title = null;
  int _reg = null;
  String imageUrl;
  File _userImageFile;
  FirebaseUser user;
  static List<String> _dropdownTitles = [
    'Dr',
    'Mr',
    'Mdm',
    'Ms',
    'Sister',
    'Sn',
  ];
  bool _isLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController regController = TextEditingController();

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async {
    user = await FirebaseAuth.instance.currentUser();
    var userData = await Firestore.instance
        .collection('users')
        .document(user.uid)
        .get()
        .then((hash) {
      setState(() {
        usernameController.text = hash.data['username'];
        _title = hash.data['title'];
        regController.text = hash.data['reg'].toString();
        imageUrl = hash.data['imageUrl'];
        // _userImageFile = File(hash['imageUrl']);
        // titleController.text = hash.data['title'];
      });
    });
  }

  void updateProfile(
      FirebaseUser user,
      String email,
      String password,
      String username,
      String title,
      int reg,
      File imageFile,
      BuildContext ctx) async {
    print(user);
    try {
      setState(() {
        _isLoading = true;
      });
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(user.uid + '.jpg');
      await ref.putFile(imageFile).onComplete;
      final url = await ref.getDownloadURL();
      await Firestore.instance
          .collection('users')
          .document(user.uid)
          .updateData({
        'username': username,
        'title': title,
        'reg': reg,
        'imageUrl': url,
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text('Profile updated'),
            backgroundColor: Theme.of(context).accentColor,
          ),
        );
      });
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

  void _trySubmit(BuildContext ctx) {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(ctx).unfocus();

    if (_userImageFile == null) {
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text('Add an image'),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      updateProfile(
        user,
        _userEmail.trim(),
        _password.trim(),
        _userName.trim(),
        _title,
        _reg,
        _userImageFile,
        ctx,
      );
    }
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _userImageFile = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Builder(
            builder: (ctx) => Center(
                  child: Card(
                    margin: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Stack(children: <Widget>[
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Color(0xffdadada),
                                backgroundImage: _userImageFile != null
                                    ? FileImage(
                                        _userImageFile,
                                      )
                                    : imageUrl != null
                                        ? NetworkImage(imageUrl)
                                        : null,
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: _pickImage,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Color(0xffdadada),
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                              )
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField<String>(
                              key: ValueKey('title'),
                              value: _title,
                              isDense: true,
                              validator: (value) => value == null
                                  ? 'Please fill in your title'
                                  : null,
                              decoration: InputDecoration(
                                  hoverColor: Theme.of(context).primaryColor,
                                  labelText: 'Title',
                                  labelStyle: _title == null
                                      ? null
                                      : TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                              onChanged: (String newValue) {
                                setState(() {
                                  _title = newValue;
                                  // phoneController.text = _dropdownValue.countryCode;
                                });
                              },
                              items: _dropdownTitles.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                    child: Text(value),
                                    width: 200.0,
                                  ),
                                );
                              }).toList(),
                            ),
                            TextFormField(
                              key: ValueKey('username'),
                              controller: usernameController,
                              validator: (value) {
                                if (value.isEmpty || value.length < 4) {
                                  return 'Fullname must be at least 4 chars long';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Registered Name',
                              ),
                              onSaved: (value) {
                                _userName = value;
                              },
                            ),
                            TextFormField(
                              key: ValueKey('reg'),
                              controller: regController,
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
                            SizedBox(
                              height: 15,
                            ),
                            if (_isLoading) CircularProgressIndicator(),
                            if (!_isLoading)
                              RaisedButton(
                                onPressed: () => _trySubmit(ctx),
                                child: Text('Update Profile'),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
  }
}
