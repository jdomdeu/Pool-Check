import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

// Define the SensorData class
class SensorData {
  final DateTime recvTime;
  final double attrValue;

  SensorData({required this.recvTime, required this.attrValue});

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      recvTime: DateTime.parse(json['recvTime']),
      attrValue: json['attrValue'].toDouble(),
    );
  }
}

// Ajusta el valor máximo permitido para `lastN`
const int maxAllowedLastN = 24;  // Cambia según la documentación del API

// Function to fetch data from the API
Future<List<SensorData>> fetchSensorData(String sensorType, String period) async {
  int periodValue = int.tryParse(period) ?? 10;

  // Asegúrate de que el valor de lastN esté dentro del rango permitido
  if (periodValue > maxAllowedLastN) {
    periodValue = maxAllowedLastN;
  }

  final attribute = sensorType == 'pH' ? 'acidity' : 'chlorine';
  final response = await http.get(
    Uri.parse(
        'http://192.168.0.20:8666/STH/v1/contextEntities/type/Sensor/id/graph_Sensor$sensorType/attributes/$attribute?lastN=$periodValue'),
    headers: {
      'fiware-service': 'tutorial',
      'fiware-servicepath': '/',
    },
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> values =
        jsonResponse['contextResponses'][0]['contextElement']['attributes'][0]['values'];

    return values.map((value) => SensorData.fromJson(value)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

// Function to fetch available days from the API
Future<List<DateTime>> fetchAvailableDays(String sensorType) async {
  final attribute = sensorType == 'pH' ? 'acidity' : 'chlorine';
  final response = await http.get(
    Uri.parse(
        'http://192.168.0.20:8666/STH/v1/contextEntities/type/Sensor/id/graph_Sensor$sensorType/attributes/$attribute?lastN=$maxAllowedLastN'),
    headers: {
      'fiware-service': 'tutorial',
      'fiware-servicepath': '/',
    },
  );

  print('Response status for available days: ${response.statusCode}');
  print('Response body for available days: ${response.body}');

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> values =
        jsonResponse['contextResponses'][0]['contextElement']['attributes'][0]['values'];

    final Set<DateTime> uniqueDays = {};

    for (var value in values) {
      final DateTime recvTime = DateTime.parse(value['recvTime']);
      final DateTime day =
          DateTime(recvTime.year, recvTime.month, recvTime.day);
      uniqueDays.add(day);
    }

    return uniqueDays.toList()..sort();
  } else {
    throw Exception('Failed to load data');
  }
}

// Function to fetch data for a specific day
Future<List<SensorData>> fetchSensorDataForDay(
    String sensorType, DateTime day) async {
  final attribute = sensorType == 'pH' ? 'acidity' : 'chlorine';
  final response = await http.get(
    Uri.parse(
        'http://192.168.0.20:8666/STH/v1/contextEntities/type/Sensor/id/graph_Sensor$sensorType/attributes/$attribute?lastN=$maxAllowedLastN'),
    headers: {
      'fiware-service': 'tutorial',
      'fiware-servicepath': '/',
    },
  );

  print('Response status for specific day: ${response.statusCode}');
  print('Response body for specific day: ${response.body}');

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> values =
        jsonResponse['contextResponses'][0]['contextElement']['attributes'][0]['values'];

    final filteredValues = values.where((value) {
      final DateTime recvTime = DateTime.parse(value['recvTime']);
      return recvTime.year == day.year &&
          recvTime.month == day.month &&
          recvTime.day == day.day;
    }).toList();

    return filteredValues.map((value) => SensorData.fromJson(value)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

// Function to generate CSV and save to file
Future<String> generateCsv(List<SensorData> data) async {
  List<List<dynamic>> rows = [];
  rows.add(['Date', 'Value']); // Header

  for (var item in data) {
    rows.add([item.recvTime.toIso8601String(), item.attrValue]);
  }

  String csv = const ListToCsvConverter().convert(rows);

  // Reemplazar caracteres no válidos en el nombre del archivo
  String safeDateTime = DateTime.now()
      .toIso8601String()
      .replaceAll(':', '-')
      .replaceAll('.', '-'); // Reemplazar también el punto

  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/sensor_data_$safeDateTime.csv';
  File file = File(path);
  await file.writeAsString(csv);

  return path;
}

// Function to share the CSV file
void shareCsv(String path) {
  Share.shareFiles([path], text: 'Here is the sensor data for the selected day.');
}

// Widget to display the chart
class SensorChart extends StatelessWidget {
  final List<SensorData> data;
  final String sensorType;

  // Define ranges specific to each sensor type
  final double minValue;
  final double maxValue;

  SensorChart({
    required this.data,
    required this.sensorType,
    this.minValue = 0.0,
    this.maxValue = 13.0,
  });

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SensorData, DateTime>> series = [
      charts.Series(
        id: sensorType,
        data: data,
        domainFn: (SensorData sensorData, _) => sensorData.recvTime,
        measureFn: (SensorData sensorData, _) => sensorData.attrValue,
        colorFn: (SensorData sensorData, _) {
          if (sensorType == 'pH') {
            if (sensorData.attrValue >= 7.2 && sensorData.attrValue <= 7.6) {
              return charts.MaterialPalette.green.shadeDefault;
            } else if (sensorData.attrValue == 7.4) {
              return charts.MaterialPalette.blue.shadeDefault;
            } else if (sensorData.attrValue < 7.2) {
              return charts.MaterialPalette.purple.shadeDefault;
            } else {
              return charts.MaterialPalette.deepOrange.shadeDefault;
            }
          } else if (sensorType == 'ORP') {
            if (sensorData.attrValue >= 100 && sensorData.attrValue <= 300) {
              return charts.MaterialPalette.green.shadeDefault;
            } else if (sensorData.attrValue < 100) {
              return charts.MaterialPalette.purple.shadeDefault;
            } else {
              return charts.MaterialPalette.red.shadeDefault;
            }
          } else {
            return charts.MaterialPalette.gray.shadeDefault;
          }
        },
        strokeWidthPxFn: (_, __) => 2.0,
      )
    ];

    return charts.TimeSeriesChart(
      series,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      behaviors: [
        charts.ChartTitle('Date & Time',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        charts.ChartTitle('$sensorType Value',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        charts.LinePointHighlighter(
          symbolRenderer: charts.CircleSymbolRenderer(isSolid: true),
        ),
        charts.SelectNearest(
          eventTrigger: charts.SelectionTrigger.tapAndDrag,
        ),
      ],
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
        viewport: charts.NumericExtents(minValue, maxValue),
      ),
    );
  }
}

// Main screen widget
class GraficaScreen extends StatefulWidget {
  static const routeName = '/grafica';

  @override
  _GraficaScreenState createState() => _GraficaScreenState();
}

class _GraficaScreenState extends State<GraficaScreen> {
  late Future<List<SensorData>> futureSensorData;
  late Future<List<DateTime>> futureAvailableDays;
  DateTime? selectedDay;
  List<SensorData>? dailyData;
  String selectedSensor = 'pH'; // Default to pH

  @override
  void initState() {
    super.initState();
    futureAvailableDays = fetchAvailableDays(selectedSensor);
    futureSensorData = fetchSensorDataForDay(selectedSensor, DateTime.now());  // Muestra datos del día actual por defecto
  }

  void _onDayChanged(DateTime? newDay) {
    setState(() {
      selectedDay = newDay;
      if (selectedDay != null) {
        futureSensorData = fetchSensorDataForDay(selectedSensor, selectedDay!);
        futureSensorData.then((data) {
          dailyData = data;
        });
      }
    });
  }

  void _onSensorChanged(String? newSensor) {
    setState(() {
      selectedSensor = newSensor ?? 'pH';
      futureAvailableDays = fetchAvailableDays(selectedSensor);
      futureSensorData = fetchSensorDataForDay(selectedSensor, selectedDay ?? DateTime.now());
    });
  }

  void _downloadCsv() async {
    if (dailyData != null) {
      final path = await generateCsv(dailyData!);
      shareCsv(path);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No data available for download.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Chart'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _downloadCsv,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedSensor,
              items: <String>['pH', 'ORP'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: _onSensorChanged,
              isExpanded: true,
              hint: Text('Select a sensor type'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<DateTime>>(
              future: futureAvailableDays,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return DropdownButton<DateTime>(
                    value: selectedDay,
                    items: snapshot.data!.map((day) {
                      return DropdownMenuItem(
                        value: day,
                        child: Text(
                            '${day.toLocal().toString().split(' ')[0]}'), // Muestra solo la fecha
                      );
                    }).toList(),
                    onChanged: _onDayChanged,
                    isExpanded: true,
                    hint: Text('Select a day'),
                  );
                } else {
                  return Text('No days available');
                }
              },
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<List<SensorData>>(
                future: futureSensorData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return SensorChart(
                      data: snapshot.data!,
                      sensorType: selectedSensor,
                      minValue: selectedSensor == 'ORP' ? 200 : 0.0, // Cambia según el tipo de sensor
                      maxValue: selectedSensor == 'ORP' ? 1500.0 : 13.0, // Cambia según el tipo de sensor
                    );
                  } else {
                    return Text('No data available');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Sensor Chart App',
    home: GraficaScreen(),
  ));
}
