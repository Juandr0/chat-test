import 'package:cool/chat/controller.dart';
import 'package:cool/chat/widgets/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatScreenController(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Chat UI Test')),
          body: Builder(
            builder: (context) {
              // Problem 1: context.read only reads once. context.watch to subscribes for state changes.
              final chatProvider = context.watch<ChatScreenController>();
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: chatProvider.messages.length,
                      // Problem 2 & 3: Attached scrollcontroller
                      controller: chatProvider.scrollController,
                      itemBuilder: (context, index) {
                        final message = chatProvider.messages[index];
                        final isMe = message.isMe;
                        return Align(
                          alignment:
                              isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  isMe ? Colors.blueAccent : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.text,
                                  style: TextStyle(
                                    color: isMe ? Colors.white : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  message.timestamp,
                                  style: TextStyle(
                                    color:
                                        isMe ? Colors.white70 : Colors.black54,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: chatProvider.controller,
                            decoration: const InputDecoration(
                              hintText: 'Type a message...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        // We disucssed a rectangle button animating to a circle with circleLoadingIndicator. Gave it a go for fun.
                        Animatedbutton(
                          onPressed: () async {
                            chatProvider.sendMessage(
                              chatProvider.controller.text,
                            );
                            chatProvider.controller.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
