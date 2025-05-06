// lib/utils/image_utils.dart
import 'dart:convert';
import 'dart:typed_data';

Uint8List decodeBase64Image(String base64Str) {
  try {
    final regex = RegExp(r'data:image/[^;]+;base64,');
    final cleaned = base64Str.replaceAll(regex, '');
    return base64Decode(cleaned);
  } catch (_) {
    return Uint8List(0);
  }
}
