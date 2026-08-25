// Package
import 'package:flutter/material.dart';

abstract class CustomAppBarBase(
  BuildContext context, {
  super.key,
  required super.title,
  required super.centerTitle,
  required super.actions,
}) extends AppBar;
