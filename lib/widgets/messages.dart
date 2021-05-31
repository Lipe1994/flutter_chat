import 'package:chate_com_firebase/screens/chart_screan.dart';
import 'package:chate_com_firebase/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final String destinatarioId;
  final firestore = FirebaseFirestore.instance;

  Messages(this.destinatarioId);
  

  @override
  Widget build(BuildContext context) {
      
    var user = FirebaseAuth.instance.currentUser;
    var userId = user.uid ?? '';
    var query = firestore.collection('chate')
        .where('chave', whereIn: [destinatarioId+';'+userId, userId+';'+destinatarioId]);

    return StreamBuilder(
      stream: query.snapshots(),
      builder: (ctx, snapshot){

        if(snapshot.connectionState == ConnectionState.waiting){

          return Center(child: CircularProgressIndicator());
        }

      AsyncSnapshot<QuerySnapshot> docs = snapshot;


        if(snapshot.hasData){
          var mensagens = docs.data.docs;

          mensagens.sort((b, a) => a['createdAt'].compareTo(b['createdAt']));

          return ListView.separated(
            reverse: true,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: mensagens.length,
            itemBuilder: (ctx, i){
              return Message(message: mensagens[i]['texto'], name:mensagens[i]['userName'], urlImage: mensagens[i]['userImage'], belongsToMe: user.uid == mensagens[i]['userId'], key: ValueKey(mensagens[0].id));

            });
        }else{

          return Center(child: Text('Sem mensagens no momento'));
        }
      }

    );
  }
}