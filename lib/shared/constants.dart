import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFFC107);
const kPrimaryLightColor = Color(0xFFFFECB3);

dynamic textInputDecoration = InputDecoration(
  fillColor: Colors.grey[200],
  filled: true,
  contentPadding: EdgeInsets.fromLTRB(12,16,12,16),
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[100], width: 1.0), borderRadius: BorderRadius.circular(3)),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[200], width: 1.0), borderRadius: BorderRadius.circular(3)),
  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2.0), borderRadius: BorderRadius.circular(3)),
  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2.0), borderRadius: BorderRadius.circular(3)),
);