import 'package:contacts_app/providers/auth_provider.dart';
import 'package:contacts_app/providers/contacts_provider.dart';
import 'package:contacts_app/providers/theme_provider.dart';
import 'package:contacts_app/screens/contact_form_screen.dart';
import 'package:contacts_app/screens/login_screen.dart';
import 'package:contacts_app/widgets/contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Consumer<ThemeProvider>(
              builder: (context, provider, child) {
                return GestureDetector(
                  onTap: () {
                    provider.setTheme();
                  },
                  child: Icon(
                    context.read<ThemeProvider>().isDark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    size: 24,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () async {
                await context.read<AuthProvider>().signout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.logout,
                size: 24,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(144, 212, 212, 212)),
            child: TextFormField(
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Search Contacts',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: context
                .read<ContactsProvider>()
                .fetchContactsList(context.read<AuthProvider>().accessToken),
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.builder(
                  itemCount:
                      context.read<ContactsProvider>().contactsList.length,
                  itemBuilder: (context, index) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor:
                            const Color.fromARGB(255, 232, 230, 230),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircleAvatar(),
                            ),
                          ],
                        ),
                      );
                    } else {
                      final value =
                          context.read<ContactsProvider>().contactsList;
                      return ContactWidgetTile(
                        image: '',
                        name: value[index].email,
                      );
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ContactFormScreen(),
            ),
          );
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 133, 18, 226),
          ),
          child: const Icon(
            Icons.add,
            color: Color.fromRGBO(215, 215, 215, 1),
            size: 36,
          ),
        ),
      ),
    );
  }
}
