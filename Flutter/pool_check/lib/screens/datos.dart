import 'dart:async';
import 'package:flutter/material.dart';

class DatosPage extends StatefulWidget {
  final Stream<String>? dataStream;

  const DatosPage({Key? key, this.dataStream}) : super(key: key);

  @override
  _DatosPageState createState() => _DatosPageState();
}

class _DatosPageState extends State<DatosPage> {
  String sensorData = "Esperando datos del sensor...";
  Color phContainerColor = Colors.grey;
  Color orpContainerColor = Colors.grey;
  IconData phIconData = Icons.sentiment_very_dissatisfied_rounded;
  IconData orpIconData = Icons.sentiment_very_dissatisfied_rounded;
  double pHValue = 7.0; // Valor inicial de pH
  double orpValue = 0.0; // Valor inicial de ORP
  String phText = "Comprobar Bluetooth";
  String orpText = "Comprobar Bluetooth";

  @override
  void initState() {
    super.initState();
    // Inicializar el stream y suscribirse a los cambios
    if (widget.dataStream != null) {
      widget.dataStream!.listen((data) {
        setState(() {
          // Procesar los datos recibidos
          if (data.startsWith("pH:")) {
            // Extraer el valor de pH
            pHValue = double.tryParse(data.substring(3).trim()) ?? 7.0; // Valor por defecto 7.0 si no se puede convertir
            // Lógica para cambiar el color del contenedor y el ícono según el valor de pH
            if (pHValue < 7.2) {
              phContainerColor = Colors.purple;
              phIconData = Icons.sentiment_dissatisfied_outlined;
              phText = "pH Básico";
            } else if (pHValue == 7.4) {
              phContainerColor = Colors.blue;
              phIconData = Icons.sentiment_very_satisfied_outlined;
              phText = "pH Perfecto";
            } else if (pHValue >= 7.2 && pHValue <= 7.6) {
              phContainerColor = Colors.green;
              phIconData = Icons.sentiment_satisfied_rounded;
              phText = "pH Ideal";
            } else {
              phContainerColor = Colors.orange;
              phIconData = Icons.sentiment_neutral_outlined;
              phText = "pH Ácido";
            }
          } else if (data.startsWith("ORP:")) {
            // Extraer el valor de ORP
            orpValue = double.tryParse(data.substring(4).trim()) ?? 0.0;
            // Lógica para cambiar el color del contenedor y el ícono según el valor de ORP
            if (orpValue < 200) {
              orpContainerColor = Colors.red;
              orpIconData = Icons.warning_amber_rounded;
              orpText = "ORP Bajo";
            } else if (orpValue >= 200 && orpValue <= 400) {
              orpContainerColor = Colors.green;
              orpIconData = Icons.sentiment_satisfied_rounded;
              orpText = "ORP Ideal";
            } else {
              orpContainerColor = Colors.orange;
              orpIconData = Icons.sentiment_neutral_outlined;
              orpText = "ORP Alto";
            }
          }
        });
      });
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
          child: Column(
            children: [
              // Contenedor para el valor de pH
              Container(
                width: double.infinity,
                height: 250,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: phContainerColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        phIconData,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${pHValue.toStringAsFixed(2)} ppm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        phText,
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
              // Contenedor para el valor de ORP
              Container(
                width: double.infinity,
                height: 250,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: orpContainerColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        orpIconData,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${orpValue.toStringAsFixed(2)} mV',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        orpText,
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
            ],
          ),
        ),
      );
}

