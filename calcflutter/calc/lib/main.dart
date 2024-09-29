import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TemperatureConversionPage(),
    );
  }
}

class TemperatureConversionPage extends StatefulWidget {
  const TemperatureConversionPage({super.key});

  @override
  State<TemperatureConversionPage> createState() => _TemperatureConversionPageState();
}

class _TemperatureConversionPageState extends State<TemperatureConversionPage> {
  String _conversionType = 'FtoC';
  double _temperatureValue = 0;
  double _convertedValue = 0;
  final List<String> _history = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Conversion App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField(
              value: _conversionType,
              onChanged: (String? value) {
                setState(() {
                  _conversionType = value!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'FtoC',
                  child: Text('Fahrenheit to Celsius'),
                ),
                DropdownMenuItem(
                  value: 'CtoF',
                  child: Text('Celsius to Fahrenheit'),
                ),
              ],
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                setState(() {
                  _temperatureValue = double.parse(value);
                });
              },
            ),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text('Convert'),
            ),
            Text(
              _convertedValue != 0
                  ? 'Converted value: ${_convertedValue.toStringAsFixed(2)}'
                  : '',
            ),
            const SizedBox(height: 16),
            const Text('History:'),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(_history[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _convertTemperature() {
    if (_conversionType == 'FtoC') {
      _convertedValue = (_temperatureValue - 32) * 5 / 9;
    } else if (_conversionType == 'CtoF') {
      _convertedValue = _temperatureValue * 9 / 5 + 32;
    }

    setState(() {
      _history.add(
        '${_conversionType == 'FtoC' ? 'F to C' : 'C to F'}: ${_temperatureValue.toStringAsFixed(2)} => ${_convertedValue.toStringAsFixed(2)}',
      );
    });
  }
}