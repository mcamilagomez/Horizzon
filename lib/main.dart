import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:horizzon/data/datasources/remote/remote_datasource.dart';
import 'package:horizzon/data/models/event_model.dart';
import 'package:horizzon/data/models/event_track_model.dart';
import 'package:horizzon/data/models/feedback_by_user_model.dart';
import 'package:horizzon/data/models/master_model.dart';
import 'package:horizzon/data/models/user_model.dart';
import 'package:horizzon/domain/use_case/use_case.dart';
import 'package:horizzon/ui/controllers/event_controller.dart';
import 'package:horizzon/ui/controllers/language_controller.dart';
import 'package:horizzon/ui/controllers/theme_controller.dart';
import 'package:horizzon/ui/my_app.dart';
import 'package:horizzon/data/repositories/master_repo_impl.dart';
import 'package:horizzon/data/repositories/user_repo_impl.dart';
import 'package:horizzon/data/datasources/local/user_local_impl.dart';
import 'package:horizzon/data/datasources/local/master_local_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('es_CO', null);
  await Hive.initFlutter();

  // Registro de adaptadores Hive
  Hive.registerAdapter(FeedbackByUserModelAdapter());
  Hive.registerAdapter(EventModelAdapter());
  Hive.registerAdapter(EventTrackModelAdapter());
  Hive.registerAdapter(MasterModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  // Abrir boxes
  final userBox = await Hive.openBox<UserModel>('userBox');
  final masterBox = await Hive.openBox<MasterModel>('masterBox');

  // Crear dataSources
  final remote = RemoteDataSource();
  final userLocal = HiveUserLocalDataSource(userBox);
  final masterLocal = HiveMasterLocalDataSource(masterBox);

  // Crear repos
  final userRepo = UserRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: userLocal,
  );

  final masterRepo = MasterRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: masterLocal,
  );

  // Ejecutar use case de inicio
  final appInit = AppInitializationUseCase(
    masterRepository: masterRepo,
    userRepository: userRepo,
  );

  await appInit.initializeApp();

  final user = appInit.user;
  final master = appInit.master;

  // Inyectar controladores globales
  Get.put(ThemeController());
  Get.put(LanguageController());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventController(user: user)),
      ],
      child: MyApp(user: user, master: master),
    ),
  );
}
