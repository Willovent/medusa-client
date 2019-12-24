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
              child: Row(children: [
                Container(
                    height: 30,
                    child: Padding(
                        child: Image.asset('lib/assets/medusa_logo.png'),
                        padding: EdgeInsets.only(right: 8))),
                Text('Medusa'),
              ]),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
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
