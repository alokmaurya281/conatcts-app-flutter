import 'package:contacts_app/providers/auth_provider.dart';
import 'package:contacts_app/providers/contacts_provider.dart';
import 'package:contacts_app/screens/contact_update_form_screen.dart';
import 'package:contacts_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ContactDetailsScreen extends StatefulWidget {
  final String id;

  const ContactDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  void data() {
    Provider.of<ContactsProvider>(context, listen: false).getContactDetailsById(
        Provider.of<AuthProvider>(context, listen: false).accessToken,
        widget.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactsProvider>(
      builder: (context, provider, child) {
        if (provider.contact.name.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              provider.contact.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUpdateFormScreen(
                          id: widget.id,
                          email: provider.contact.email,
                          phone: provider.contact.phone,
                          name: provider.contact.name,
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.edit,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.qr_code,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/person.png'),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    provider.contact.name.isEmpty
                        ? Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 102, 101, 101),
                            highlightColor: Colors.grey,
                            child: const SizedBox(
                              width: 100,
                              height: 40,
                            ),
                          )
                        : Text(
                            provider.contact.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.contact.phone,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text('Mobile'),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.call,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.chat,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.contact.email,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text('Email'),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.email,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: SizedBox(
                  width: 160,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(179, 245, 61, 5),
                        shadowColor: Colors.black),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog.adaptive(
                              title: const Text('Confirm'),
                              content: const Text(
                                  'Are you sure you want to delete this contact?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                ),
                                TextButton(
                                  child: provider.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        )
                                      : const Text('Confirm'),
                                  onPressed: () async {
                                    provider.setLoading(true);
                                    await provider.deleteContactbyId(
                                      context.read<AuthProvider>().accessToken,
                                      widget.id,
                                    );
                                    provider.setLoading(false);
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                      ),
                                    ); // Close the dialog
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Delete Contact'),
                        Icon(Icons.delete),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
