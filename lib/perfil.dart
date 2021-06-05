// @dart=2.9
import 'package:sendpost/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart.';
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

// EJM TABS BOTTOM: https://stackoverflow.com/a/51825203

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Perfil());
}


FirebaseFirestore firestore = FirebaseFirestore.instance;

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xFFaa109e),
            title: Text("SendPost"),
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
                        child: new ListTile(
                          contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
                          leading: IconButton(
                            icon: Icon(Icons.help),
                            onPressed: () => print('select'),
                          ),
                          title: Text('Ayuda'),
                          subtitle: Text(
                              'Centro de ayuda, contáctanos, politica de privacidad',
                              style: TextStyle(fontSize: 12)
                          ),
                          //trailing: Icon(
                          //  Icons.arrow_forward_ios,
                          //),
                          onTap: () => print('Precionaste Ayuda'),
                        )
                    ),
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
                              style: TextStyle(fontSize: 12)
                          ),
                          //trailing: Icon(
                          //  Icons.arrow_forward_ios,
                          //),
                          onTap: () {

                            // Logout Ejm : https://stackoverflow.com/a/63162551
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) => MyApp()), (r) => false);
                          },
                        )
                    ),
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
            text: "Cumpleaños",
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
