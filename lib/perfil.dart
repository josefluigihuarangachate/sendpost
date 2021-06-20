// @dart=2.9
import 'package:sendpost/SharedPreferences/storage.dart';
import 'package:sendpost/ajustes.dart';
import 'package:sendpost/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/scheduler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// PONER EN TODOS LOS FLUTTER - OBLIGATORIO
import 'package:sendpost/includes/importante.dart' as variable;
// FIN PONER EN TODOS LOS FLUTTER

FirebaseFirestore firestore = FirebaseFirestore.instance;
//Poner en onTap = print(BuscarDatos('nombre_completo').then((value){
//  print(value);
//}));
// Logout Ejm : https://stackoverflow.com/a/63162551
// EJM TABS BOTTOM: https://stackoverflow.com/a/51825203
// AppBar Poner imagen : https://stackoverflow.com/a/53857335

// STORAGE DATA
TextEditingController _idMysql = new TextEditingController();
TextEditingController _idFirebase = new TextEditingController();

Future<String> getidMysql() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  _idMysql.text = await prefs.getString('idusuario');
  return prefs.getString('idusuario');
}
Future<String> getidFirebase() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  _idFirebase.text = await prefs.getString('fb_uid');
  return prefs.getString('fb_uid');
}

/*Future<String> getUserData() async {
  //final SharedPreferences prefs = await SharedPreferences.getInstance();
  _idMysql.text = MySharedPreferences.readPrefStr("idusuario") ?? null;
  _idFirebase.text = MySharedPreferences.readPrefStr("fb_uid") ?? null;
  cargarSharedPreferences();
  //prefs.reload();
}*/

void cargarSharedPreferences() async {}
// END STORAGE DATA

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Perfil());
}

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new HomePerfil(),
    );
  }
}

class HomePerfil extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomePerfil> {
  // STORAGE DATA
  @override
  void initState() {
    //getUserData();
    super.initState();
    cargarSharedPreferences();
    getidMysql().then((valMysql){
      _idMysql.text = valMysql;
    });
    getidFirebase().then((valFB){
      _idFirebase.text = valFB;
    });

    // SI EL STORAGE ESTA VACIO VUELVO ATRÁS AL LOGIN
    if(
      variable.validarInputs(_idMysql.text) == false ||
      variable.validarInputs(_idFirebase.text) == false
    ){
      SchedulerBinding.instance.addPostFrameCallback((_) {

        Fluttertoast.showToast(
            msg: "Ups! Hubo un error. Intente de nuevo",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0x0ff333333),
            textColor: Color(0x0ffffffff),
            fontSize: 16.0);

        // add your code here.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
        //Navigator.push(
        //    context,
        //    new MaterialPageRoute(
        //        builder: (context) => MyApp()));
      });
    }else{
      // ME LANZARA UN MENSAJE DE BIENVENIDA
      Fluttertoast.showToast(
          msg: "Bienvenido a SendPost",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0x0ff333333),
          textColor: Color(0x0ffffffff),
          fontSize: 16.0);
    }
  }
  // END STORAGE DATA

//class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xFFaa109e),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  variable.logo_texto_blanco.toString(),
                  fit: BoxFit.contain,
                  height: 20,
                ),
                //Container(
                //    padding: const EdgeInsets.all(8.0), child: Text('YourAppTitle')
                //    )
              ],
            ),
            //title: Text("SendPost"),
          ),
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              Container(
                child: Icon(Icons.supervised_user_circle_outlined),
              ),
              Container(
                child: Icon(Icons.emoji_emotions_outlined),
              ),
              Container(child: Icon(Icons.cake)),
              Container(
                child: ListView(
                  children: <Widget>[
                    // ESTO IRA AL PRINCIPIO
                    Card(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    ),
                    // FIN ESTO IRA AL PRINCIPIO
                    Card(
                        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
                          leading: IconButton(
                            icon: Icon(Icons.verified_user),
                            onPressed: () => print('select'),
                          ),
                          title: Text(_idMysql.text),
                          subtitle: Text(
                              'Configuración general de tu cuenta de sendpost',
                              style: TextStyle(fontSize: 12)),
                          //trailing: Icon(
                          //  Icons.arrow_forward_ios,
                          //),
                          onTap: () {

                            print("idFirebase : " + _idFirebase.text);
                            print("idMysql : " + _idMysql.text);

                            /*Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Ajustes()),
                            );
                            BuscarDatos('idusuario').then((val)
                            {
                              print("id usuario : " + val);
                            });
                             */
                          },
                        )),
                    Card(
                        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: new ListTile(
                          contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
                          leading: IconButton(
                            icon: Icon(Icons.help),
                            onPressed: () => print('select'),
                          ),
                          title: Text('Ayuda'),
                          subtitle: Text(
                              'Centro de ayuda, contáctanos, politica de privacidad',
                              style: TextStyle(fontSize: 12)),
                          //trailing: Icon(
                          //  Icons.arrow_forward_ios,
                          //),
                          onTap: () => print('Precionaste Ayuda'),
                        )),
                    Card(
                        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: new ListTile(
                          contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
                          leading: IconButton(
                            icon: Icon(Icons.exit_to_app),
                            onPressed: () => print('select'),
                          ),
                          title: Text('Cerrar Sesión'),
                          subtitle: Text(
                              'Salir de la aplicacion para luego volver a ingresar',
                              style: TextStyle(fontSize: 12)),
                          //trailing: Icon(
                          //  Icons.arrow_forward_ios,
                          //),
                          onTap: () {
                            // Logout Ejm : https://stackoverflow.com/a/63162551
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                                (r) => false);
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Color(0xFFaa109e),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Color(0xffffffff),
        tabs: [
          Tab(
            text: "ChatPost",
            icon: Icon(Icons.chat),
          ),
          Tab(
            text: "Estados",
            icon: Icon(Icons.tag_faces),
          ),
          Tab(
            text: "Especial",
            icon: Icon(Icons.cake),
          ),
          Tab(
            text: "Ajustes",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
