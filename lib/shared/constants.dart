import 'package:flutter/material.dart';

dynamic textInputDecoration = InputDecoration(
  fillColor: Colors.grey[200],
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[100], width: 1.0), borderRadius: BorderRadius.circular(3)),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[200], width: 1.0), borderRadius: BorderRadius.circular(3)),
  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2.0), borderRadius: BorderRadius.circular(3)),
  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2.0), borderRadius: BorderRadius.circular(3)),
);