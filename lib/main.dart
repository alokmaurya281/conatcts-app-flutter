import 'package:contacts_app/providers/auth_provider.dart';
import 'package:contacts_app/providers/theme_provider.dart';
import 'package:contacts_app/screens/home_screen.dart';
import 'package:contacts_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: context.read<ThemeProvider>().isDark
            ? ThemeMode.dark
            : ThemeMode.light,
        home: context.read<AuthProvider>().isLoggedIn
            ? const HomeScreen()
            : const LoginScreen());
  }
}
