class ApiConstants {
  static const String baseUrl =
      'https://horizzon-backend.onrender.com'; // o IP local real
  static const String generateHash = '$baseUrl/generate-hash';
  static const String addFeedback = '$baseUrl/feedback';
  static const String decrementSeat = '$baseUrl/event'; // + /:id/decrement-seat
  static const String incrementSeat = '$baseUrl/event'; // + /:id/increment-seat
  static const String fullData = '$baseUrl/full-data';
  static const String recommended = '$baseUrl/recommended';
}
