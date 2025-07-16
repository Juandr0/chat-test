import 'package:cool/chat/model/message.dart';
import 'package:flutter/material.dart';

class ChatScreenController extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<Message> messages = [
    Message('Hi there!', '10:00 AM', false),
    Message('Hello!', '10:01 AM', true),
    Message('How are you?', '10:02 AM', false),
  ];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    messages.add(Message(text, _currentTime(), true));
    notifyListeners();

    //Problem 3 - Scroll to bottom after message with addpostframecallback to ensure scrolling happens after new ui is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  String _currentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  //Problem 3 - Scroll to bottom after message post
  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }
}
