import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyGalleryModel {
  List<XFile>? _images;
  List<XFile>? get images => _images;

}