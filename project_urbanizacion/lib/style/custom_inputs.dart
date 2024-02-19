import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.black),
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: const TextStyle(color: Colors.black),
    );
  }

  static InputDecoration txtInputDecoration(
      {required String hint, required IconData icon}) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.withOpacity(0.3))),
      fillColor: Colors.white,
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xD9b22222))),
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration txtInputDecoration2(
      {required String hint, required IconData icon}) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration txtObsInputDecoration3(
      {required String hint, required IconData icon}) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration dropwodDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      fillColor: Colors.white,
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration boxInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration boxInputDecoration2({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        labelText: label,
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        prefixIcon: Icon(icon, color: Colors.grey),
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        errorStyle: const TextStyle(fontSize: 12));
  }

  static InputDecoration boxInputDecoration3({
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey, fontSize: 11),
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 11),
    );
  }

  static InputDecoration boxInputDecorationDatePicker(
      {required String labelText, required Function fc}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        labelText: labelText,
        isDense: true,
        labelStyle: const TextStyle(fontSize: 12),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        suffixIcon: InkWell(
          onTap: () => fc(),
          child: const Icon(Icons.calendar_today),
        ));
  }

  static InputDecoration boxInputDecorationIconAdd(
      {String? mensaje = 'Mensaje',
      required IconData icon,
      required Function fc}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        prefixIcon: Icon(icon, color: Colors.grey),
        suffixIcon: InkWell(
          onTap: () => fc(),
          child: Tooltip(
              message: mensaje,
              child: const Icon(
                Icons.add_outlined,
              )),
        ));
  }
}
