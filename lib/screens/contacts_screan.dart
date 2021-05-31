import 'package:chate_com_firebase/screens/chart_screan.dart';
import 'package:chate_com_firebase/widgets/chat_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContactsScrean extends StatelessWidget {
  static String route = '/contacts';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ChatAppBar(context),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').get(),
        builder: (ctx, snapshot){

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs;
          return ListView.separated(
            separatorBuilder:(ctx, i)=> Divider(),
            itemCount: docs.length,
            itemBuilder: (ctx, i){
              return TextButton(
                style: ButtonStyle(alignment: Alignment.centerLeft),
                child: Text(docs[i]['name'], textAlign: TextAlign.start,),
                onPressed: (){

                  Navigator.of(context).pushNamed(ChartScreen.route, arguments: ChartScreenArgs(docs[i].id));
                },
              );
            }
          );
        },
      ),
    );
  }
}