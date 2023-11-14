import 'package:flutter/material.dart';

class SegundaTela extends StatelessWidget {
  final String _resultado;
  SegundaTela(this._resultado);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultado da calculadora"),
      ),
      body: Center(
          child: Column(children: [
        Text(this._resultado),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context, "Retorno");
            },
            child: Text('Voltar'))
      ])),
    );
  }
}
