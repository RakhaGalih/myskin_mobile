import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart'; // Added for basename function
import 'package:shared_preferences/shared_preferences.dart';

const String apiURL = "https://myskin-api-v2.humicprototyping.com/api";

Future<Map<String, dynamic>> getData(String endpoint) async {
  final uri = Uri.parse(apiURL + endpoint);
  final response = await http.get(
    uri,
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print('Failed to load user details. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to load user details');
  }
}

Future<Map<String, dynamic>> getDataToken(String address, String token) async {
  final uri = Uri.parse(apiURL + address);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print('Failed to load user details. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to load user details');
  }
}

Future<Map<String, dynamic>> deleteDataToken(
    String address, String token) async {
  final uri = Uri.parse(apiURL + address);
  final response = await http.delete(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 204) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 404) {
    print('Data tidak ditemukan.');
    throw Exception('Data not found');
  } else {
    print('Failed to delete data. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to delete data');
  }
}

Future<Map<String, dynamic>> logout(String token) async {
  final uri = Uri.parse("$apiURL/v1/auth/logout");
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Response body: ${response.body}');
    return jsonDecode(response.body);
  } else {
    print('Failed to load user details. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to load user details');
  }
}

Future<Map<String, dynamic>> postData(
    String address, Map<String, dynamic> body) async {
  final uri = Uri.parse(apiURL + address);
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    print('Failed to post data. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    return jsonDecode(response.body);
  }
}

// POST request dengan token dan gambar
Future<dynamic> postDataTokenWithImage(
  String endpoint,
  Map<String, String> data,
  File? imageFile,
) async {
  String? token = await getToken();
  if (token == null) {
    throw Exception('Token not found');
  }

  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  var request = http.MultipartRequest('POST', Uri.parse('$apiURL$endpoint'));
  request.headers['Authorization'] = 'Bearer $token';
  var mimeType = lookupMimeType(imageFile!.path);
  var bytes = await File.fromUri(Uri.parse(imageFile.path)).readAsBytes();
  http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
      'image', bytes,
      filename: basename(imageFile.path),
      contentType: MediaType.parse(mimeType.toString()));
  request.fields.addAll(data);
  request.headers.addAll(headers);
  request.files.add(multipartFile);
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  // Tambahkan field data ke request
  data.forEach((key, value) {
    request.fields[key] = value.toString();
  });

  return _handleResponse(response);
}

// POST request dengan token dan gambar
Future<Map<String, dynamic>> postDataDoctorRegister(
    String endpoint,
    Map<String, String> data,
    File? selectedFileTandaRegistrasi,
    File? selectedFileIjazah,
    File? selectedFileSertifikat) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  var request = http.MultipartRequest('POST', Uri.parse('$apiURL$endpoint'));
  try {
    request.headers.addAll(headers);
    request.fields.addAll(data);
    http.MultipartFile multipartFileTandaRegistrasi =
        await getMultiPartFile('license_file', selectedFileTandaRegistrasi);
    http.MultipartFile multipartFileIjazah =
        await getMultiPartFile('diploma_file', selectedFileIjazah);
    if (selectedFileSertifikat != null) {
      http.MultipartFile multipartFileSertifikat =
          await getMultiPartFile('certification_file', selectedFileSertifikat);
      request.files.add(multipartFileSertifikat);
    }
    request.files.add(multipartFileTandaRegistrasi);
    request.files.add(multipartFileIjazah);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    // Tambahkan field data ke request
    data.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    return _handleResponse(response);
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to upload files');
  }
}

Future<http.MultipartFile> getMultiPartFile(
    String key, File? selectedFile) async {
  var mimeType = lookupMimeType(selectedFile!.path);
  var bytes = await File.fromUri(Uri.parse(selectedFile.path)).readAsBytes();
  http.MultipartFile multipartFile = http.MultipartFile.fromBytes(key, bytes,
      filename: basename(selectedFile.path),
      contentType: MediaType.parse(mimeType.toString()));
  return multipartFile;
}

// Fungsi untuk menangani response
dynamic _handleResponse(http.Response response) {
  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Response body: ${response.body}');
    return jsonDecode(response.body);
  } else {
    print('Failed to post data. Status code: ${response.statusCode}');
    return jsonDecode(response.body);
  }
}

Future<dynamic> postDataToken(String address, Map<String, dynamic> body) async {
  final uri = Uri.parse(apiURL + address);
  String? token = await getToken();
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(body),
  );

  _handleResponse(response);
}

Future<dynamic> updateDataToken(
    String address, Map<String, dynamic> body) async {
  final uri = Uri.parse(apiURL + address);
  String? token = await getToken();
  final response = await http.patch(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(body),
  );

  _handleResponse(response);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken');
}

Future<void> saveToken(String token, String role) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('accessToken', token);
  await prefs.setString('role', role);
}

Future<void> removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('accessToken');
  await prefs.remove('role');
}

Future<String?> getRole() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('role');
}
