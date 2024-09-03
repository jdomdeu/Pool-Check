import 'package:flutter/material.dart';

class SuciedadPage extends StatefulWidget {
  @override
  _SuciedadPageState createState() => _SuciedadPageState();
}

class _SuciedadPageState extends State<SuciedadPage> {

  bool showInstructionsPiscinaDeObra = false;
  bool showInstructionsPiscinaDeLiner = false;

  Color btnColor1 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize1 = 70; // Tamaño del botón
  String buttonText1 = "Acumulación de aceites o cremas solares"; // Texto del botón
  TextStyle buttonTextStyle1 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible1 = true;
  String Text1 = "Estos productos pueden adherirse a los bordes";

  Color btnColor2 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize2 = 70; // Tamaño del botón
  String buttonText2 = "Lluvia"; // Texto del botón
  TextStyle buttonTextStyle2 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible2 = true;
  String Text2 = "El agua de lluvia puede arrastrar tierra y suciedad en la piscina acumulándola en los bordes";

  Color btnColor3 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize3 = 70; // Tamaño del botón
  String buttonText3 = "Falta de depuración"; // Texto del botón
  TextStyle buttonTextStyle3 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible3 = true;
  String Text3 = "Si no se filtra el agua regularmente es fácil que la suciedad se acumule";

  Color btnColor4 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize4 = 70; // Tamaño del botón
  String buttonText4 = "Productos químicos"; // Texto del botón
  TextStyle buttonTextStyle4 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible4 = true;
  String Text4 = "Normalmente ocurren por exceso de cobre en el agua";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SUCIEDAD',
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
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Text(
          "Manchas amarillas o negras",
          style: TextStyle(color: Colors.black, fontFamily: 'montserrat', fontSize: 20),
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
                      btnColor1 = Color.fromARGB(255, 143, 206, 215);
                      iconVisible1 = true;
                      buttonText1 = "Acumulación de aceites o cremas solares";
                      buttonTextStyle1 = TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      );
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      fontSize: 21,
                      fontFamily: 'Montserrat',
                    ),
                    backgroundColor: btnColor1,
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
                          visible: iconVisible1,
                          child: IconButton(
                            icon: Icon(Icons.info),
                            color: Colors.white,
                            iconSize: 35,
                            onPressed: () {
                              setState(() {
                                btnSize1 = btnSize1 == 70 ? 80 : 70; // Cambia el tamaño del botón
                                btnColor1 = Colors.grey.shade300;
                                buttonText1 = btnSize1 == 80 ? Text1 : "Acumulación de aceites o cremas solares";
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
                      Expanded(
                        child: Text(
                          buttonText1,
                          textAlign: TextAlign.center,
                          style: buttonTextStyle1,
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
                height: btnSize3, // Altura del botón
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      btnSize3 = 70;
                      btnColor3 = Color.fromARGB(255, 143, 206, 215);
                      iconVisible3 = true;
                      buttonText3 = "Falta de duración";
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0), // Añadir padding para alejar el icono del borde
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
                                buttonText3 = btnSize3 == 100 ? Text3 : "Falta de depuración";
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
                      Expanded(
                        child: Text(
                          buttonText3,
                          textAlign: TextAlign.center,
                          style: buttonTextStyle3,
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
                height: btnSize2, // Altura del botón
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      btnSize2 = 70;
                      btnColor2 = Color.fromARGB(255, 143, 206, 215);
                      iconVisible2 = true;
                      buttonText2 = "Lluvia";
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
                  child: Stack(
      children: [
        Center(
          child: Text(
            buttonText2,
            textAlign: TextAlign.center,
            style: buttonTextStyle2,
          ),
        ),
        Positioned(
          left: 8.0, // Posición del icono desde la izquierda
          top: 8.0,  // Posición del icono desde la parte superior
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
                  buttonText2 = btnSize2 == 100 ? Text2 : "Lluvia";
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
      ],
    ),
  ),
),
              const SizedBox(height: 12),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 14.0),
                child: Text(
                  "Manchas lilas o verdes",
                  style: TextStyle(color: Colors.black, fontFamily: 'montserrat', fontSize: 20),
                ),
              ),
              // CUARTO BOTON
              const SizedBox(height: 10),
              SizedBox(
                width: 350, // Ancho del botón
                height: btnSize4, // Altura del botón
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      btnSize4 = 70;
                      btnColor4 = Color.fromARGB(255, 143, 206, 215);
                      iconVisible4 = true;
                      buttonText4 = "Productos químicos";
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
                                btnSize4 = btnSize4 == 70 ? 80 : 70; // Cambia el tamaño del botón
                                btnColor4 = Colors.grey.shade300;
                                buttonText4 = btnSize4 == 80 ? Text4 : "Productos químicos";
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
              "Piscina de obra",
              showInstructionsPiscinaDeObra,
              Icons.construction_outlined,
              () {
                setState(() {
                  showInstructionsPiscinaDeObra = !showInstructionsPiscinaDeObra;
                });
              },
              showInstructionsPiscinaDeObra
                  ? [
                      buildInstructionStep(Icons.filter_1, "Rebajar el nivel de agua unos 5 centímetros para que las áreas afectadas estén totalmente expuestas"),
                      buildInstructionStep(Icons.filter_2, "Se pueden eliminar las manchas con distintos productos:"),
                      buildInstructionStep(Icons.local_drink_rounded, "Detergentes alcalinos: Sirven para eliminar la suciedad mineral (como depósitos de cal u óxido)"),
                      buildInstructionStep(Icons.medication_rounded, "Gel desinfectante: Útil para limpiar manchas amarillas en los bordes causadas por grasa o aceites"),
                      buildInstructionStep(Icons.eco_rounded, "Pool’gom: Es una opción que sustituye a los productos químicos"),
                      buildInstructionStep(Icons.filter_3, "Estos productos pueden aplicarse mediante pulverización, disolución en el agua o frotando directamente en la pared"),
                      buildInstructionStep(Icons.filter_4, "Si la mancha persiste aplica el producto y déjalo actuar por media hora. Después frota con una toalla, esponja o cepillo"),
                      buildInstructionStep(Icons.filter_5, "Enjuaga los bordes con agua limpia para quitar residuos"),
                      buildInstructionStep(Icons.filter_6, "Seca los bordes y vuelve a llenar la piscina a su nivel habitual"),
                    ]
                  : null,
            ),
            SizedBox(height: 12),
            buildInstructionTile(
              "Piscina de liner",
              showInstructionsPiscinaDeLiner,
              Icons.fit_screen_rounded,
              () {
                setState(() {
                  showInstructionsPiscinaDeLiner = !showInstructionsPiscinaDeLiner;
                });
              },
              showInstructionsPiscinaDeLiner
                  ? [
                      buildInstructionStep(Icons.filter_1, "La principal diferencia es no usar limpiadores abrasivos o utensilios de limpieza duros como cepillos metálicos"),
                      buildInstructionStep(Icons.filter_2, "Usar una esponja húmeda y aplicar el limpiador que se vaya a usar"),
                      buildInstructionStep(Icons.filter_3, "Frotar suavemente el liner en forma de círculos"),
                      buildInstructionStep(Icons.filter_4, "Una vez se haya frotado (y repetido el proceso si hace falta), es recomendable enjuagar con agua limpia para eliminar residuos"),
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
                text: "Limpiar regularmente para que la suciedad no se incruste, siendo más difícil eliminarla",
                icon: Icons.cleaning_services_rounded,
              ),
              _buildPreventionButton(
                text: "Tener el pH y el cloro nivelados",
                icon: Icons.equalizer_rounded,
              ),
              _buildPreventionButton(
                text: "Poner una cubierta cuando llueve para que no entre suciedad",
                icon: Icons.water_damage_rounded,
              ),
    ],
  ),
)
    ],
  ),
),
      );    
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