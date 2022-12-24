import 'package:flutter/material.dart';

class AuthCustomFormField extends TextFormField {
  AuthCustomFormField(
      {Function? onSaved,
      String? initialValue,
      Function? validator,
      Function? onChanged,
      String? hintText,
      Color? labelTextColor,
      TextInputType? keyboardType,
      bool? enabled,
      TextEditingController? controller,
      Widget? suffixIcon,
      Widget? socialMediaImg,
      FocusNode? focusNode,
      bool? autofocus = false,
      bool? hasIconOrImg = false,
      int? maxLength,
      String? prefix,
      TextCapitalization textCapitalization = TextCapitalization.none,
      String? errorText})
      : super(
            keyboardType: keyboardType,
            enabled: enabled,
            autofocus: autofocus ?? false,
            focusNode: focusNode,
            // initialValue: initialValue == null ? "Email*" : initialValue,
            controller: controller,
            textCapitalization: textCapitalization,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              prefixText: prefix,
              errorText: errorText,
              errorMaxLines: 1,
              alignLabelWithHint: false,
              prefixIcon: socialMediaImg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                // borderSide: BorderSide(
                //   color: Colors.black38,
                // ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  )),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              labelStyle: TextStyle(
                color: labelTextColor,
                fontSize: 17,
              ),
              counterText: "",
            ),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            validator: validator as String? Function(String?)?,
            maxLength: maxLength,
            onSaved: onSaved as void Function(String?)?,
            onChanged: onChanged as void Function(String)?);
}
