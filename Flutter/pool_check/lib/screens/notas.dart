Prueba para ver si funcionaba un simple HTTP:

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PruebaPage extends StatefulWidget {
  @override
  _PruebaPageState createState() => _PruebaPageState();
}

class _PruebaPageState extends State<PruebaPage> {
  List<dynamic> data = [];

  Future<void> fetchData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          data = jsonData;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al obtener datos: ${response.reasonPhrase}'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al conectar: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: Text('Fetch Data'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Title: ${data[index]['title']}'),
                    subtitle: Text('Body: ${data[index]['body']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// Segunda prueba con el que suma

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PruebaPage extends StatefulWidget {
  @override
  _PruebaPageState createState() => _PruebaPageState();
}

class _PruebaPageState extends State<PruebaPage> {
  String entityId = 'sensor1';
  String attributeName = 'value';
  double attributeValue = 0.0;

  // Método para enviar datos a Fiware
  Future<void> sendDataToFiware(BuildContext context) async {
    var hostIP = '192.168.0.20';
    var url = Uri.parse('http://$hostIP:1026/v2/entities/$entityId/attrs');
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      attributeName: {
        'type': 'Number',
        'value': attributeValue,
      },
    });

    try {
    var response = await http.patch(url, headers: headers, body: body);
    if (response.statusCode == 204) {
      print('Datos enviados a Fiware correctamente.');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al enviar datos a Fiware: ${response.reasonPhrase}'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error al conectar con Fiware: $e'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fiware App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Valor del atributo: $attributeValue',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  attributeValue += 1.0;
                });
                sendDataToFiware(context); // Pasar el BuildContext al método
              },
              child: Text('Incrementar y Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}

// Funciona de forma virtual

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PruebaPage extends StatefulWidget {
  @override
  _PruebaPageState createState() => _PruebaPageState();
}

class _PruebaPageState extends State<PruebaPage> {
  String sensorData = "Esperando datos del sensor..."; // Valor inicial de los datos
  Color containerColor = Colors.grey; // Color inicial del contenedor
  IconData iconData = Icons.sentiment_very_dissatisfied_rounded; // Icono inicial
  String phText = "Comprobar Bluetooth"; // Texto inicial

  String entityId = 'SensorPH1'; // ID de la entidad en FIWARE
  String attributeName = 'pH_value'; // Nombre del atributo en FIWARE

  // URL del servidor FIWARE y ruta donde enviar los datos
  final String fiwareUrl = 'http://192.168.0.20:1026/v2/entities/SensorPH1/attrs';

  // Función para generar números aleatorios simulados
  double generateRandomNumber() {
    // Genera un número aleatorio entre 1.0 y 14.0 (ajustable según tus necesidades)
    return Random().nextDouble() * 14.0;
  }

  // Función para enviar datos al servidor FIWARE
  Future<void> sendDataToFIWARE(double phValue) async {
    try {
      // Ejemplo de datos a enviar
      var data = {
        attributeName: {
          'value': phValue.toString(),
          'type': 'Float',
        },
        'timestamp': {
          'value': DateTime.now().toIso8601String(),
          'type': 'DateTime',
        }
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
        // Llamar función para enviar datos a FIWARE
        sendDataToFIWARE(randomValue);
      });
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
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
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
    ),
  );
}



// Envía los datos pero se sobreescribe

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

  String entityId = 'SensorPH1'; // ID de la entidad en FIWARE
  String attributeName = 'pH_value'; // Nombre del atributo en FIWARE

  // URL del servidor FIWARE y ruta donde enviar los datos
  final String fiwareUrl = 'http://192.168.0.20:1026/v2/entities/SensorPH1/attrs';

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
        'timestamp': {
          'value': timestamp,
          'type': 'DateTime',
        }
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


services:
  # Orion is an NGSI-v2 context broker
  orion-v2:
    labels:
      org.fiware: 'tutorial'
    image: quay.io/fiware/orion:${ORION_VERSION}
    hostname: orion
    container_name: fiware-orion
    depends_on:
      - mongo-db
    networks:
      - default
    ports:
      - "${ORION_PORT}:${ORION_PORT}" # Puerto definido por ORION_PORT, por ejemplo, 1026
    command: -dbURI mongodb://mongo-db -logLevel DEBUG -noCache
    healthcheck:
      test: curl --fail -s http://orion:${ORION_PORT}/version || exit 1
      interval: 5s

  

    # MongoDB database
  mongo-db:
    labels:
      org.fiware: 'tutorial'
    image: mongo:${MONGO_DB_VERSION}
    hostname: mongo-db
    container_name: db-mongo
    expose:
      - "${MONGO_DB_PORT}"
    ports:
      - "${MONGO_DB_PORT}:${MONGO_DB_PORT}" # Puerto definido por MONGO_DB_PORT, por ejemplo, 27017
    networks:
      - default
    volumes:
      - mongo-db:/data
    healthcheck:
      test: ["CMD","mongosh", "--eval", "db.adminCommand('ping')"]
      interval: 5s
      timeout: 5s
      retries: 3
      start_period: 5s



  # STH
  fiware-sth-comet:
    image: telefonicaiot/fiware-sth-comet
    links:
      - mongo-db
    ports:
      - "8666:8666"
    environment:
      - STH_HOST=0.0.0.0
      - DB_URI=db-mongo:27017
  mongo:
    image: mongo:${MONGO_DB_VERSION}

networks:
  default:
    labels:
      org.fiware: 'tutorial'
    ipam:
      config:
        - subnet: 172.18.1.0/24

volumes:
  mongo-db: # Definir como desees


#------------------
version: '3'

services:
  # Orion is an NGSI-v2 context broker
  orion-v2:
    labels:
      org.fiware: 'tutorial'
    image: quay.io/fiware/orion:${ORION_VERSION}
    hostname: orion
    container_name: fiware-orion
    depends_on:
      - mongo-db
    networks:
      - default
    ports:
      - "${ORION_PORT}:${ORION_PORT}" # Puerto definido por ORION_PORT, por ejemplo, 1026
    command: -dbURI mongodb://mongo-db -logLevel DEBUG -noCache
    healthcheck:
      test: curl --fail -s http://orion:${ORION_PORT}/version || exit 1
      interval: 5s

  # MongoDB database
  mongo-db:
    labels:
      org.fiware: 'tutorial'
    image: mongo:${MONGO_DB_VERSION}
    hostname: mongo-db
    container_name: db-mongo
    expose:
      - "${MONGO_DB_PORT}"
    ports:
      - "${MONGO_DB_PORT}:${MONGO_DB_PORT}" # Puerto definido por MONGO_DB_PORT, por ejemplo, 27017
    networks:
      - default
    volumes:
      - mongo-db:/data
    healthcheck:
      test: ["CMD","mongosh", "--eval", "db.adminCommand('ping')"]
      interval: 5s
      timeout: 5s
      retries: 3
      start_period: 5s

  # STH
  fiware-sth-comet:
    image: telefonicaiot/fiware-sth-comet
    depends_on:
      - mongo-db
    ports:
      - "8666:8666"
    networks:
      - default
    environment:
      - STH_HOST=0.0.0.0
      - DB_URI=mongo-db:27017
      - NAME_ENCODING=true
      - DATA_MODEL=collection-per-attribute
      - LOGOPS_LEVEL=DEBUG
    container_name: sth

networks:
  default:
    driver: bridge

volumes:
  mongo-db: # Definir como desees

// --------------------------- La de datos cuando enviaba
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DatosPage extends StatefulWidget {
  final Stream<String>? dataStream;

  const DatosPage({Key? key, this.dataStream}) : super(key: key);

  @override
  _DatosPageState createState() => _DatosPageState();
}

class _DatosPageState extends State<DatosPage> {
  String sensorData = "Esperando datos del sensor...";
  Color containerColor = Colors.grey;
  IconData iconData = Icons.sentiment_very_dissatisfied_rounded;
  double pHValue = 7.0; // Valor inicial de pH
  String ph_text = "Comprobar Bluetooth";

  // Los datos de Postman
  String entityId = 'SensorpH'; // ID de la entidad en FIWARE
  String attributeName = 'acidity'; // Nombre del atributo en FIWARE

  // URL del servidor FIWARE y ruta donde enviar los datos
  final String fiwareUrl = 'http://192.168.0.20:1026/v2/entities/SensorpH/attrs';

  @override
  void initState() {
    super.initState();
    // Inicializar el stream y suscribirse a los cambios
    if (widget.dataStream != null) {
      widget.dataStream!.listen((data) {
        setState(() {
          // Actualizar el estado con los nuevos datos
          sensorData = data;
          // Convertir sensorData a un valor numérico (pHValue)
          pHValue = double.tryParse(sensorData) ?? 7.0; // Valor por defecto 7.0 si no se puede convertir
          // Lógica para cambiar el color del contenedor y el ícono según el valor de pH
          if (pHValue < 7.2) {
            containerColor = Colors.purple;
            iconData = Icons.sentiment_dissatisfied_outlined;
            ph_text = "pH Básico";
          } else if (pHValue == 7.4) {
            containerColor = Colors.blue;
            iconData = Icons.sentiment_very_satisfied_outlined;
            ph_text = "pH Perfecto";
          } else if (pHValue >= 7.2 && pHValue <= 7.6) {
            containerColor = Colors.green;
            iconData = Icons.sentiment_satisfied_rounded;
            ph_text = "pH Ideal";
          } else {
            containerColor = Colors.orange;
            iconData = Icons.sentiment_neutral_outlined;
            ph_text = "pH Ácido";
          }
        });
        sendDataToFIWARE(pHValue); // Enviar los datos a FIWARE cada vez que se reciban nuevos datos del sensor
      });
    }
  }

  // Función para enviar datos al servidor FIWARE
  Future<void> sendDataToFIWARE(double phValue) async {
    try {
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
        headers: {
          'Content-Type': 'application/json',
          'fiware-service': 'tutorial', // Añadir el servicio FIWARE
          'fiware-servicepath': '/', // Añadir la ruta de servicio FIWARE
        },
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
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
                    '${pHValue.toStringAsFixed(2)} ppm', // Muestra el valor de pH con dos decimales
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    ph_text, // Que salga el valor que debería
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
        ),
      );
}