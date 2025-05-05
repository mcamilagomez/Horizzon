//Acá se mete master en hive
import 'package:horizzon/domain/entities/master.dart';

abstract class MasterLocalDataSource {
  Future<Master?> getMaster();
  Future<void> saveMaster(Master master);
}
