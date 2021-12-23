import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/validators.dart';

class UniversalTextField extends StatelessWidget with customDecorationMixin {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Color borderCursorAndTextColor;
  final String labelText;
  final String validatorErrorText;

  const UniversalTextField({
    Key key,
    @required this.controller,
    @required this.keyboardType,
    @required this.borderCursorAndTextColor,
    @required this.labelText,
    @required this.validatorErrorText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: borderCursorAndTextColor,
      decoration: customDecoration(
        borderAndTextColor: borderCursorAndTextColor,
        labelText: labelText,
      ),
      style: TextStyle(color: borderCursorAndTextColor),
      validator: (value) =>
          labelText == AppStrings.firstName || labelText == AppStrings.lastName
              ? Validators.isValidName(value)
                  ? null
                  : validatorErrorText
              : value.length >= 2
                  ? null
                  : validatorErrorText,
    );
  }
}

class EmailTextField extends StatelessWidget with customDecorationMixin {
  final TextEditingController controller;
  final Color borderCursorAndTextColor;

  const EmailTextField(
      {Key key,
      @required this.controller,
      @required this.borderCursorAndTextColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      cursorColor: borderCursorAndTextColor,
      validator: (email) =>
          GetUtils.isEmail(email) ? null : ErrorText.emailErrorText,
      decoration: customDecoration(
        borderAndTextColor: borderCursorAndTextColor,
        labelText: AppStrings.email,
      ),
      style: TextStyle(color: borderCursorAndTextColor),
    );
  }
}

class PhoneTextField extends StatelessWidget with customDecorationMixin {
  final TextEditingController controller;
  final Color borderCursorAndTextColor;

  const PhoneTextField(
      {Key key,
      @required this.controller,
      @required this.borderCursorAndTextColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      cursorColor: borderCursorAndTextColor,
      validator: (phoneNumber) => GetUtils.isPhoneNumber(phoneNumber)
          ? null
          : ErrorText.phoneNumberErrorText,
      decoration: customDecoration(
        isPhoneNumber: true,
        borderAndTextColor: borderCursorAndTextColor,
        labelText: AppStrings.phoneNumber,
      ),
      style: TextStyle(color: borderCursorAndTextColor),
    );
  }
}

class PasswordTextField extends StatelessWidget with customDecorationMixin {
  final TextEditingController controller;
  final String labelText;
  final Color borderCursorAndTextColor;

  const PasswordTextField({
    Key key,
    @required this.controller,
    @required this.labelText,
    @required this.borderCursorAndTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      cursorColor: borderCursorAndTextColor,
      validator: (password) => Validators.isValidPassword(password)
          ? null
          : ErrorText.passwordErrorText,
      decoration: customDecoration(
        borderAndTextColor: borderCursorAndTextColor,
        labelText: labelText,
      ),
      obscureText: true,
      style: TextStyle(color: borderCursorAndTextColor),
    );
  }
}

class RequestQuoteTextFeild extends StatelessWidget with customDecorationMixin {
  final TextEditingController controller;
  final Color borderAndCursorColor;
  final labelText;
  final int totalLines;

  const RequestQuoteTextFeild({
    Key key,
    @required this.controller,
    @required this.borderAndCursorColor,
    this.labelText,
    this.totalLines = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      cursorColor: borderAndCursorColor,
      maxLines: totalLines,
      decoration: customDecoration(
        borderAndTextColor: borderAndCursorColor,
        labelText: labelText,
      ),
      validator: (value) =>
          value.length > 2 ? null : AppStrings.enterYourQueryOrRequirement,
      style: TextStyle(color: Colors.black),
    );
  }
}

class SearchTextField extends StatelessWidget with customDecorationMixin {
  final TextEditingController controller;
  final Color borderAndCursorColor;
  final Function search;

  const SearchTextField({
    Key key,
    @required this.controller,
    @required this.borderAndCursorColor,
    @required this.search,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      cursorColor: borderAndCursorColor,
      onFieldSubmitted: (searchQuery) {
        if (searchQuery != "")
          search();
        else {
          Get.snackbar(
            ErrorText.searchErrorText,
            ErrorText.searchErrorDetailText,
          );
        }
      },
      decoration: customDecoration(
          borderAndTextColor: borderAndCursorColor,
          hintText: AppStrings.searchServices),
    );
  }
}

mixin customDecorationMixin {
  InputDecoration customDecoration({
    labelText,
    hintText,
    @required borderAndTextColor,
    bool isPhoneNumber = false,
  }) {
    return InputDecoration(
      border: normalOutlineInputBorder(borderAndTextColor),
      enabledBorder: normalOutlineInputBorder(borderAndTextColor),
      focusedBorder: normalOutlineInputBorder(borderAndTextColor),
      isDense: true,
      labelStyle: TextStyle(
        color: borderAndTextColor,
        fontSize: 15,
      ),
      labelText: labelText,
      hintText: hintText,
      prefixText: isPhoneNumber ? '${AppStrings.countryCode} ' : null,
      prefixStyle: TextStyle(color: borderAndTextColor),
    );
  }

  OutlineInputBorder normalOutlineInputBorder(borderAndTextColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: borderAndTextColor),
    );
  }
}
