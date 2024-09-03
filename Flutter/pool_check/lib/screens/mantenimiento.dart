import 'package:flutter/material.dart';

class MantenimientoPage extends StatefulWidget {
  @override
  _MantenimientoPageState createState() => _MantenimientoPageState();
}

class _MantenimientoPageState extends State<MantenimientoPage> {
  bool isCompletedLimpieza = false;
  bool isExpandedLimpieza = false;

  bool isCompletedAspirar = false;
  bool isExpandedAspirar = false;

  bool isCompletedAnalisis = false;
  bool isExpandedAnalisis = false;

  bool isCompletedTratamiento = false;
  bool isExpandedTratamiento = false;

  bool isCompletedFiltrar = false;
  bool isExpandedFiltrar = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'MANTENIMIENTO',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          toolbarHeight: 80,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

               Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  child: Text(
                    "ACCIONES PARA TENER UNA PISCINA LIMPIA",
                    textAlign: TextAlign.center, // Added TextAlign.center
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'montserrat',
                      fontSize: 17,
                    ),
                  ),
                ),


                  buildInstructionTile(
                    "LIMPIEZA",
                    isCompletedLimpieza,
                    isExpandedLimpieza,
                    () {
                      setState(() {
                        if (!isCompletedLimpieza) {
                          isExpandedLimpieza = !isExpandedLimpieza;
                        }
                      });
                    },
                    () {
                      setState(() {
                        isCompletedLimpieza = true;
                        isExpandedLimpieza = false;
                      });
                    },
                    [
                      buildInstructionStep("· Pasar el recogehojas todas las mañanas para quitar hojas e insectos de la superfície."),
                      buildInstructionStep("Esta acción evita que el skimmer se llene"),
                      buildInstructionStep("· Limpiar con el cepillo las paredes y el suelo de la piscina al acabar de bañarse."),
                      buildInstructionStep("Con esta simple tarea conseguimos que la suciedad no se adhiera"),
                    ],
                    Icons.cleaning_services_outlined,
                    Colors.tealAccent,
                    Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  buildInstructionTile(
                    "ASPIRACIÓN",
                    isCompletedAnalisis,
                    isExpandedAnalisis,
                    () {
                      setState(() {
                        if (!isCompletedAnalisis) {
                          isExpandedAnalisis = !isExpandedAnalisis;
                        }
                      });
                    },
                    () {
                      setState(() {
                        isCompletedAnalisis = true;
                        isExpandedAnalisis = false;
                      });
                    },
                    [
                      buildInstructionStep("· Es recomendable aspirar la piscina al menos una vez por semana."),
                      buildInstructionStep("1) Introducir el limpiafondos"),
                      buildInstructionStep("2) Poner la manguera en un chorro de retorno para llenarla con agua"),
                      buildInstructionStep("3) Conectar la manguera en el agujero de succión de manera vertical"),
                      buildInstructionStep("4) Colocar el filtro en posición Filtrado y encender la bomba"),
                      buildInstructionStep("5) Aspirar la piscina empezando por los rincones avanzando de forma lenta"),
                      buildInstructionStep("6) Apagar la bomba y retirar el limpiafondos"),
                      buildInstructionStep("7) Enjuagar todo con agua fresca y guardar lejos del sol"),
                    ],
                    Icons.fire_hydrant_alt_outlined,
                    Color.fromARGB(255, 189, 217, 243),
                    Colors.blueGrey,
                  ),

                  const SizedBox(height: 10),
                  buildInstructionTile(
                    "ANÁLISIS",
                    isCompletedAspirar,
                    isExpandedAspirar,
                    () {
                      setState(() {
                        if (!isCompletedAspirar) {
                          isExpandedAspirar = !isExpandedAspirar;
                        }
                      });
                    },
                    () {
                      setState(() {
                        isCompletedAspirar = true;
                        isExpandedAspirar = false;
                      });

                    },
                    [
                      buildInstructionStep("· El pH sirve para medir el grado de acidez del agua. El nivel de pH debe estar entre 7.2 a 7.6\n\nEl cloro sirve para desinfectar el agua. El nivel de cloro debe estar entre 1 a 3 ppm"),
                      buildInstructionStep("El nivel de pH se debe medir 2 veces a la semana y el cloro todos los días"),
                    ],
                    Icons.analytics_outlined,
                    Colors.white,
                    Colors.indigo,
                  ),

                  const SizedBox(height: 10),
                  buildInstructionTile(
                    "TRATAMIENTO",
                    isCompletedTratamiento,
                    isExpandedTratamiento,
                    () {
                      setState(() {
                        if (!isCompletedTratamiento) {
                          isExpandedTratamiento = !isExpandedTratamiento;
                        }
                      });
                    },
                    () {
                      setState(() {
                        isCompletedTratamiento = true;
                        isExpandedTratamiento = false;
                      });

                    },

                    [
                      buildInstructionStep("· Usar la opción MEDIDAS para saber cuanto cloro y pH es necesario"),
                    ],
                    Icons.import_export_rounded,
                    Colors.lightBlueAccent,
                    Colors.teal,
                  ),

                  const SizedBox(height: 10),
                  buildInstructionTile(
                    "FILTRADO",
                    isCompletedFiltrar,
                    isExpandedFiltrar,
                    () {
                      setState(() {
                        if (!isCompletedFiltrar) {
                          isExpandedFiltrar = !isExpandedFiltrar;
                        }
                      });
                    },
                    () {
                      setState(() {
                        isCompletedFiltrar = true;
                        isExpandedFiltrar = false;
                      });
                    },

                    [
                      buildInstructionStep("· El agua se debe filtrar si se han bañado muchas personas o si el agua no está cristalina."),
                      buildInstructionStep("En cualquiera de estos casos, filtra el agua por 4 horas luego de añadir el cloro y de haberse bañado"),
                    ],
                    Icons.filter_alt_rounded,
                    Color.fromARGB(255, 101, 106, 104),
                    Colors.cyan,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildInstructionTile(
    String title,
    bool completed,
    bool expanded,
    Function onExpandTap,
    Function onCheckTap,
    List<Widget> steps,
    IconData icon,
    Color iconColor,
    Color tileColor,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: completed ? Colors.lightGreen : Colors.white,
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                icon,
                color: completed ? Colors.white : iconColor,
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              trailing: completed
                  ? null
                  : IconButton(
                      icon: Icon(
                        expanded ? Icons.expand_less : Icons.expand_more,
                        color: Colors.white,
                      ),
                      onPressed: () => onExpandTap(),
                    ),
              tileColor: completed ? Colors.green : tileColor,
            ),
            if (expanded && !completed)
              Column(
                children: steps,
              ),
            if (!completed)
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () => onCheckTap(),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.white;
                          }
                          return Colors.black;
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.teal;
                          }
                          return Colors.transparent;
                        },
                      ),
                    ),
                    child: Text("Completar"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildInstructionStep(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
