import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'my_gallery_view_model.dart';

class MyGalleryApp extends StatefulWidget {
  const MyGalleryApp({Key? key}) : super(key: key);

  @override
  State<MyGalleryApp> createState() => _MyGalleryAppState();
}

class _MyGalleryAppState extends State<MyGalleryApp> {
  final ImagePicker _picker = ImagePicker();
  final model = MyGalleryModel();
  var images = MyGalleryModel().images;

  int currentPage = 0;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    loadImages();
  }

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('전자액자'),
      ),
      body: images == null
          ? const Center(
        child: Text('No data'),
      )

      // 슬라이드 구현
          : PageView(
        controller: pageController,
        children: images!.map((image) {
          // 사진 표시 로직
          return FutureBuilder<Uint8List>(
            // 여기서 오래 걸리는 작업을
              future: image.readAsBytes(),
              builder: (context, snapshot) {
                final data = snapshot.data;

                if (data == null ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 리턴에서 처리
                return Image.memory(
                  data,
                  width: double.infinity,
                );
              });
        }).toList(),
      ),
    );
  }
}
