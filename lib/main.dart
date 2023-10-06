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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    // authProvider.getToken();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: context.read<ThemeProvider>().isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: context.read<AuthProvider>().isLoggedIn &&
              context.read<AuthProvider>().accessToken.isNotEmpty
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
