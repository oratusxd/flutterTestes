import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              Text("Numero 1:"),
              Expanded(
                child: TextField(
                  controller: _numero1Controller,
                ),
              )
            ]),
            Row(
              children: [
                Text("Numero 2:"),
                Expanded(
                  child: TextField(
                    controller: _numero2Controller,
                  ),
                )
              ],
            ),
            ElevatedButton(onPressed: _somar, child: Text("Somar"))
          ],
        )));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _resultado = 0;
  final _numero1Controller = TextEditingController();
  final _numero2Controller = TextEditingController();
  @override
  void dispose() {
    _numero1Controller.dispose();
    _numero2Controller.dispose();
    super.dispose();
  }

  void _somar() {
    setState(() {
      this._resultado = int.parse(_numero1Controller.text) +
          int.parse(_numero2Controller.text);
    });
  }
}
