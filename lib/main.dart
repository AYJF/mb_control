import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/home/home.dart';
import 'package:mb_control/views/welcome/intro.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserHndl())],
      child: MaterialApp(
        title: 'MB-Control',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (_) => const Intro(),
          '/home': (_) => const Home(),
        },
      ),
    );
  }
}
