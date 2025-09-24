import 'package:flutter/material.dart';

import '../models/attendance_history_model.dart';

class AttendanceHistoryCard extends StatelessWidget {
  const AttendanceHistoryCard({super.key, required this.model});
  final AttendanceHistoryModel model;
  List<String> convertDateStringToList(String date) {
    return date.split(' ');
  }

  @override
  Widget build(BuildContext context) {
    final date = convertDateStringToList(model.attendanceDate);
    return AspectRatio(
      aspectRatio: 7 / 2,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xfff4f4f4),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            AspectRatio(
                aspectRatio: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        date[1],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                          child: _detailColumn(
                              "Check In",
                              model.inTime.isNotEmpty
                                  ? model.inTime
                                  : "--:--")),
                      VerticalDivider(
                        thickness: 1.3,
                      ),
                      Expanded(
                          child: _detailColumn(
                              "Check Out",
                              model.outTime.isNotEmpty
                                  ? model.outTime
                                  : "--:--")),
                      VerticalDivider(
                        thickness: 1.3,
                      ),
                      Expanded(
                          child: _detailColumn(
                              "Total Hours",
                              model.duration != 0
                                  ? model.duration.toString()
                                  : "00:00")),
                    ],
                  )),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    model.status,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailColumn(String key, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          key,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10.0,
          ),
        ),
      ],
    );
  }
}
