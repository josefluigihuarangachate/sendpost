import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart.';

void main() => runApp(MyApp());

// Poner imagen en flutter
// Ejm : https://www.youtube.com/watch?v=Hxh6nNHSUjo
String logo = 'assets/images/logo.png';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define un widget de formulario personalizado
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define una clase de estado correspondiente. Esta clase contendrá los datos relacionados
// con nuestro formulario.
class _MyCustomFormState extends State<MyCustomForm> {
  // Crea un controlador de texto. Lo usaremos para recuperar el valor actual
  // del TextField!
  final myController = TextEditingController();
  final usuario = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
    usuario.addListener(_printLatestValue);
    password.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    // Esto también elimina el listener _printLatestValue
    myController.dispose();
    usuario.dispose();
    password.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: SingleChildScrollView(
            child: new Column(
              // --- CENTRAMOS AL MEDIO DE LA PANTALLA ---
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // -------------------------------------------
              children: <Widget>[
                Container(
                  padding: new EdgeInsets.all(50.0),
                  child: Image(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center, // This is needed
                    image: AssetImage(logo),
                    height: 100,
                  ),
                ),
                Container(
                  child: const Text(
                    'Bienvenido!',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 22),
                  ),
                ),
                Container(
                  child: const Text(
                    'Ingrese con tu cuenta',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 12),
                  ),
                ),
                Container(
                  child: const Text(
                    '\n',
                  ),
                ),
                Container(
                  child: TextField(
                    inputFormatters: [
                      BlacklistingTextInputFormatter(RegExp(r"\s"))
                    ],
                    controller: usuario,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0x0ffaa109e),
                    ),
                    decoration: const InputDecoration(
                      //labelText: 'USUARIO',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      // prefixIcon: Icon(Icons.account_circle_outlined),
                      prefixIcon: Icon(Icons.account_circle_outlined,),
                      hintText: "Usuario",
                      hintStyle: TextStyle(color: Colors.grey),
                      //hintText: 'Ingrese un usuario',
                      // Default Color underline
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                      ),
                      // Focus Color underline
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0x0fffc00f8e)),
                      ),
                    ),
                    onChanged: (valor) {
                      //var val = usuario.text;
                      //print("Usuario: " + usuario.text);
                    },
                  ),
                ),
                Container(
                  child: const Text(
                    '\n',
                  ),
                ),
                Container(

                  child: TextField(
                    inputFormatters: [
                      BlacklistingTextInputFormatter(RegExp(r"\s"))
                    ],
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0x0ffaa109e),
                    ),
                    obscureText: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //labelText: 'CONTRASEÑA',
                      hintText: "Contraseña",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.visibility_off,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                      ),
                      // Focus Color underline
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0x0fffc00f8e)),
                      ),
                    ),
                    controller: password,
                  ),
                ),
                Container(
                    //-----------------------------------//TOP
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: RaisedButton(
                      onPressed: () => {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text('INICIAR SESION'),
                      textColor: Colors.white,
                      color: Color(0xffaa109e),
                      padding: EdgeInsets.fromLTRB(84, 17, 84, 17),
                    )
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Text('-------- Registrate es gratis --------',
                        style: TextStyle(fontSize: 16)),
                ),

                Container(
                    //-----------------------------------//TOP
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: RaisedButton(
                      onPressed: () => {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text('REGISTRATE AQUI'),
                      textColor: Colors.white,
                      // Ejm: Color(0xff"TU COLOR HEX")
                      color: Color(0xffea0c70),
                      padding: EdgeInsets.fromLTRB(75, 17, 75, 17),
                    )),
              ],
            ),
        ),
      ),
    );
  }
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.black87,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);
