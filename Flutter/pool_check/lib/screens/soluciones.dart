import 'package:flutter/material.dart';
import 'package:pool_check/screens/aguaturbia.dart';
import 'package:pool_check/screens/espuma.dart';
import 'package:pool_check/screens/irritar.dart';
import 'package:pool_check/screens/suciedad.dart';
import 'package:pool_check/screens/olor.dart';
import 'package:pool_check/screens/colores.dart';
import 'package:pool_check/screens/algas.dart';

class SolucionesPage extends StatefulWidget {
  @override
  _SolucionesPageState createState() => _SolucionesPageState();
}

class _SolucionesPageState extends State<SolucionesPage> {

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'SOLUCIONES',
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
        ),
        // BOTONES

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50), // Separación del botón de arriba con el banner
                _buildButton(
                  context,
                  "AGUA TURBIA",
                  Icons.dirty_lens_sharp,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TurbiaPage()),
                  ),
                ),
                const SizedBox(height: 30), // Espacio entre los botones
                _buildButton(
                  context,
                  "ESPUMA EN EL AGUA",
                  Icons.bubble_chart_outlined,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EspumaPage()),
                  ),
                ),
                const SizedBox(height: 30), // Espacio entre los botones
                _buildButton(
                  context,
                  "IRRITACIÓN DE OJOS Y PIEL",
                  Icons.dry,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IrritarPage()),
                  ),
                ),
                const SizedBox(height: 30), // Espacio entre los botones
                _buildButton(
                  context,
                  "SUCIEDAD EN LOS BORDES",
                  Icons.cleaning_services,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuciedadPage()),
                  ),
                ),
                const SizedBox(height: 30), // Espacio entre los botones
                _buildButton(
                  context,
                  "OLOR A CLORO",
                  Icons.warning_rounded,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OlorPage()),
                  ),
                ),
                const SizedBox(height: 30), // Espacio entre los botones
                _buildButton(
                  context,
                  "COLORES EXTRAÑOS",
                  Icons.format_color_fill,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ColoresPage()),
                  ),
                ),
                const SizedBox(height: 30), // Espacio entre los botones
                _buildButton(
                  context,
                  "ALGAS EN LA PISCINA",
                  Icons.grass_rounded,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlgasPage()),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );

  // Widget para construir los botones con iconos
  Widget _buildButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 350, // Ancho del botón
      height: 100, // Alto del botón
      child: TextButton.icon(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.lightBlue[200],
        ),
        icon: Container(
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: Colors.white,
            size: 35,
          ),
        ),
        label: Container(
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
