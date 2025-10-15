import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bloc/homework_bloc.dart';
import 'data/homework_repo.dart';
import 'models/homework.dart';
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HomeworkAdapter());
  final storage = HomeworkStorage();
  await storage.init();

  runApp(HomeworkApp(storage: storage));
}

class HomeworkApp extends StatelessWidget {
  final HomeworkStorage storage;
  const HomeworkApp({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeworkBloc(storage),
      child: MaterialApp.router(
        title: 'Homework Tracker App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.pink,
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
