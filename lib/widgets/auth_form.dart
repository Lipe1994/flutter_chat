import 'dart:io';

import 'package:chate_com_firebase/models/auth_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthForm extends StatefulWidget {
  final Function(AuthData auth) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final AuthData auth = AuthData();
  final GlobalKey<FormState> _formKey = GlobalKey();

  _submit() {
    var isValid = _formKey.currentState.validate();

    FocusScope.of(context).unfocus();

    if (isValid) {
      this.widget.onSubmit(auth);
    }
  }

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      auth.file = File(image.path);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (auth.isSignup)
                      InkWell(
                        customBorder: new CircleBorder(),
                        child: Ink(
                          decoration: BoxDecoration(
                              image: auth.file != null
                                  ? DecorationImage(image: FileImage(auth.file))
                                  : null,
                              color: Colors.blue,
                              shape: BoxShape.circle),
                          padding: EdgeInsets.all(40),
                          child: auth.file != null
                              ? null
                              : Icon(Icons.photo_camera),
                        ),
                        onTap: () async {
                          await _getImage();
                          setState(() {});
                        },
                      ),
                    if (auth.isSignup)
                      TextFormField(
                        initialValue: auth.name,
                        key: ValueKey('nome'),
                        decoration: InputDecoration(labelText: 'Nome'),
                        onChanged: (text) {
                          auth.name = text;
                        },
                        validator: (value) {
                          if (value == null || value.length < 4) {
                            return 'Nome deve ter mais de 3 caracteres';
                          }
                          return null;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('email'),
                      decoration: InputDecoration(labelText: 'E-mail'),
                      onChanged: (text) {
                        auth.email = text;
                      },
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      key: ValueKey('senha'),
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Senha'),
                      onChanged: (text) {
                        auth.passsword = text;
                      },
                      validator: (value) {
                        if (value == null || value.length < 7) {
                          return 'senha deve ter mais de 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                        child: Text(auth.isLogin ? 'Entrar' : 'cadastrar'),
                        onPressed: _submit),
                    TextButton(
                        child: Text(auth.isLogin
                            ? 'Criar uma nova conta'
                            : 'Fazer login'),
                        onPressed: () {
                          setState(() {
                            auth.togleMode();
                          });
                        })
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
