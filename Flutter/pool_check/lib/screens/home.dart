import 'package:flutter/material.dart';
import 'package:pool_check/screens/grafica.dart';
// import 'package:pool_check/screens/datos.dart';
import 'package:pool_check/screens/medidas.dart';
// import 'package:pool_check/screens/prueba.dart';
import 'package:pool_check/screens/soluciones.dart';
import 'mantenimiento.dart'; // Importa la página de mantenimiento

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,   // Oculta el banner de depuración
      theme: ThemeData(fontFamily: 'GOTHIC'),
      title: 'Pool Check',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtén el tamaño de la pantalla
    final screenSize = MediaQuery.of(context).size;
    final buttonWidth = screenSize.width * 0.9; // Ancho del botón en porcentaje del ancho de la pantalla
    final buttonHeight = 100.0; // Alto del botón fijo para que no se deforme

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'POOL CHECK',
          style: TextStyle(
            fontSize: 40, // Tamaño del título ajustado
            fontWeight: FontWeight.bold,
            color: Colors.white, // Color del título
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        toolbarHeight: 120, // Altura del área del banner ajustada
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: buttonWidth, // Ancho del botón ajustado
              height: buttonHeight,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MantenimientoPage()),
                  );
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 24, // Tamaño del texto ajustado
                  ),
                  backgroundColor: Colors.lightBlue[200],
                ),
                icon: const Icon(
                  Icons.pool,
                  color: Colors.white,
                  size: 30, // Tamaño del icono ajustado
                ),
                label: const Text(
                  "MANTENIMIENTO",
                  style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                ),
              ),
            ),
            const SizedBox(height: 46), // Espacio entre los botones ajustado
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SolucionesPage()),
                  );
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 27,
                    fontFamily: 'Montserrat',
                  ),
                  backgroundColor: Colors.lightBlue[200],
                ),
                icon: const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                label: const Text(
                  "SOLUCIONES",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 46), // Espacio entre los botones ajustado
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MedidasPage()),
                  );
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 24,
                  ),
                  backgroundColor: Colors.lightBlue[200],
                ),
                icon: const Icon(
                  Icons.bluetooth_searching_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                label: const Text(
                  "SENSORES",
                  style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                ),
              ),
            ),
            const SizedBox(height: 46), // Espacio entre los botones ajustado
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GraficaScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 24,
                  ),
                  backgroundColor: Colors.lightBlue[200],
                ),
                icon: const Icon(
                  Icons.assessment_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                label: const Text(
                  "GRÁFICAS",
                  style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
