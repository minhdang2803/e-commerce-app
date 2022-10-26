import 'package:ecom/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final Function onChange;
  final bool isChecked;
  final double size;

  const CustomCheckbox({
    Key? key,
    this.isChecked = false,
    required this.onChange,
    this.size = 24,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onChange(_isSelected);
        });
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(4),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: _isSelected ? AppColor.buttonColor : Colors.transparent,
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(
            color: _isSelected ? AppColor.buttonColor : Colors.grey,
            width: 1.5,
          ),
        ),
        width: widget.size,
        height: widget.size,
        child: _isSelected
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              )
            : null,
      ),
    );
  }
}
