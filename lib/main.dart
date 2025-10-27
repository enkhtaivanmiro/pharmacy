import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/prescription_form_screen.dart';

void main() {
  runApp(const EmniinJorApp());
}

class EmniinJorApp extends StatelessWidget {
  const EmniinJorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Эмийн Жор',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,

        // Use Noto Sans (Cyrillic/Mongolian support)
        fontFamily: GoogleFonts.notoSans().fontFamily,
        textTheme: GoogleFonts.notoSansTextTheme(
          TextTheme(
            headlineMedium: TextStyle(
              color: const Color(0xFF424242),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            bodyLarge: TextStyle(
              color: const Color(0xFF616161),
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              color: const Color(0xFF757575),
              fontSize: 14,
            ),
          ),
        ),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2),
          surface: Colors.white,
        ),

        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        cardColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1976D2),
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
        ),

        // <-- IMPORTANT: use CardThemeData here (not CardTheme widget)
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Color(0xFF1976D2), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFF757575)),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1976D2),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
        ),
      ),
      home: const PrescriptionFormScreen(),
    );
  }
}
