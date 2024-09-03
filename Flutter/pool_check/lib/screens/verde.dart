import 'package:flutter/material.dart';

class VerdePage extends StatefulWidget {
  @override
  _VerdePageState createState() => _VerdePageState();
}

class _VerdePageState extends State<VerdePage> {

  bool showInstructionsPiscinaDeObra = false;

  Color btnColor1 = Color.fromARGB(255, 40, 186, 96); // Color del botón
  double btnSize1 = 70; // Tamaño del botón
  String buttonText1 = "Algas"; // Texto del botón
  TextStyle buttonTextStyle1 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible1 = true;
  String Text1 = "El agua verde indica la presencia de algas en la piscina";

  Color btnColor2 = Color.fromARGB(255, 40, 186, 96); // Color del botón
  double btnSize2 = 70; // Tamaño del botón
  String buttonText2 = "Falta de circulación"; // Texto del botón
  TextStyle buttonTextStyle2 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible2 = true;
  String Text2 = "Si el agua no se mueve puede provocar que los productos químicos no se distribuyan correctamente o que haya una acumulación de nutrientes";

  Color btnColor3 = Color.fromARGB(255, 40, 186, 96); // Color del botón
  double btnSize3 = 70; // Tamaño del botón
  String buttonText3 = "  Poco cloro"; // Texto del botón
  TextStyle buttonTextStyle3 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible3 = true;
  String Text3 = "El agua que no está bien desinfectada permite que las algas proliferen";
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AGUA VERDE',
          style: TextStyle(
            fontSize: 35, // Tamaño del título
            fontWeight: FontWeight.bold,
            color: Colors.white, // Color del título
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 136, 188, 76),
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
      body: SingleChildScrollView(
  child: Column(
    children: [
      // Texto "CAUSAS" centrado verticalmente
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Text(
          "CAUSAS",
          style: TextStyle(color: Colors.black, fontFamily: 'montserrat', fontSize: 23),
        ),
      ),
      // Texto largo con margen simétrico, bordes redondeados y sombra
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [

            // PRIMER BOTON
              const SizedBox(height: 10),
              SizedBox(
                width: 350, // Ancho del botón
                height: btnSize1, // Altura del botón
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      btnSize1 = 70;
                      btnColor1 = Color.fromARGB(255, 40, 186, 96);
                      iconVisible1 = true;
                      buttonText1 = "Algas";
                      buttonTextStyle1 = TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      );
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'Montserrat',
                    ),
                    backgroundColor: btnColor1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordes ligeramente redondeados
                    ),
                  ),
                   child: Stack(
      children: [
        Center(
          child: Text(
            buttonText1,
            textAlign: TextAlign.center,
            style: buttonTextStyle1,
          ),
        ),
        Positioned(
          left: 8.0, // Posición del icono desde la izquierda
          top: 8.0,  // Posición del icono desde la parte superior
          child: Visibility(
            visible: iconVisible1,
            child: IconButton(
              icon: Icon(Icons.info),
              color: Colors.white,
              iconSize: 35,
              onPressed: () {
                setState(() {
                  btnSize1 = btnSize1 == 70 ? 100 : 70; // Cambia el tamaño del botón
                  btnColor1 = Colors.grey.shade300;
                  buttonText1 = btnSize1 == 100 ? Text1 : "Hierro";
                  iconVisible1 = false;
                  buttonTextStyle1 = TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ); // Cambia el estilo del texto del botón
                });
              },
            ),
          ),
        ),
      ],
    ),
  ),
),
              // SEGUNDO BOTON
              const SizedBox(height: 10),
              SizedBox(
                width: 350, // Ancho del botón
                height: btnSize2, // Altura del botón
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      btnSize2 = 70;
                      btnColor2 = Color.fromARGB(255, 40, 186, 96);
                      iconVisible2 = true;
                      buttonText2 = "Falta de circulación";
                      buttonTextStyle2 = TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      );
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'Montserrat',
                    ),
                    backgroundColor: btnColor2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordes ligeramente redondeados
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0), // Añadir padding para alejar el icono del borde
                        child: Visibility(
                          visible: iconVisible2,
                          child: IconButton(
                            icon: Icon(Icons.info),
                            color: Colors.white,
                            iconSize: 35,
                            onPressed: () {
                              setState(() {
                                btnSize2 = btnSize2 == 70 ? 110 : 70; // Cambia el tamaño del botón
                                btnColor2 = Colors.grey.shade300;
                                buttonText2 = btnSize2 == 110 ? Text2 : "Falta de circulación";
                                iconVisible2 = false;
                                buttonTextStyle2 = TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ); // Cambia el estilo del texto del botón
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          buttonText2,
                          textAlign: TextAlign.center,
                          style: buttonTextStyle2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // TERCER BOTON
              const SizedBox(height: 10),
              SizedBox(
                width: 350, // Ancho del botón
                height: btnSize3, // Altura del botón
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      btnSize3 = 70;
                      btnColor3 = Color.fromARGB(255, 40, 186, 96);
                      iconVisible3 = true;
                      buttonText3 = "  Poco cloro";
                      buttonTextStyle3 = TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      );
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'Montserrat',
                    ),
                    backgroundColor: btnColor3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordes ligeramente redondeados
                    ),
                  ),
                   child: Stack(
      children: [
        Center(
          child: Text(
            buttonText3,
            textAlign: TextAlign.center,
            style: buttonTextStyle3,
          ),
        ),
        Positioned(
          left: 8.0, // Posición del icono desde la izquierda
          top: 8.0,  // Posición del icono desde la parte superior
          child: Visibility(
            visible: iconVisible3,
            child: IconButton(
              icon: Icon(Icons.info),
              color: Colors.white,
              iconSize: 35,
              onPressed: () {
                setState(() {
                  btnSize3 = btnSize3 == 70 ? 100 : 70; // Cambia el tamaño del botón
                  btnColor3 = Colors.grey.shade300;
                  buttonText3 = btnSize3 == 100 ? Text3 : "  Poco cloro";
                  iconVisible3 = false;
                  buttonTextStyle3 = TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ); // Cambia el estilo del texto del botón
                });
              },
            ),
          ),
        ),
      ],
    ),
  ),
),
          ],
          
        ),
      ),
      const SizedBox(height: 20),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Text(
          "SOLUCIÓN",
          style: TextStyle(color: Colors.black, fontFamily: 'montserrat', fontSize: 23),
        ),
      ),
     buildInstructionTile(
                "Paso a paso",
                showInstructionsPiscinaDeObra,
                Icons.construction_outlined,
                () {
                  setState(() {
                    showInstructionsPiscinaDeObra = !showInstructionsPiscinaDeObra;
                  });
                },
                showInstructionsPiscinaDeObra
                    ? [
                        buildInstructionStep(Icons.filter_1, "Ajustar el pH entre 7.2 y 7.6 usando la opción de Mediciones"),
                        buildInstructionStep(Icons.filter_2, "Con la ayuda de un limpiafondos o cepillo realiza una limpieza para faciliar la eliminación de algas"),
                        buildInstructionStep(Icons.filter_3, "Realizar una supercloración utilizando cloro rápido o de choque según las recomendaciones del fabricante, distribuyéndolo de manera uniforme por toda la piscina"),
                        buildInstructionStep(Icons.filter_4, "Si tienes bomba hay que filtrar el agua por 12 horas y esperar un día entero (cada 4 horas hacer descansos de 1 hora). Si no tienes bomba simplemente espera 24 horas para que haga efecto"),
                        buildInstructionStep(Icons.filter_5, "Usar floculante siguiendo las recomendaciones del fabricante, echando primero en los bordes y acabando por el centro de la piscina"),
                        buildInstructionStep(Icons.filter_6, "Dejar el agua en reposo con la bomba apagada por 16 horas (si no está totalmente clara esperar 24 horas)"),
                        buildInstructionStep(Icons.filter_7, "Aspirar los restos de algas que están en el fondo con el limpiafondos teniendo el filtro en vaciado/waste/drenaje"),
                        buildInstructionStep(Icons.filter_8, "Por último, poner el filtro en modo filtración y esperar a que el cloro baje a 3ppm"),
                      ]
                    : null,
              ),
      const SizedBox(height: 20),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Text(
          "PREVENCIÓN",
          style: TextStyle(color: Colors.black, fontFamily: 'montserrat', fontSize: 23),
        ),
      ),
      Padding(
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  child: Column(
    children: [
       _buildPreventionButton(
                text: "Hacer un tratamiento antialgas 2 o 3 veces al mes (si el desinfectante no tiene)",
                icon: Icons.calendar_month,
              ),
              _buildPreventionButton(
                text: "Limpiar regularmente la piscina y una limpieza profunda una vez por semana",
                icon: Icons.cleaning_services_rounded,
              ),
              _buildPreventionButton(
                text: "Usar cobertores solares cuando no se usa la piscina",
                icon: Icons.wb_twilight_rounded,
              ),
    ],
  ),
)
    ],
  ),
), );  
  }
}

Widget _buildPreventionButton({required String text, required IconData icon}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 122, 210, 162),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Gothic',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }



Widget buildInstructionTile(String title, bool expanded, IconData icon, Function onTap, List<Widget>? steps) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon),
            title: Text(title),
            trailing: Icon(expanded ? Icons.expand_less : Icons.expand_more),
            onTap: () => onTap(),
          ),
          if (expanded)
            Column(
              children: steps ?? [],
            ),
        ],
      ),
    ),
  );
}

Widget buildInstructionStep(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
    );
  }