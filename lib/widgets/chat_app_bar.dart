import 'package:chate_com_firebase/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget ChatAppBar(context) => AppBar(
        title: Text('Flutter chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(

                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app_outlined, color:  Colors.black,),
                        SizedBox(width: 8,),
                        Text('Sair'),
                      ],
                    ),
                  ))
              ],
              onChanged: (item){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(AuthScreen.route, (route) => false);
              },
            ),
          )
        ],
      );