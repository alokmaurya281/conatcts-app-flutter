import 'package:contacts_app/providers/auth_provider.dart';
import 'package:contacts_app/providers/contacts_provider.dart';
import 'package:contacts_app/providers/theme_provider.dart';
import 'package:contacts_app/screens/contact_form_screen.dart';
import 'package:contacts_app/widgets/contact_widget.dart';
import 'package:contacts_app/widgets/popupmenuwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void data() {
    Provider.of<ContactsProvider>(context, listen: false).fetchContactsList(
        Provider.of<AuthProvider>(context, listen: false).accessToken);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Contacts'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
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
          const PopUpMenuWidget(),
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
          Consumer<ContactsProvider>(
            builder: (context, provider, child) {
              final contactslist = provider.contactsList;
              return Expanded(
                child: provider.isLoading
                    ? Shimmer.fromColors(
                        period: const Duration(seconds: 2),
                        baseColor: const Color.fromARGB(255, 140, 140, 140),
                        highlightColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: CircleAvatar(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    : contactslist.length == 0
                        ? Text('No contact found')
                        : ListView.builder(
                            itemCount: contactslist.length,
                            itemBuilder: (context, index) {
                              return ContactWidgetTile(
                                image: 'image',
                                name: contactslist[index].name,
                                id: contactslist[index].id,
                              );
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
