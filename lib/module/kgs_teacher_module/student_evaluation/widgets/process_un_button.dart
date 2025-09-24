import 'package:flutter/material.dart';

class ProcessUnButton extends StatelessWidget {
  const ProcessUnButton({super.key, required this.isProcessed, this.onClick});

  final VoidCallback? onClick;
  final bool isProcessed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: isProcessed ? Colors.red : Colors.green,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 3.0,
          horizontal: 6.0,
        ),
        child: Text(
          isProcessed ? "Un Process" : "Process",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }
}
