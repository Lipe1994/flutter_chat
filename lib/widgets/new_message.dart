import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {

  final String destinatarioId;

  const NewMessage(this.destinatarioId);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {

  void addMessage() async {
    FocusScope.of(context).unfocus();

    var user = FirebaseAuth.instance.currentUser;

    var userWithProperties = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user.email).get();

    var name = userWithProperties.docs.first['name'];
    var urlImage = userWithProperties.docs.first['urlImage'];
    await FirebaseFirestore.instance.collection('chate').add({
      'texto': _messageState.value.text,
      'createdAt': DateTime.now(),
      'userId': user.uid,
      'userName': name,
      'destinatarioId': this.widget.destinatarioId,
      'chave': user.uid+';'+this.widget.destinatarioId,
      'userImage': urlImage,
    });

    _messageState.clear();
  }
  TextEditingController _messageState = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageState,
              onChanged: (value){
                setState(() {});
              },
              decoration: InputDecoration(labelText: 'Insira um texto', border: InputBorder.none),
            ),
          ),
          ElevatedButton(onPressed: _messageState?.value?.text == null || _messageState.value.text.isEmpty ? null : () => addMessage(), child: Text('Enviar'))
        ],
      ),
    );
  }
}
