import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Previsão do tempo v1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Previsão do tempo'),
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
  final _formKey = GlobalKey<FormState>();
  final cidadeController = TextEditingController();
  String? temperatura;
  String? previsao;
  String? temperatura5;
  String? previsao5;
  late WeatherFactory wf = WeatherFactory("9a08328b44e4a5709c57b6a84ed65115",
      language: Language.PORTUGUESE_BRAZIL);

  @override
  void dispose() {
    cidadeController.dispose();
    super.dispose();
  }

  void cidadeTempo() async {
    String? cidade = cidadeController.text;
    Weather weather = await wf.currentWeatherByCityName(cidade);
    setState(() {
      temperatura = (weather.temperature?.celsius ?? 0).toStringAsFixed(0);
      previsao = weather.weatherDescription;
      temperatura5 = null;
      previsao5 = null;
    });
  }

  void cidadeTempo5Dias() async {
    String? cidade = cidadeController.text;

    List<Weather> weather5 = await wf.fiveDayForecastByCityName(cidade);
    List<double?> temperaturaList = weather5
        .map(
            (weather) => (weather.temperature?.celsius ?? 0).toInt().toDouble())
        .cast<double?>()
        .toList();
    List<String?> previsaoList =
        weather5.map((weather) => weather.weatherDescription).toList();

    setState(() {
      temperatura5 = temperaturaList.join(', ');
      previsao5 = previsaoList.join(', ');
      temperatura = null;
      previsao = null;
    });
  }

  void _previsao() async {
    _formKey.currentState?.validate();
    String? cidadeController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: cidadeController,
              decoration: InputDecoration(labelText: 'Cidade'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira uma cidade';
                }
                return null;
              },
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      cidadeTempo();
                    }
                  },
                  child: Text('Pesquisar Previsão do tempo'),
                ),
                SizedBox(width: 8), // Add some spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      cidadeTempo5Dias();
                    }
                  },
                  child: Text('Pesquisar Previsão do tempo para 5 dias'),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),

            if (temperatura != null && previsao != null)
            const TableRow(
              
            )
              Text('Temperature: $temperatura°C\n\nForecast: $previsao'),
            if (temperatura5 != null && previsao5 != null)
              Text(
                  'Previsão para 5 dias: $temperatura5 °C\n\nForecast: $previsao5'),
          ],
        ),
      ),
    );
  }
}
