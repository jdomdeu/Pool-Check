import 'package:flutter/material.dart';
import 'package:pool_check/screens/marron.dart';
import 'package:pool_check/screens/verde.dart';
import 'package:pool_check/screens/blanca.dart';

class ColoresPage extends StatefulWidget {
  @override
  _ColoresPageState createState() => _ColoresPageState();
}

class _ColoresPageState extends State<ColoresPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'COLORES RAROS',
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
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  child: Text(
                    "Dependiendo del color del agua hay que hacer un tratamiento u otro:",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontFamily: 'Montserrat', fontSize: 17),
                  ),
                ),
                const SizedBox(height: 50), // Separacion boton de arriba con baner
                SizedBox(
                  width: 350, // Ancho del botón
                  height: 100, // Alto del botón
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VerdePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      backgroundColor: Color.fromARGB(255, 136, 188, 76),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    icon: const Icon(
                      Icons.grass_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                    label: const Text(
                      "AGUA VERDE",
                      style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
                const SizedBox(height: 40), // Espacio entre los botones
                SizedBox(
                  width: 350, // Ancho del botón
                  height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BlancaPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                      ),
                      backgroundColor: const Color.fromARGB(255, 42, 41, 41),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    icon: const Icon(
                      Icons.stream_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                    label: const Text(
                      "AGUA BLANQUECINA",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 27),
                    ),
                  ),
                ),
                const SizedBox(height: 40), // Espacio entre los botones
                SizedBox(
                  width: 350, // Ancho del botón
                  height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MarronPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      backgroundColor: Color.fromARGB(255, 138, 97, 82),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    icon: const Icon(
                      Icons.colorize_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    label: const Text(
                      "AGUA MARRON O AMARILLA",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontSize: 26),
                    ),
                  ),
                ),
                const SizedBox(height: 40), // Separacion boton de arriba con baner
              ],
            ),
          ),
        ),
      );
}
