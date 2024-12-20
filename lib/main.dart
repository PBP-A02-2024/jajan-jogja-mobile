import 'package:flutter/material.dart';
import 'package:jajan_jogja_mobile/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jajan Jogja',
        theme: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: const Color(0xFFE43D12), // orange
            onPrimary: const Color(0xFFFFFFFF), // white
            secondary: const Color(0xFF7C1D05), // darkOrange
            onSecondary: const Color(0xFFFFFFFF), // white
            surface: const Color(0xFFEBE9E1), // white
            onSurface: const Color(0xFF0F0401), // black
            error: const Color(0xFFD6536D), // darkPink
            onError: const Color(0xFFFFFFFF), // white
          ),
          scaffoldBackgroundColor: const Color(0xFFEBE9E1), // white background
          useMaterial3: true,
          textTheme: GoogleFonts.jockeyOneTextTheme( // Apply Jockey One font to text theme
            const TextTheme(
              bodySmall: TextStyle(color: Color(0xFF0F0401)), // black text
              labelSmall: TextStyle(color: Color(0xFF7A7A7A)), // grey text
            ),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: const Color(0xFFEFB11D), // yellow
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: LoginPage(),
      ),
    );
  }
}