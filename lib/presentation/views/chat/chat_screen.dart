import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage("https://media.diariouno.com.ar/p/1e4b4066bc494615d5211b1ffe9e333a/adjuntos/298/imagenes/009/136/0009136348/1200x0/smart/lionel-messi2jpg.jpg"),
          ),
        ),
        title: const Text("Messi ⚽"),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final chatprovider = context.watch<ChatProvider>();


    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatprovider.chatScrollController,
                itemCount: chatprovider.messageList.length,
                itemBuilder: (context, index) {
                  final message = chatprovider.messageList[index];
                  return (message.fromWho == FromWho.hers) ? HerMessageBubble( message: message ) : MyMessageBubble( message: message);
                  /* Alternamos los mensajes */
                  /* return (index % 2 == 0) ? const HerMessageBubble() : const MyMessageBubble(); */
                },
              ),
            ),

            /* CAJA DE TEXTO */
            MessageFieldBox(
              onValue: (value) => chatprovider.sendMessage(value),
            ),
          ],
        ),
      ),
    );
  }
}