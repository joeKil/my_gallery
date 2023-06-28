import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyGalleryModel {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images;

  int currentPage = 0;
  final pageController = PageController();

  Future<void> loadImages() async {
    images = await _picker.pickMultiImage();

    // 자동으로 사진이 넘어가게끔 시간 설정
    if (images != null) {
      Timer.periodic(const Duration(seconds: 5), (timer) {
        currentPage++;

        if (currentPage > images!.length - 1) {
          currentPage = 0;
        }
        // 페이지 에니메이션 5초뒤 넘어감
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    }

    // 화면 갱신해달라는 의미로 셋스테이트
   // setState(() {});
  }
}