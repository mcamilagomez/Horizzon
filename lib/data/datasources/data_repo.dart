abstract class DataRepo {
  Future<void> subscribe(String id);
  Future<void> unsubscribe(String id);
  Future<void> addFeedback(int stars, String comment);
}
