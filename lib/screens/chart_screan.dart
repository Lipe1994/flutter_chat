import 'package:chate_com_firebase/widgets/chat_app_bar.dart';
import 'package:chate_com_firebase/widgets/messages.dart';
import 'package:chate_com_firebase/widgets/new_message.dart';
import 'package:flutter/material.dart';

class ChartScreenArgs{
  final String destinatarioId;

  ChartScreenArgs(this.destinatarioId);
}

class ChartScreen extends StatelessWidget {
  static String route = '/chate';
  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context).settings.arguments as ChartScreenArgs;

    return Scaffold(
      appBar: ChatAppBar(context),
      body: Column(
        children: [
          Expanded(child: Messages(args.destinatarioId)),
          NewMessage(args.destinatarioId)
        ],
      )
    );
  }
}
