import 'package:flutter/material.dart';

class MarronPage extends StatefulWidget {
  @override
  _MarronPageState createState() => _MarronPageState();
}

class _MarronPageState extends State<MarronPage> {

  bool showInstructionsPiscinaDeObra = false;

  Color btnColor1 = Color.fromARGB(255, 140, 67, 45); // Color del botón
  double btnSize1 = 70; // Tamaño del botón
  String buttonText1 = "Hierro"; // Texto del botón
  TextStyle buttonTextStyle1 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // Estilo del texto del botón
  bool iconVisible1 = true;
  String Text1 = "Cuando este metal entra en contacto con el cloro ocurre una reacción química que oxida el hierro y tiñe el agua";  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AGUA MARRÓN',
          style: TextStyle(
            fontSize: 35, // Tamaño del título
            fontWeight: FontWeight.bold,
            color: Colors.white, // Color del título
          ),
        ),
        backgroundColor: Color.fromARGB(255, 138, 97, 82),
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
        btnColor1 = Color.fromARGB(255, 140, 67, 45);
        iconVisible1 = true;
        buttonText1 = "Hierro";
        buttonTextStyle1 = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        );
      });
    },
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      textStyle: const TextStyle(
        fontSize: 25,
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
                        buildInstructionStep(Icons.filter_1, "Añadir agua fresca, ya que con este tratamiento se suele perder bastante. Además, no se deberá añadir agua hasta que se haga otra supercloración"),
                        buildInstructionStep(Icons.filter_2, "Ajustar el pH entre 7.2 y 7.6 usando la opción de Mediciones"),
                        buildInstructionStep(Icons.filter_3, "Realizar una supercloración utilizando cloro rápido o de choque según las recomendaciones del fabricante, distribuyéndolo de manera uniforme por toda la piscina"),
                        buildInstructionStep(Icons.filter_4, "Elevar el cloro a 10 ppm para que los metales reaccionen"),
                        buildInstructionStep(Icons.filter_5, "Después de 2 horas deberás medir el cloro para ver que alcanza ese nivel, si no ha llegado añade la mitad del cloro y vuelve a esperar 2 horas"),
                        buildInstructionStep(Icons.filter_6, "Espera 24 horas a que todo el cloro reaccione"),
                        buildInstructionStep(Icons.filter_7, "Usar floculante siguiendo las recomendaciones del fabricante, echando primero en los bordes y acabando por el centro de la piscina"),
                        buildInstructionStep(Icons.filter_8, "Esperar de 16 a 24 horas hasta que el agua quede cristalina y el metal esté en el fondo de la piscina"),
                        buildInstructionStep(Icons.filter_8, "Retirar las partículas que están en el fondo con el limpiafondos teniendo el filtro en vaciado/waste/drenaje"),
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
                text: "Realizar pruebas regulares del agua para controlar los niveles de hierro",
                icon: Icons.sync_rounded,
              ),
              _buildPreventionButton(
                text: "Usar productos secuestrantes de hierro para prevenir la oxidación",
                icon: Icons.science_outlined,
              ),
              _buildPreventionButton(
                text: "No añadir agua hasta realizar otra supercloración",
                icon: Icons.dangerous_outlined,
              ),
              _buildPreventionButton(
                text: "Asegurarse que el sistema de filtración funciona correctamente y está limpio",
                icon: Icons.cleaning_services_rounded,
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
        color: Color.fromARGB(255, 208, 171, 115),
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