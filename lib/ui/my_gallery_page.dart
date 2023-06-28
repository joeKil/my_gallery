import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/ui/my_gallery_view_model.dart';

class MyGalleryApp extends StatefulWidget {
  const MyGalleryApp({Key? key}) : super(key: key);

  @override
  State<MyGalleryApp> createState() => _MyGalleryAppState();
}

class _MyGalleryAppState extends State<MyGalleryApp> {
  // final ImagePicker _picker = ImagePicker();
  final _galleryModel = MyGalleryModel();

  // 객체가 받는 파일
  // List<XFile>? images;
  //
  // int currentPage = 0;
  // final pageController = PageController();

  @override
  void initState() {
    super.initState();
    _galleryModel.loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('전자액자'),
      ),
      body: _galleryModel.images == null
          ? const Center(
        child: Text('No data'),
      )

      // 슬라이드 구현
          : PageView(
        controller: _galleryModel.pageController,
        children: _galleryModel.images!.map((image) {
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