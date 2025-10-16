import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rts/components/text_view.dart';
import 'package:rts/constants/app_colors.dart';

class DropDownItem {
  final String id;
  final String name;

  DropDownItem({required this.id, required this.name});

  // ✅ Important: equality check
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DropDownItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class UpdateCustomDropdown extends StatefulWidget {
  final String hint;
  final DropDownItem? selectedValue;
  final List<DropDownItem> items;
  final bool disable;
  final Color borderColor;
  final Color hintColor;
  final Color iconColor;
  final bool isOutline;
  final String? suffixIconPath;
  final double allPadding;
  final double verticalPadding;
  final double horizontalPadding;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Function(DropDownItem value)? onSelect;
  final double height;
  final double width;

  const UpdateCustomDropdown({
    super.key,
    required this.hint,
    required this.items,
    this.selectedValue,
    this.height = 50,
    this.width = double.infinity,
    this.iconColor = AppColors.grey4,
    this.hintColor = AppColors.grey3,
    this.suffixIconPath,
    this.disable = false,
    this.borderColor = AppColors.whiteColor,
    this.fontSize = 14,
    this.onSelect,
    this.isOutline = true,
    this.allPadding = 10,
    this.fontWeight = FontWeight.w400,
    this.horizontalPadding = 16,
    this.verticalPadding = 0,
  });

  @override
  State<UpdateCustomDropdown> createState() => _UpdateCustomDropdownState();
}

class _UpdateCustomDropdownState extends State<UpdateCustomDropdown> {
  DropDownItem? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: _boxDecoration(widget.isOutline),
      alignment: Alignment.center,
      child: IgnorePointer(
        ignoring: widget.disable,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: DropdownButtonFormField<DropDownItem>(
            isExpanded: true,
            isDense: true,
            icon: SvgPicture.asset(
              'assets/images/svg/ic_drop_down.svg',
              color: AppColors.primaryGreen,
            ),
            style: TextStyle(
              fontSize: widget.fontSize,
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.w500,
            ),
            hint: TextView(
              widget.hint,
              fontSize: widget.fontSize,
              color: widget.hintColor,
              fontWeight: widget.fontWeight,
              overflow: TextOverflow.ellipsis,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.lightGreyColor,
              contentPadding:
                  EdgeInsets.all(widget.allPadding) +
                  EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
              border: InputBorder.none, // remove default border
              enabledBorder: InputBorder.none, // remove enabled border
              disabledBorder: InputBorder.none, // remove disabled border
              focusedBorder: InputBorder.none, // ✅ remove focus border
            ),

            dropdownColor: const Color(0xffF4F4F4),
            value: selectedItem,
            onChanged: (DropDownItem? newValue) {
              setState(() {
                selectedItem = newValue;
              });
              if (newValue != null) widget.onSelect?.call(newValue);
            },
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            menuMaxHeight: 550,
            items: widget.items.map((item) {
              return DropdownMenuItem<DropDownItem>(
                value: item,
                child: TextView(
                  item.name,
                  fontSize: widget.fontSize,
                  color: widget.hintColor,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

/// -----------------------------
/// Helper Decorations
/// -----------------------------

OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12.0),
  borderSide: const BorderSide(color: AppColors.lightGreyColor),
);

BoxDecoration _boxDecoration(bool isOutline) {
  if (isOutline) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: AppColors.primaryGreen,
        width: 1, //                   <--- border width here
      ),
    );
  } else {
    return const BoxDecoration(
      color: AppColors.lightGreyColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    );
  }
}
