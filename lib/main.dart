// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart.';
import 'package:firebase_core/firebase_core.dart';
import 'package:sendpost/SharedPreferences/storage.dart';
import 'dart:convert';
import 'dart:async';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'perfil.dart';
import 'register.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// PONER EN TODOS LOS FLUTTER - OBLIGATORIO
import 'package:sendpost/includes/importante.dart' as variable;

// PONER ICONO A LA APLICACION
// https://www.it-swarm-es.com/es/flutter/como-cambiar-el-icono-del-iniciador-de-aplicaciones-en-flutter/832241262/
// https://www.youtube.com/watch?v=RjNAxwcP3Tc

FirebaseFirestore firestore = FirebaseFirestore.instance;

// VARIABLES SESSION
Future<String> AlmacenarDatos(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(key.trim() != "" && value.trim() != "") {
    prefs.setString(key, value);
    print('El dato fue almacenado, Gracias.');
  }
  cargarSharedPreferences();
  prefs.reload();
}

void cargarSharedPreferences() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.reload();
}
// FIN VARIABLE SESSION

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

void errorDialog(context, msg) {
  // Example : https://pub.dev/packages/flutter_dialogs/example
  try {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text("Mensaje Importante"),
        content: Text(msg),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("Volver Intentar"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  } catch (e) {
    print(e);
  }
}

// Poner imagen en flutter
// Ejm : https://www.youtube.com/watch?v=Hxh6nNHSUjo

// Emj : Mantener la sesion iniciada
// https://es.stackoverflow.com/a/258365


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
    // Siempre tengo que inicializar el storage - Login - Importante
    AlmacenarDatos("", "");
    super.initState();
    myController.addListener(_printLatestValue);
    usuario.addListener(_printLatestValue);
    password.addListener(_printLatestValue);
    cargarSharedPreferences();
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
    //print("Second text field: ${myController.text}");
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Color(0x0ffae57c9);
      }
      return Color(0x0ffaa109e);
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: new Column(
            // --- CENTRAMOS AL MEDIO DE LA PANTALLA ---
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // -------------------------------------------
            children: <Widget>[
              Container(
                  //child: LoginUser(),
                  ),
              Container(
                padding: new EdgeInsets.all(50.0),
                child: Image(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center, // This is needed
                  image: AssetImage(variable.logo),
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
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                    ),
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

              // CHECKBOX
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (bool value) {
                              setState(() {
                                if (value == true) {
                                  value = false;
                                } else if (value == false) {
                                  value = true;
                                }
                                isChecked = !value;

                                print("El estado de recordar contraseña es : " +
                                    isChecked.toString());
                              });
                            },
                          ),
                          Text(
                            'Recordar contraseña',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ],
                      ),
                    ],
                  )),
              // FIN CHECKBOX

              Container(
                  //-----------------------------------//TOP
                  margin: const EdgeInsets.fromLTRB(0, 22, 0, 0),
                  child: RaisedButton(
                    onPressed: () => {this.fetchData()},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text('INICIAR SESION'),
                    textColor: Colors.white,
                    color: Color(0xffaa109e),
                    padding: EdgeInsets.fromLTRB(84, 17, 84, 17),
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text('-------- Registrate es gratis --------',
                    style: TextStyle(fontSize: 16)),
              ),
              Container(
                  //-----------------------------------//TOP
                  margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: RaisedButton(
                    onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()))
                    },
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

  Future<void> fetchData() async {
    //final response = await http.post("http://localhost:8000/login");

    var txtuser = usuario.text;
    var txtpassword = password.text;

    if (txtuser.trim() != '' && txtpassword.trim() != '') {
      // https://medium.com/@ekosuprastyo15/flutter-json-array-parse-of-objects-dbf36a7aa08d
      var response = await http.get(
          Uri.parse(variable.apirest + "/login" + "/" + txtuser + "/" + txtpassword));

      final data = jsonDecode(response.body);
      if (data['status'] == 'Ok') {
        // Para guardar datos en session storage - Flutter

        MySharedPreferences.instance.setStringValue("idusuario", data['data']['idusuario'].toString());
        MySharedPreferences.instance.setStringValue("fb_uid", data['data']['fb_uid'].toString());
        //AlmacenarDatos("idusuario", data['data']['idusuario'].toString());
        //AlmacenarDatos("fb_uid", data['data']['fb_uid'].toString());

        print("idusuario : " + data['data']['idusuario'].toString());
        print("fb_uid : " + data['data']['fb_uid'].toString());

        // Actualizar datos de logueo - Firebase
        var firebaseUser = FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance
            .collection("usuarios")
            .doc(data['data']['fb_uid'].toString())
            .set({"online": 1}, SetOptions(merge: true));

        // Fin Actualizar datos de logueo Firebase
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Perfil()));
      } else {
        errorDialog(context, data['msg']);
      }
      //print(data['data']);

      //errorDialog(context, response.body);
    } else {
      errorDialog(context, "No debe haber campos vacios");
    }
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
