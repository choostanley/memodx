// import 'package:firebase_messaging/firebase_messaging.dart';
// import '../widgets/chats/messages.dart';
// import '../widgets/chats/new_message.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'profile_screen.dart';
import '../helper/databases/venue_db.dart';

class VenueScreen extends StatefulWidget {
  @override
  _VenueScreenState createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  @override
  void initState() {
    super.initState();
    // final fbm = FirebaseMessaging();
    // fbm.requestNotificationPermissions();
    // fbm.configure(onMessage: (msg) {
    //   print(msg);
    //   return;
    // }, onLaunch: (msg) {
    //   return;
    // }, onResume: (msg) {
    //   return;
    // });
    // fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clinics / Hospitals'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: DropdownButton(
              underline: Container(),
              icon: Icon(
                Icons.more_vert,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Profile',
                        ),
                      ],
                    ),
                  ),
                  value: 'profile',
                ),
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Logout',
                        ),
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'profile') {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return ProfileScreen();
                  }));
                } else if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
          child: Center(
        child: Text('Venue Selection'),
      )),
    );
  }
}
