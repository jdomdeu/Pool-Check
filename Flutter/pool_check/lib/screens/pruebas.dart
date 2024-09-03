import 'package:flutter/material.dart';
import 'package:pool_check/screens/datos.dart';

class TurbiaPage extends StatefulWidget {
  @override
  _TurbiaPageState createState() => _TurbiaPageState();
}

class _TurbiaPageState extends State<TurbiaPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AGUA TURBIA',
          style: TextStyle(
            fontSize: 35, // Tamaño del título
            fontWeight: FontWeight.bold,
            color: Colors.white, // Color del título
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        toolbarHeight: 100, // Altura del área del banner
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
      );
      body: Column(
        children: [
          const SizedBox(height: 30),
          _controlBT(),
          _infoDevice(),
          Expanded(child: _listDevices()),
          if (_connection?.isConnected ?? false) _sendDataButton(), // Show button if connected
        ],
      ),);
     
}}
Widget _sendDataButton() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          MaterialPageRoute(builder: (context) => DatosPage()); // Replace with actual data or data collection logic
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(fontSize: 18),
          ),
        ),
        child: const Text("Ver Medidas"),
      ),
    ),
  );
}
