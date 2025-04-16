import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/services/image_service.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/components/striped_border_painter.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/camera_page.dart';

class AppPhotoPicker extends StatefulWidget {
  final ValueChanged<File?> onImageSelected; // Callback for selected image

  const AppPhotoPicker({
    super.key,
    required this.onImageSelected, // Initialize the callback
  });

  @override
  State<AppPhotoPicker> createState() => _AppPhotoPickerState();
}

class _AppPhotoPickerState extends State<AppPhotoPicker> {
  final ImageService _imageService = ImageService();

  void _onImageCaptured(File image) {
    print(image.path);
    setState(() {
      _imageService.selectedImage =
          image; // Set the selected image in ImageService
    });
    widget.onImageSelected(image); // Call the callback with the new image
  }

  void _clearImage() {
    setState(() {
      _imageService.clearImage();
    });
    widget.onImageSelected(
        null); // Call the callback with null to indicate image removal
  }

  @override
  Widget build(BuildContext context) {
    return (_imageService.selectedImage == null)
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CameraPage(onImageCaptured: _onImageCaptured),
                ),
              );
            },
            child: CustomPaint(
              painter: StripedBorderPainter(
                stripeWidth: 5,
                stripeColor: const Color(0xFF12476B),
                stripeLength: 12,
              ),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 167,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFEAF6FF),
                ),
                child: Text(
                  '+   Masukkan Gambar',
                  style: AppTypograph.label2.bold.copyWith(
                    color: const Color(0xFF12476B),
                  ),
                ),
              ),
            ),
          )
        : Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(_imageService.selectedImage!),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.greyColor.withOpacity(0.5),
                  ),
                  child: GestureDetector(
                    onTap: _clearImage,
                    child: const Icon(
                      Icons.close,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
