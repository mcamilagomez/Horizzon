import 'package:horizzon/domain/entities/conference.dart';

class User {
  final String hash;
  final List<Conference> myConferences;

  User({
    required this.hash,
    required this.myConferences,
  });
}
