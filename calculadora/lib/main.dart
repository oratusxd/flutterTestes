import 'package:flutter/material.dart';
import 'segunda_tela.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _resultado = 0;

  final _numero1Controller = TextEditingController();
  final _numero2Controller = TextEditingController();
  void dispose() {
    _numero1Controller.dispose();
    _numero2Controller.dispose();
    super.dispose();
  }

  void _somar() {
    setState(() {
      this._resultado = double.parse(_numero1Controller.text) +
          double.parse(_numero2Controller.text);
      novaTela(context);
    });
  }

  void _subtracao() {
    setState(() {
      this._resultado = double.parse(_numero1Controller.text) -
          double.parse(_numero2Controller.text);
      novaTela(context);
    });
  }

  void _multiplicacao() {
    setState(() {
      this._resultado = double.parse(_numero1Controller.text) *
          double.parse(_numero2Controller.text);
      novaTela(context);
    });
  }

  void _divisao() {
    setState(() {
      this._resultado = double.parse(_numero1Controller.text) /
          double.parse(_numero2Controller.text);
      novaTela(context);
    });
  }

  void novaTela(BuildContext context) async {
    final retorno = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SegundaTela(_resultado.toString())));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Voltou: $retorno")));
  }

  void limparText() {
    _numero1Controller.clear();
    _numero2Controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              Text("Número 1:"),

              Expanded(
                  child: TextField(
                      controller: _numero1Controller,
                      keyboardType: TextInputType.number)) // Expanded
            ] // children
                ),
            Row(children: [
              Text("Número 2:"),
              Expanded(
                  child: TextField(
                      controller: _numero2Controller,
                      keyboardType: TextInputType.number)) // Expanded
            ] // children
                ),
            Row(children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: _somar,
                child: Text("+"),
              )),
              Expanded(
                  child: ElevatedButton(
                onPressed: _subtracao,
                child: Text("-"),
              )),
            ]),
            Row(children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: _multiplicacao,
                child: Text("x"),
              )),
              Expanded(
                  child: ElevatedButton(
                onPressed: _divisao,
                child: Text("/"),
              ))
            ]),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => limparText(), child: Text("Limpar")))
              ],
            )
          ],
        ),
      ),
    );
  }
}
