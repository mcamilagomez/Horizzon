import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'package:horizzon/ui/my_app.dart';
import 'package:horizzon/domain/use_case/use_case.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/entities/master.dart';

// DataSources
import 'package:horizzon/data/datasources/remote/remote_datasource.dart';
import 'package:horizzon/data/datasources/local/user_local_impl.dart';
import 'package:horizzon/data/datasources/local/master_local_impl.dart';

// Repositories
import 'package:horizzon/data/repositories/user_repo_impl.dart';
import 'package:horizzon/data/repositories/master_repo_impl.dart';
import 'package:horizzon/domain/repositories/master_repository.dart';
import 'package:horizzon/domain/repositories/user_repository.dart';

// Controllers
import 'package:horizzon/ui/controllers/event_controller.dart';
import 'package:horizzon/ui/controllers/language_controller.dart';
import 'package:horizzon/ui/controllers/theme_controller.dart';

// Hive Models
import 'package:horizzon/data/models/event_model.dart';
import 'package:horizzon/data/models/event_track_model.dart';
import 'package:horizzon/data/models/feedback_by_user_model.dart';
import 'package:horizzon/data/models/master_model.dart';
import 'package:horizzon/data/models/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_CO', null);
  await Hive.initFlutter();

  // ✅ Activar para limpiar Hive al iniciar (útil en desarrollo)
  const clearHiveOnStart = true;

  // Registro de adaptadores Hive
  Hive.registerAdapter(FeedbackByUserModelAdapter());
  Hive.registerAdapter(EventModelAdapter());
  Hive.registerAdapter(EventTrackModelAdapter());
  Hive.registerAdapter(MasterModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  if (clearHiveOnStart) {
    await Hive.deleteBoxFromDisk('userBox');
    await Hive.deleteBoxFromDisk('masterBox');
  }

  // Abrir boxes
  final userBox = await Hive.openBox<UserModel>('userBox');
  final masterBox = await Hive.openBox<MasterModel>('masterBox');

  // Crear dataSources
  final remoteDataSource = RemoteDataSource();
  final userLocal = HiveUserLocalDataSource(userBox);
  final masterLocal = HiveMasterLocalDataSource(masterBox);

  // Crear repositorios
  final userRepo = UserRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: userLocal,
  );

  final masterRepo = MasterRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: masterLocal,
  );

  // Inicializar la app
  final appInit = AppInitializationUseCase(
    masterRepository: masterRepo,
    userRepository: userRepo,
  );

  await appInit.initializeApp();
  final User user = appInit.user;
  final Master master = appInit.master;

  print("🖼️ Descripción:");
  print(master.eventTracks[0].description);
  print("🖼️ Longitud de imagen base64:");
  print(master.eventTracks[0].coverImageUrl.length);

  // Inyectar controladores globales con GetX
  Get.put(ThemeController());
  Get.put(LanguageController());

  runApp(
    MultiProvider(
      providers: [
        Provider<MasterRepository>.value(value: masterRepo),
        Provider<UserRepository>.value(value: userRepo),
        ChangeNotifierProvider(
          create: (_) => EventController(
            user: user,
            userRepo: userRepo,
            masterRepo: masterRepo,
          ),
        ),
      ],
      child: MyApp(user: user, master: master),
    ),
  );
}
