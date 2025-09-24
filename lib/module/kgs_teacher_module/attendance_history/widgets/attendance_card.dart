import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    super.key,
    required this.cardName,
    this.value = "0",
    this.aspectRatio = 14 / 9,
  });
  final String cardName;
  final String value;
  final double aspectRatio;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(
              color: Colors.green,
              width: 1,
            )),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: (size.height / 100) * 3.5,
                    width: (size.height / 100) * 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: Colors.green,
                    ),
                    child: Icon(
                      size: (size.height / 100) * 2.5,
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Text(
                    cardName,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Text("Day",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
