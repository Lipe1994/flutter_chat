import 'package:flutter/material.dart';

class Credit extends StatelessWidget {
  static String route = '/credit';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Créditos'),
            Text('Estudos de flutter com firebase',),
          ],
        )),
      ),
    );
  }
}