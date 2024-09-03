import 'package:flutter/material.dart';

class EspumaPage extends StatefulWidget {
  @override
  _EspumaPageState createState() => _EspumaPageState();
}

class _EspumaPageState extends State<EspumaPage> {

  bool showInstructionsPiscinaDeObra = false;

  Color btnColor1 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize1 = 70; // Tamaño del botón
  String buttonText1 = "Desequilibrio químico"; // Texto del botón
  TextStyle buttonTextStyle1 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible1 = true;
  String Text1 = "Tener mal el cloro o el pH permite que se forme espuma en el agua";

  Color btnColor2 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize2 = 70; // Tamaño del botón
  String buttonText2 = "Productos de baja calidad"; // Texto del botón
  TextStyle buttonTextStyle2 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible2 = true;
  String Text2 = "Muchas veces no cumplen con los requerimientos de la piscina al introducir aditivos no deseados";

  Color btnColor3 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize3 = 70; // Tamaño del botón
  String buttonText3 = "    Demasiado alguicida"; // Texto del botón
  TextStyle buttonTextStyle3 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible3 = true;
  String Text3 = "No cumplir con la dosis recomendada puede reducir la tensión superficial del agua debido a los surfactantes";

  Color btnColor4 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize4 = 70; // Tamaño del botón
  String buttonText4 = "Altos niveles de material orgánico"; // Texto del botón
  TextStyle buttonTextStyle4 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible4 = true;
  String Text4 = "Estos pueden provenir de los propios bañistas, ya que el sudor o productos químicos (bronceadores, cremas, laca, desodorante, maquillaje, …) dejan residuos en el agua";

  Color btnColor5 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize5 = 70; // Tamaño del botón
  String buttonText5 = "Detergentes residuales"; // Texto del botón
  TextStyle buttonTextStyle5 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible5 = true;
  String Text5 = "Los residuos de detergente que se pueden quedar en la piel de los bañistas o bañadores pueden formar espuma en la piscina";
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ESPUMA',
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


              // SEGUNDO BOTON
              const SizedBox(height: 10),
              SizedBox(
                width: 350, // Ancho del botón
                height: btnSize2, // Altura del botón
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      btnSize2 = 70;
                      btnColor2 = Color.fromARGB(255, 143, 206, 215);
                      iconVisible2 = true;
                      buttonText2 = "Productos de baja calidad";
                      buttonTextStyle2 = TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      );
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      fontSize: 20,
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
                                btnSize2 = btnSize2 == 70 ? 100 : 70; // Cambia el tamaño del botón
                                btnColor2 = Colors.grey.shade300;
                                buttonText2 = btnSize2 == 100 ? Text2 : "Productos de baja calidad";
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
                      btnColor3 = Color.fromARGB(255, 143, 206, 215);
                      iconVisible3 = true;
                      buttonText3 = "    Demasiado alguicida";
                      buttonTextStyle3 = TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      );
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      fontSize: 20,
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
                  buttonText3 = btnSize3 == 100 ? Text3 : "    Demasiado alguicida";
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

              // CUARTO BOTON
              const SizedBox(height: 15),
              SizedBox(
                width: 350, // Ancho del botón
                height: btnSize4, // Altura del botón
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      btnSize4 = 70;
                      btnColor4 = Color.fromARGB(255, 143, 206, 215);
                      iconVisible4 = true;
                      buttonText4 = "Altos niveles de material orgánico";
                      buttonTextStyle4 = TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      );
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                    ),
                    backgroundColor: btnColor4,
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
                          visible: iconVisible4,
                          child: IconButton(
                            icon: Icon(Icons.info),
                            color: Colors.white,
                            iconSize: 35,
                            onPressed: () {
                              setState(() {
                                btnSize4 = btnSize4 == 70 ? 110 : 70; // Cambia el tamaño del botón
                                btnColor4 = Colors.grey.shade300;
                                buttonText4 = btnSize4 == 110 ? Text4 : "Altos niveles de material orgánico";
                                iconVisible4 = false;
                                buttonTextStyle4 = TextStyle(
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
                          buttonText4,
                          textAlign: TextAlign.center,
                          style: buttonTextStyle4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // QUINTO BOTON
              const SizedBox(height: 15),
              SizedBox(
                width: 350, // Ancho del botón
                height: btnSize5, // Altura del botón
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      btnSize5 = 70;
                      btnColor5 = Color.fromARGB(255, 143, 206, 215);
                      iconVisible5 = true;
                      buttonText5 = "Detergentes residuales";
                      buttonTextStyle5 = TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      );
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                    ),
                    backgroundColor: btnColor5,
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
                          visible: iconVisible5,
                          child: IconButton(
                            icon: Icon(Icons.info),
                            color: Colors.white,
                            iconSize: 35,
                            onPressed: () {
                              setState(() {
                                btnSize5 = btnSize5 == 70 ? 100 : 70; // Cambia el tamaño del botón
                                btnColor5 = Colors.grey.shade300;
                                buttonText5 = btnSize5 == 100 ? Text5 : "Detergentes residuales";
                                iconVisible5 = false;
                                buttonTextStyle5 = TextStyle(
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
                          buttonText5,
                          textAlign: TextAlign.center,
                          style: buttonTextStyle5,
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
                        buildInstructionStep(Icons.filter_2, "Limpiar la superfície del agua para eliminar aceites y otros contaminantes"),
                        buildInstructionStep(Icons.filter_3, "Limpiar el filtro para reducir la acumulación de contaminantes y si es necesario cambia la arena o el vidrio"),
                        buildInstructionStep(Icons.filter_4, "Realizar una supercloración con cloro rápido o de choque según las recomendaciones del fabricante, distribuyéndolo de manera uniforme por toda la piscina"),
                        buildInstructionStep(Icons.filter_5, "Si tienes bomba hay que filtrar el agua por 12 horas y esperar un día entero (cada 4 horas hacer descansos de 1 hora). Si no tienes bomba simplemente espera 24 horas para que haga efecto"),
                        buildInstructionStep(Icons.filter_6, "Si nada ha funcionado se puede usar anti-espumante para piscinas. Siguiendo las instrucciones del fabricante se puede eliminar la espuma de la superfície"),
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
                text: "Ducharse antes de entrar a la piscina para eliminar residuos",
                icon: Icons.shower_rounded ,
              ),
              _buildPreventionButton(
                text: "Tener el pH y el cloro nivelados",
                icon: Icons.equalizer_rounded,
              ),
              _buildPreventionButton(
                text: "Reducir el uso de productos químicos",
                icon: Icons.compost_rounded,
              ),
              _buildPreventionButton(
                text: "Usar productos de calidad y que no causen espuma",
                icon: Icons.bubble_chart_outlined,
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
        color: Color.fromARGB(255, 239, 166, 171),
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