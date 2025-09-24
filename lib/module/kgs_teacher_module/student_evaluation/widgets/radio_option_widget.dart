import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class RadioButtonSelector extends StatefulWidget {
  const RadioButtonSelector({super.key, this.onSelected, this.selectedOption});

  final Function(String)? onSelected;
  final String? selectedOption;

  @override
  State<RadioButtonSelector> createState() => _RadioButtonSelectorState();
}

class _RadioButtonSelectorState extends State<RadioButtonSelector> {
  List<String> options = ["WT", "WW", "WB"];
  String? selectedOption;

  @override
  void initState() {
    setState(() {
      selectedOption = widget.selectedOption;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          options.map((b) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedOption = b;
                });
                widget.onSelected!(b);
              },
              child: CustomRadioButton(
                isSelected: b == selectedOption,
                name: b,
              ),
            );
          }).toList(),
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.isSelected,
    required this.name,
  });

  final bool isSelected;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 10.0,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(color: AppColors.primary, width: 1.5),
          ),
          child: Icon(Icons.check_outlined, size: 10, color: Colors.white),
        ),
      ],
    );
  }
}
