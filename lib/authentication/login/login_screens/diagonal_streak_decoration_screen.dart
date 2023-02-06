

import 'package:flutter/material.dart';

class DiagonalStreakDecorationScreen extends StatelessWidget{
  final Widget child;
  const DiagonalStreakDecorationScreen(
    {Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.blueAccent,
                Colors.white,
                // Color.fromARGB(255, 23, 198, 99),
                // Color.fromARGB(255, 57, 195, 213)
              ])  
          ),
              child: child,);
     
  }         
}