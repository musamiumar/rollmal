import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv

import 'package:rollmal/home.dart';

import 'prompt_data.dart'; // Ensure the correct path

Future<void> main() async {
  // Ensure the WidgetsFlutterBinding is initialized before calling await
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(); // Load your custom env file

  runApp(ChangeNotifierProvider(
    create: (context) => PromptData(),
    child: const MalariaCheckerApp(),
  ));
}

class MalariaCheckerApp extends StatefulWidget {
  const MalariaCheckerApp({super.key});

  @override
  _MalariaCheckerAppState createState() => _MalariaCheckerAppState();
}

class _MalariaCheckerAppState extends State<MalariaCheckerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RollMall Clinic',
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white.withOpacity(0.1)),
        useMaterial3: true,
        fontFamily: GoogleFonts.montserrat().fontFamily,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(
          ThemeData.light().textTheme.copyWith(
                headlineLarge: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                headlineMedium: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                headlineSmall: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                bodyMedium: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
        ),
      ),
      home: const RollMallApp(),
    );
  }
}
