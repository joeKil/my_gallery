import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyGalleryModel {
  List<XFile>? _images;
  List<XFile>? get images => _images;

  // loadimage 함수를 여기에 옮기려고 시도헀으나 스크롤뷰에 페이지컨트롤러가 있어야한다고 에러가납니다 ㅜㅜ
}