import 'package:hive/hive.dart';
import 'package:horizzon/data/models/master_model.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'master_local.dart';

class HiveMasterLocalDataSource implements MasterLocalDataSource {
  final Box<MasterModel> masterBox;

  HiveMasterLocalDataSource(this.masterBox);

  @override
  Future<void> saveMaster(Master master) async {
    final model = MasterModel.fromEntity(master);
    await masterBox.put('current_master', model);
  }

  @override
  Future<Master?> getMaster() async {
    final model = masterBox.get('current_master');
    return model?.toEntity();
  }
}
