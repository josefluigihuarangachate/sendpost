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

void main() => runApp(Ajustes());
class Ajustes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xFFaa109e),
            title: Text("Ajustes"),
          ),
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              Container(
                  child: Icon(Icons.directions_car)
              ),
              Container(
                  child: Icon(Icons.directions_transit)
              ),
              Container(
                  child: Icon(Icons.directions_bike)
              ),
              Container(
                  child: Icon(Icons.directions_bike)
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
  } }