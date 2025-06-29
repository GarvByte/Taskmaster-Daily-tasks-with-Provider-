import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

bool textinputs = false;
TextEditingController myController = TextEditingController();
String today = DateFormat('dd MMM yyyy').format(DateTime.now());
Duration d = Duration(hours: 24);
bool lightMode = true;
