import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/repositories/master_repository.dart';
import 'package:horizzon/domain/repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';
import '../mock/mock_data.dart';

// Mocks para los repositorios
class MockUserRepository extends Mock implements UserRepository {
  @override
  Future<User> getUser() async {
    return MockData.getMockUser();
  }
  
  @override
  Future<User> syncUser() async {
    return MockData.getMockUser();
  }
  
  @override
  Future<void> saveUser(User user) async {
    // No es necesario implementar para las pruebas básicas
  }
}

class MockMasterRepository extends Mock implements MasterRepository {
  @override
  Future<Master> getMaster() async {
    return MockData.getMockMaster();
  }
  
  @override
  Future<Master> syncMaster() async {
    return MockData.getMockMaster();
  }
  
  @override
  Future<void> saveMaster(Master master) async {
    // No es necesario implementar para las pruebas básicas
  }
}