import 'package:contacts_app/providers/auth_provider.dart';
import 'package:contacts_app/providers/contacts_provider.dart';
import 'package:contacts_app/providers/theme_provider.dart';
import 'package:contacts_app/screens/contact_details_screen.dart';
import 'package:contacts_app/screens/contact_form_screen.dart';
import 'package:contacts_app/screens/login_screen.dart';
import 'package:contacts_app/widgets/contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ContactsProvider>(context, listen: false).fetchContactsList(
        Provider.of<AuthProvider>(context, listen: false).accessToken);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          Consumer<ContactsProvider>(builder: (context, provider, child) {
            final contactslist = provider.contactsList;
            return provider.isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: contactslist.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactDetailsScreen(
                                  id: contactslist[index].id,
                                  name: contactslist[index].name,
                                  email: contactslist[index].email,
                                  phone: contactslist[index].phone,
                                ),
                              ),
                            );
                          },
                          child: ContactWidgetTile(
                              image: 'image', name: contactslist[index].name),
                        );
                      },
                    ),
                  );
          })
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
