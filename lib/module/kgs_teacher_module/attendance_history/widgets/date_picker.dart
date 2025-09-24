import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:rts/utils/custom_date_time_picker.dart';

class AttendanceDatePicker extends StatefulWidget {
  const AttendanceDatePicker({super.key, required this.stringFunction});
  final Function(String) stringFunction;

  @override
  _AttendanceDatePickerState createState() => _AttendanceDatePickerState();
}

class _AttendanceDatePickerState extends State<AttendanceDatePicker> {
  String selectedDate = 'Select Date'; // Default text to show

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // Pick the date and update the selectedDate variable
        final String dateString =
            await CustomDateTimePicker.selectDate(context);
        if (dateString.isNotEmpty) {
          // Parse the selected date string ('dd/MM/yyyy') into DateTime object
          final DateTime parsedDate =
              DateFormat('dd/MM/yyyy').parse(dateString);

          // Format the parsed DateTime into 'yyyy-MM-dd'
          final String formattedDate =
              DateFormat('yyyy-MM-dd').format(parsedDate);

          setState(() {
            selectedDate = formattedDate;
          });

          // Pass the formatted date to the parent widget
          widget.stringFunction(formattedDate);
        }
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Colors.green,
          ),
        ),
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              Icon(
                Icons.calendar_month_rounded,
                color: Colors.green,
                size: 22,
              ),
              SizedBox(width: 8.0),
              Text(
                selectedDate, // Display the selected date in 'yyyy-MM-dd' format
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
