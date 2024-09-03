import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart'; // Asegúrate de tener esta dependencia

class PruebaPage extends StatefulWidget {
  @override
  _PruebaPageState createState() => _PruebaPageState();
}

class _PruebaPageState extends State<PruebaPage> {
  String sensorData = "Esperando datos del sensor..."; // Valor inicial de los datos
  Color containerColor = Colors.grey; // Color inicial del contenedor
  IconData iconData = Icons.sentiment_very_dissatisfied_rounded; // Icono inicial
  String phText = "Comprobar Bluetooth"; // Texto inicial

  String entityId = 'SensorpH'; // ID de la entidad en FIWARE
  String attributeName = 'acidity'; // Nombre del atributo en FIWARE

  // URL del servidor FIWARE y ruta donde enviar los datos
  final String fiwareUrl = 'http://192.168.0.20:1026/v2/entities/SensorpH/attrs';

  // Lista para almacenar los datos de pH y sus timestamps
  List<Map<String, dynamic>> phDataList = [];

  // Función para generar números aleatorios simulados
  double generateRandomNumber() {
    // Genera un número aleatorio entre 1.0 y 14.0 (ajustable según tus necesidades)
    return Random().nextDouble() * 14.0;
  }

  // Función para enviar datos al servidor FIWARE
  Future<void> sendDataToFIWARE(double phValue) async {
    try {
      // Generar timestamp para cada dato
      String timestamp = DateTime.now().toIso8601String();

      // Ejemplo de datos a enviar
      var data = {
        attributeName: {
          'value': phValue.toString(),
          'type': 'Float',
        },
      };

      // Realizar la petición HTTP PATCH
      var response = await http.patch(
        Uri.parse(fiwareUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      // Verificar el código de respuesta
      if (response.statusCode == 204) {
        print('Datos enviados a FIWARE correctamente.');
      } else {
        // Mostrar Snackbar si ocurre un error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al enviar datos a FIWARE. Código de respuesta: ${response.statusCode}'),
            duration: Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      // Mostrar Snackbar si ocurre un error de conexión
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error en la solicitud HTTP: $e'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  // Función para simular la recepción de datos (números aleatorios)
  void simulateData() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        double randomValue = generateRandomNumber();
        sensorData = randomValue.toStringAsFixed(2);
        // Lógica para cambiar el color del contenedor y el ícono según el valor de pH simulado
        if (randomValue < 7.2) {
          containerColor = Colors.purple;
          iconData = Icons.sentiment_dissatisfied_outlined;
          phText = "pH Básico";
        } else if (randomValue == 7.4) {
          containerColor = Colors.blue;
          iconData = Icons.sentiment_very_satisfied_outlined;
          phText = "pH Perfecto";
        } else if (randomValue >= 7.2 && randomValue <= 7.6) {
          containerColor = Colors.green;
          iconData = Icons.sentiment_satisfied_rounded;
          phText = "pH Ideal";
        } else {
          containerColor = Colors.orange;
          iconData = Icons.sentiment_neutral_outlined;
          phText = "pH Ácido";
        }
        // Llamar función para enviar datos a FIWARE y actualizar la gráfica
        sendDataToFIWARE(randomValue);
        updatePhData(randomValue, DateTime.now());
      });
    });
  }

  // Función para actualizar los datos de pH recibidos
  void updatePhData(double phValue, DateTime timestamp) {
    setState(() {
      // Añadir los datos más recientes al principio de la lista
      phDataList.insert(0, {'value': phValue, 'timestamp': timestamp});
      // Limitar la lista a 10 elementos para mantener la gráfica con datos recientes
      if (phDataList.length > 10) {
        phDataList.removeLast();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Iniciar simulación de datos al cargar la pantalla
    simulateData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'MEDIDAS',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          toolbarHeight: 100,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.show_chart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PruebasPage(phDataList: phDataList)),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity, // Ocupa todo el ancho disponible
                height: 250,
                padding: EdgeInsets.all(20), // Padding dentro del contenedor
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // Cambia la posición de la sombra
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        iconData,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '$sensorData ppm', // Muestra el valor de pH simulado con dos decimales
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        phText, // Texto según el valor de pH simulado
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
}

// Nueva pantalla para mostrar las gráficas
class PruebasPage extends StatelessWidget {
  final List<Map<String, dynamic>> phDataList;

  PruebasPage({required this.phDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gráficas de pH'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: phDataList
                    .asMap()
                    .entries
                    .map((entry) => FlSpot(entry.key.toDouble(), entry.value['value']))
                    .toList(),
                isCurved: true,
                barWidth: 3,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                ),
              ),
            ],
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  getTitlesWidget: (value, meta) {
                    final int index = value.toInt();
                    if (index >= 0 && index < phDataList.length) {
                      return Text(
                        phDataList[index]['timestamp']
                            .toString()
                            .substring(11, 16), // Muestra solo la hora y los minutos
                        style: const TextStyle(
                            color: Color(0xff68737d),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      );
                    }
                    return const Text('');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toString(),
                      style: const TextStyle(
                          color: Color(0xff67727d),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(color: const Color(0xff37434d), strokeWidth: 1);
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(color: const Color(0xff37434d), strokeWidth: 1);
              },
            ),
          ),
        ),
      ),
    );
  }
}
