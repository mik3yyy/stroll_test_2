import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stroll_test/core/routes/routes.dart';
import 'package:stroll_test/core/services/injection_container.dart' as di;
import 'package:stroll_test/core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(
  //     fileName:
  //         'application/.env'); // Load environment variables from application folder
  await di.init(); // Initialize dependency injection
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'stroll_test',
      theme: appTheme,
      routerConfig: Routes.router,
    );
  }
}
