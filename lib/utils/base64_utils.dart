import 'dart:convert';
import 'dart:typed_data';

class Base64Utils {
  /// Decodifica una cadena base64 eliminando encabezado MIME si existe
  static Uint8List decode(String base64String) {
    final cleaned =
        base64String.contains(',') ? base64String.split(',')[1] : base64String;
    return base64Decode(cleaned);
  }
}
