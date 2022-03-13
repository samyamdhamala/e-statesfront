import 'package:flutter/material.dart';
import 'package:login/models/login.dart';
import 'package:login/pages/login_page.dart';

import '../../token_shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  MyDrawer({required this.userName, required this.userEmail});
  // Map<String, dynamic>? userData = {};
  // MyDrawer({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(90, 81, 236, 100),
            ),
            accountName: Text(
              userName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(userEmail),
            // accountName: Text(
            //     '${userData!['firstName'].toString()} ${userData!['lastName'].toString()}'),
            // accountEmail: Text(userData!['email'].toString()),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Logout'),
            onTap: () async {
              await Future.delayed(
                const Duration(milliseconds: 500),
              );
              TokenSharedPrefernces.instance.removeToken("token");

              Navigator.of(context, rootNavigator: true)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
