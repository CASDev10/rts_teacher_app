import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rts/constants/app_colors.dart';

class TimePickerField extends StatefulWidget {
  final String label;
  final Function(String) onTimeSelected;

  const TimePickerField({
    Key? key,
    required this.label,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  late TextEditingController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      // 🕒 Set default time only once
      final now = TimeOfDay.now();
      _controller.text = now.format(context); // ✅ Safe to call here
      widget.onTimeSelected(_formatForApi(now));
      _initialized = true;
    }
  }

  // Convert TimeOfDay -> "HH:mm:ss"
  String _formatForApi(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm:ss').format(dt);
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _controller.text = picked.format(context);
      });
      widget.onTimeSelected(_formatForApi(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      onTap: () => _pickTime(context),
      decoration: InputDecoration(
        // labelText: widget.label,
        filled: true,
        fillColor: AppColors.lightGreyColor,
        suffixIcon: const Icon(Icons.access_time),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
