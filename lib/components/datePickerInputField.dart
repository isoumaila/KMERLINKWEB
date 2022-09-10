import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kmerlinkweb/components/text_field_container.dart';
import 'package:kmerlinkweb/constants.dart';

class datePickerInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const datePickerInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.phone_android,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
