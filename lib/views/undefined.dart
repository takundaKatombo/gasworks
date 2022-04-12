import 'package:flutter/material.dart';

class Undefined extends StatelessWidget {
  const Undefined({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text("Undefined Route"),
          ),
        ],
      ),
    );
  }
}
