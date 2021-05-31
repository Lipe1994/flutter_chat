import 'package:chate_com_firebase/models/auth_data.dart';
import 'package:chate_com_firebase/screens/contacts_screan.dart';
import 'package:chate_com_firebase/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {

  static String route = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final authFirebase = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  
  bool isLoading = false;
  void handleSubmit(AuthData authData) async {
    setState(() {
      isLoading = true;
    });
    UserCredential result;
    try {

      if (authData.isLogin) {
        result = await authFirebase.signInWithEmailAndPassword(
            email: authData.email.trim(), password: authData.passsword);
        
      } else {

        if(authData.file == null)
        {
          throw new Exception('Você precisa colocar uma imagem');
        }

        result = await authFirebase.createUserWithEmailAndPassword(
            email: authData.email.trim(), password: authData.passsword);

        var refFile =  FirebaseStorage.instance
          .ref()
          .child('users_images')
          .child(result.user.uid+'.jpg');

        await refFile.putFile(authData.file);

        var userData = {
          'name': authData.name,
          'email': authData.email,
          'urlImage': await refFile.getDownloadURL()
        };

        await FirebaseFirestore.instance.collection('users').doc(result.user.uid).set(userData);  
      }
      Navigator.of(context).pushReplacementNamed(ContactsScrean.route);

    } on PlatformException catch (err) {
      final msg = err.message ?? 'Ocorreu um erro!';
      _scaffold.currentState.showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (err) {
      final msg = err.message ?? 'Ocorreu um erro!';
      _scaffold.currentState.showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } finally {
    setState(() {
      isLoading = false;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: [
        AuthForm(handleSubmit),
        if (isLoading)
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
            child: Center(child: CircularProgressIndicator()),
          )
      ]),
    );
  }
}
