import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

Future<Uint8List?> sendImage(String imagePath) async {
  // Convert image to bytes
  var imageBytes = await File(imagePath).readAsBytes();
  // Encode the bytes
  var base64Image = "data:image/png;base64,${base64Encode(imageBytes)}";
  var body = json.encode({
    'image': base64Image,
  });
  // Send the API request
  var response = await http.post(
    Uri.parse('https://dhifanrazaqa.pythonanywhere.com/process_image'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: body
  );

  // Handle the API response
  if (response.statusCode == 200) {
    var parse = jsonDecode(response.body);
    var img = base64Decode(parse['result']);
    return img;
  } else {
    print('Error');
  }
}

Future<Uint8List?> addFragileWm(String imagePath1, String imagePath2) async {
  // Convert image to bytes
  var imageBytes1 = await File(imagePath1).readAsBytes();
  var imageBytes2 = await File(imagePath2).readAsBytes();
  // Encode the bytes
  var base64Image1 = "data:image/png;base64,${base64Encode(imageBytes1)}";
  var base64Image2 = "data:image/png;base64,${base64Encode(imageBytes2)}";
  var body = json.encode({
    'image1': base64Image1,
    'image2': base64Image2,
  });
  // Send the API request
  var response = await http.post(
    Uri.parse('https://woodefender.pythonanywhere.com/process_image_frag'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: body
  );

  // Handle the API response
  if (response.statusCode == 200) {
    var parse = jsonDecode(response.body);
    var img = base64Decode(parse['result']);
    return img;
  } else {
    print('Error');
  }
}

Future<Uint8List?> addRobustWm(String imagePath1, String imagePath2, String pw) async {
  // Convert image to bytes
  var imageBytes1 = await File(imagePath1).readAsBytes();
  var imageBytes2 = await File(imagePath2).readAsBytes();
  // Encode the bytes
  var base64Image1 = "data:image/png;base64,${base64Encode(imageBytes1)}";
  var base64Image2 = "data:image/png;base64,${base64Encode(imageBytes2)}";
  var body = json.encode({
    'image1': base64Image1,
    'image2': base64Image2,
    'pw': pw
  });
  // Send the API request
  var response = await http.post(
    Uri.parse('https://woodefender.pythonanywhere.com/process_image_rob'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: body
  );

  // Handle the API response
  if (response.statusCode == 200) {
    var parse = jsonDecode(response.body);
    var img = base64Decode(parse['result']);
    return img;
  } else {
    print('Error');
  }
}

Future<Uint8List?> extrFragileWm(String imagePath) async {
  // Convert image to bytes
  var imageBytes = await File(imagePath).readAsBytes();
  // Encode the bytes
  var base64Image = "data:image/png;base64,${base64Encode(imageBytes)}";
  var body = json.encode({
    'image': base64Image,
  });
  // Send the API request
  var response = await http.post(
    Uri.parse('https://woodefender.pythonanywhere.com/extract_image_frag'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: body
  );

  // Handle the API response
  if (response.statusCode == 200) {
    var parse = jsonDecode(response.body);
    var img = base64Decode(parse['result']);
    return img;
  } else {
    print('Error');
  }
}