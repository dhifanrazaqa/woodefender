// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'dart:io';
// import 'package:flutter_image_compress/flutter_image_compress.dart';

// Future<Uint8List> createELA(XFile file) async {
//   var img1 = await CompressFile(file, 95);
//   var img2 = await CompressFile(file, 90);

//   List<int> absoluteDifference = [];
//   for (int i = 0; i < img1.length; i++) {
//     int diff = img1[i] - img2[i];
//     absoluteDifference.add(diff.abs());
//   }

//   return Uint8List.fromList(absoluteDifference);
// }

// Future<Uint8List> CompressFile(XFile file, int quality) async {
//     var result = await FlutterImageCompress.compressWithFile(
//       file.path,
//       quality: quality,
//       format: CompressFormat.jpeg,
//       keepExif: true
//     );
//     print(result!.length);
//     return result;
//   }