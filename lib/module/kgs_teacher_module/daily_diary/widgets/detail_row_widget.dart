import 'package:flutter/material.dart';

class DetailRowWidget extends StatelessWidget {
  const DetailRowWidget({super.key, required this.name, required this.value});

  final String name, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: TextStyle(
            // color: Colors.grey.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
