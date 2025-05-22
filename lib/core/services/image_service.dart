// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyNetworkImage extends StatelessWidget {
  final String? imageURL;
  final double? width;
  final double? height;
  final double? nullHeight;
  final BoxFit? fit;
  const MyNetworkImage({
    super.key,
    required this.imageURL,
    this.width,
    this.height,
    this.nullHeight,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    if (imageURL == null || imageURL!.isEmpty) {
      return Container(
        width: width,
        height: nullHeight ?? height,
        color: Colors.grey[300],
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported),
            Text(
              'No image available',
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    }
    return Image.network(imageURL!, width: width, height: height, fit: fit,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      }
    }, errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported),
            Text(
              'Failed to load image',
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    });
  }
}

class ImageService {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  File? getSelectedImage() {
    return selectedImage;
  }

  Future<String> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      return pickedFile.path;
    } else {
      print("No image selected");
      return '';
    }
  }

  void clearImage() {
    selectedImage = null;
  }
}

Future<void> downloadImage(BuildContext context, String imageUrl) async {
  // Minta izin penyimpanan (untuk Android)
  if (Platform.isAndroid) {
    var status = await Permission.storage.request();
    if (status.isPermanentlyDenied) {
      // Tidak bisa minta lagi, harus ke pengaturan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "Izin ditolak permanen. Buka pengaturan untuk mengaktifkan."),
          action: SnackBarAction(
            label: "Buka",
            onPressed: () {
              openAppSettings();
            },
          ),
        ),
      );
    }
  }

  try {
    // Request ke URL
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      // Ambil path penyimpanan
      Directory dir = Platform.isAndroid
          ? Directory('/storage/emulated/0/Download')
          : await getApplicationDocumentsDirectory();

      String fileName = imageUrl.split('/').last;
      String savePath = '${dir.path}/$fileName';

      // Simpan file sebagai byte
      File file = File(savePath);
      await file.writeAsBytes(response.bodyBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gambar berhasil diunduh ke $savePath')),
      );
    } else {
      throw Exception("Gagal mengunduh, status: ${response.statusCode}");
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

/*Future<void> downloadImageWithHttp(String url) async {
  // Minta izin penyimpanan
  final status = await Permission.storage.request();
  if (!status.isDenied) {
    print("Permission denied");
    return;
  }

  if (status.isPermanentlyDenied) {
    // Arahkan user ke Settings
    await openAppSettings();
  }

  try {
    // Ambil gambar dari URL
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Uint8List bytes = response.bodyBytes;

      // Simpan ke galeri
      final result = await ImageGallerySaver.saveImage(
        bytes,
        quality: 80,
        name: "downloaded_image",
      );

      print("Berhasil disimpan ke galeri: $result");
    } else {
      print("Gagal download gambar, status: ${response.statusCode}");
    }
  } catch (e) {
    print("Terjadi error: $e");
  }
}
*/
