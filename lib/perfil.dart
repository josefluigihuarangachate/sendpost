// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(Perfil());

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Profile',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Profile'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
