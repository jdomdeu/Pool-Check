import 'package:flutter/material.dart';
import 'screens/home.dart'; // Asegúrate de que la ruta sea correcta

void main() => runApp(MyApp());

String TextMantenimento = "·Pasar el recogehojas todas las mañanas para quitar hojas e insectos de la superfície.\n Esta acción evita que el skimmer se llene\n \n ·Limpiar con el cepillo las paredes y el suelo de la piscina al acabar de bañarse.\n Con esta simple tarea conseguimos que la suciedad no se adhiera";
String TextAspirado = "Es recomendable aspirar la piscina al menos una vez por semana\n\n1) Introducir el limpiafondos\n\n2) Poner la manguera en un chorro de retorno para llenarla con agua\n\n3) Conectar la manguera en el agujero de succión de manera vertical\n\n4) Colocar el filtro en posición Filtrado y encender la bomba\n\n5) Aspirar la piscina empezando por los rincones avanzando de forma lenta\n\n6) Apagar la bomba y retirar el limpiafondos\n\n7) Enjuagar todo con agua fresca y guardar lejos del sol";
String TextAnalisis = "El pH sirve para medir el grado de acidez del agua. El nivel de pH debe estar entre 7.2 a 7.6\n\nEl cloro sirve para desinfectar el agua. El nivel de cloro debe estar entre 1 a 3 ppm\n\nEl nivel de pH se debe medir 2 veces a la semana y el cloro todos los días";
String TextTratado = "Usar la opción MEDIDAS para saber cuanto cloro y pH es necesario";
String TextFiltro = "El agua se debe filtrar si se han bañado muchas personas o si el agua no está cristalina.\n\nEn cualquiera de estos casos, filtra el agua por 4 horas luego de añadir el cloro y de haberse bañado";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta el banner de debug
      home: MyHomePage(), // Debe ser HomePage en lugar de homePage
    );
  }
}



// NOTAS

// filter tiene números y pueden servir
// otra opción looks_6_outlined