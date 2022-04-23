import 'package:flutter/material.dart';
import 'package:login/pages/display_for_own_property/own_property_listings.dart';
import 'package:login/provider/theme_provider.dart';
import '../../token_shared_preferences.dart';
import '../common/common/login_page.dart';
import '../common/common/search_delegate.dart';

class MyDrawer extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String userEmail;

  MyDrawer(
      {required this.firstName,
      required this.userEmail,
      required this.lastName});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // Map<String, dynamic>? userData = {};
  bool value = false;
  @override
  void initState() {
    super.initState();
  }

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
              widget.firstName + " " + widget.lastName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(widget.userEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.cottage_outlined),
            title: Text('My Posts'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => OwnPropertyListings()));
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search Properties'),
            onTap: () => showSearch(context: context, delegate: DataSearch()),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Dark Mode'),
            trailing: Switch(
              value: currentTheme.isSwitchOn() ? true : false,
              onChanged: (value) {
                setState(() {
                  this.value = value;
                  currentTheme.toggleTheme();
                });
              },
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
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
