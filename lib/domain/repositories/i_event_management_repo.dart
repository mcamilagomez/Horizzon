abstract class IEventmanagementRepo {
  Future<void> subscribe(id);
  Future<void> unsubscribe(id);
  Future<void> addFeedback(feedback);
}
