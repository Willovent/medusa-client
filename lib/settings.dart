import 'package:flutter/material.dart';
import 'package:medusa_client/models/api-state.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.notifier.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> {
  TextEditingController _apiUrl = TextEditingController();
  TextEditingController _apiKey = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiUrl.text = prefs.get('apiUrl') ?? '';
      _apiKey.text = prefs.get('apiKey') ?? '';
    });
  }

  Future<void> _saveData(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('apiUrl', _apiUrl.text);
      await prefs.setString('apiKey', _apiKey.text);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Settings saved')));
      apiStateNotifer.value =
          ApiState(apiKey: _apiKey.text, apiUrl: _apiUrl.text);
    }
  }

  @override
  initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _apiUrl,
                    decoration: InputDecoration(
                        labelText: 'API url (ex: http://192.168.1.2:8081)'),
                    validator: (value) {
                      return Uri.parse(value).isAbsolute
                          ? null
                          : 'Url is not valid';
                    },
                  ),
                  TextFormField(
                    controller: _apiKey,
                    decoration: InputDecoration(labelText: 'Api Key'),
                    validator: (value) {
                      return value != '' ? null : 'Api key must have a value';
                    },
                  )
                ],
              ))),
      floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton(
                onPressed: () => _saveData(ctx),
                tooltip: 'save',
                child: Icon(Icons.save),
              )),
    );
  }
}
