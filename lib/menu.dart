import 'package:flutter/material.dart';
import 'package:medusa_client/settings.dart';

class AppMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
            height: 100,
            child: DrawerHeader(
              child: Text('Medusa'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            )),
        ListTile(
          title: Text('Settings'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage()));
          },
        )
      ],
    ));
  }
}
