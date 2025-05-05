import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String?> saveBase64ImageToFile(
    String? base64String, String filename) async {
  if (base64String == null || base64String.isEmpty) return null;

  final regex = RegExp(r'data:image/[^;]+;base64,');
  final cleanedBase64 = base64String.replaceAll(regex, '');
  final bytes = base64Decode(cleanedBase64);

  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/$filename');
  await file.writeAsBytes(bytes);

  return file.path;
}
