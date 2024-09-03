import 'package:flutter/material.dart';

class IrritarPage extends StatefulWidget {
  @override
  _IrritarPageState createState() => _IrritarPageState();
}

class _IrritarPageState extends State<IrritarPage> {
  bool showInstructionsPiscinaDeObra = false;

  Color btnColor1 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize1 = 70; // Tamaño del botón
  String buttonText1 = "Exceso de Cloro Total"; // Texto del botón
  TextStyle buttonTextStyle1 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible1 = true;
  String Text1 = "Tener niveles demasiado altos de cloro u otros desinfectantes ";

  Color btnColor2 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize2 = 70; // Tamaño del botón
  String buttonText2 = "Cloro Libre muy bajo"; // Texto del botón
  TextStyle buttonTextStyle2 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible2 = true;
  String Text2 = "Si el agua no está bien desinfectada permite la presencia de cloraminas";

  Color btnColor4 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize4 = 70; // Tamaño del botón
  String buttonText4 = "   Contaminantes"; // Texto del botón
  TextStyle buttonTextStyle4 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible4 = true;
  String Text4 = "Si en el agua hay bacterias, algas, sudor, orina u otros ";

  Color btnColor5 = Color.fromARGB(255, 145, 197, 203); // Color del botón
  double btnSize5 = 70; // Tamaño del botón
  String buttonText5 = "    Filtros sucios"; // Texto del botón
  TextStyle buttonTextStyle5 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible5 = true;
  String Text5 = "Un mal mantenimiento de los filtros permite que los contaminantes permanezcan en el agua";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IRRITACIÓN',
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
                      buttonText1 = "Exceso de Cloro Total";
                      buttonTextStyle1 = TextStyle(
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
                                buttonText1 = btnSize1 == 80 ? Text1 : "Exceso de Cloro Total";
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
                      buttonText2 = "Cloro Libre muy bajo";
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
                                btnSize2 = btnSize2 == 70 ? 80 : 70; // Cambia el tamaño del botón
                                btnColor2 = Colors.grey.shade300;
                                buttonText2 = btnSize2 == 80 ? Text2 : "Cloro Libre muy bajo";
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
                      buttonText4 = "   Contaminantes";
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
                   child: Stack(
      children: [
        Center(
          child: Text(
            buttonText4,
            textAlign: TextAlign.center,
            style: buttonTextStyle4,
          ),
        ),
        Positioned(
          left: 8.0, // Posición del icono desde la izquierda
          top: 8.0,  // Posición del icono desde la parte superior
          child: Visibility(
            visible: iconVisible4,
            child: IconButton(
              icon: Icon(Icons.info),
              color: Colors.white,
              iconSize: 35,
              onPressed: () {
                setState(() {
                  btnSize4 = btnSize4 == 70 ? 100 : 70; // Cambia el tamaño del botón
                  btnColor4 = Colors.grey.shade300;
                  buttonText4 = btnSize4 == 100 ? Text4 : "   Contaminantes";
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
      ],
    ),
  ),
),

              // QUINTO BOTON
              const SizedBox(height: 10),
              SizedBox(
                width: 350, // Ancho del botón
                height: btnSize5, // Altura del botón
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      btnSize5 = 70;
                      btnColor5 = Color.fromARGB(255, 143, 206, 215);
                      iconVisible5 = true;
                      buttonText5 = "    Filtros sucios";
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
                  child: Stack(
      children: [
        Center(
          child: Text(
            buttonText5,
            textAlign: TextAlign.center,
            style: buttonTextStyle5,
          ),
        ),
        Positioned(
          left: 8.0, // Posición del icono desde la izquierda
          top: 8.0,  // Posición del icono desde la parte superior
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
                  buttonText5 = btnSize5 == 100 ? Text5 : "    Filtros sucios";
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
                        buildInstructionStep(Icons.filter_2, "Si los niveles de cloro están demasiado altos agregar agua fresca para reducir la concentración. También se puede utilizar un neutralizador de cloro"),
                        buildInstructionStep(Icons.filter_3, "Si el Cloro Libre es muy bajo hay que usar cloro rápido o de choque para realizar una supercloración. Haciendo caso de las recomedaciones del fabricante hay que repartir el producto por toda la piscina de forma equitativa"),
                        buildInstructionStep(Icons.filter_4, "Si tienes bomba hay que filtrar el agua por 12 horas y esperar un día entero (cada 4 horas hacer descansos de 1 hora). Si no tienes bomba simplemente espera 24 horas para que haga efecto"),
                        buildInstructionStep(Icons.filter_5, "Dejar el agua en reposo con la bomba apagada por 16 horas (si no está totalmente clara esperar 24 horas)"),
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
                text: "Tener el pH y el cloro nivelados",
                icon: Icons.equalizer_rounded,
              ),
              _buildPreventionButton(
                text: "Asegurarse que el sistema de filtración funciona correctamente y está limpio",
                icon: Icons.cleaning_services_rounded,
              ),
              _buildPreventionButton(
                text: "Tener una óptima filtración durante 6 u 8 horas diarias",
                icon: Icons.access_time,
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