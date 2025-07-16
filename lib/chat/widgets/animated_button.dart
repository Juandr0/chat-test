import 'package:flutter/material.dart';

class Animatedbutton extends StatefulWidget {
  final Future<void> Function() onPressed;
  const Animatedbutton({super.key, required this.onPressed});

  @override
  State<Animatedbutton> createState() => _AnimatedbuttonState();
}

class _AnimatedbuttonState extends State<Animatedbutton> {
  bool isLoading = false;

  Future<void> handlePress() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    // Simulate delay to display animation
    await Future.delayed(Duration(seconds: 1));
    try {
      await widget.onPressed();
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCirc,
      width: isLoading ? 55 : 100,
      height: 55,
      decoration: BoxDecoration(
        borderRadius:
            isLoading ? BorderRadius.circular(50) : BorderRadius.circular(10),
        color:
            isLoading
                ? const Color.fromARGB(90, 244, 117, 54)
                : Colors.blueAccent,
      ),
      child: Center(
        child:
            isLoading
                ? CircularProgressIndicator()
                : IconButton(
                  onPressed: handlePress,
                  icon: Icon(Icons.send, color: Colors.white),
                ),
      ),
    );
  }
}
