import 'package:contacts_app/providers/auth_provider.dart';
import 'package:contacts_app/providers/contacts_provider.dart';
import 'package:contacts_app/providers/theme_provider.dart';
import 'package:contacts_app/screens/contact_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ContactUpdateFormScreen extends StatefulWidget {
  final String id;
  final String email;
  final String phone;
  final String name;
  const ContactUpdateFormScreen({
    super.key,
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
  });

  @override
  State<ContactUpdateFormScreen> createState() =>
      _ContactUpdateFormScreenState();
}

class _ContactUpdateFormScreenState extends State<ContactUpdateFormScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Contact Details'),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: context.read<ThemeProvider>().isDark
                      ? Color.fromARGB(255, 55, 55, 55).withOpacity(.7)
                      : Colors.white.withOpacity(.7),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(77, 149, 145, 145),
                      backgroundImage: AssetImage('assets/images/person.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: context.read<ThemeProvider>().isDark
                            ? Colors.black.withOpacity(.7)
                            : const Color.fromARGB(255, 183, 183, 183)),
                    child: TextFormField(
                      controller: _nameController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Enter Name',
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: context.read<ThemeProvider>().isDark
                            ? Colors.black.withOpacity(.7)
                            : const Color.fromARGB(255, 183, 183, 183)),
                    child: TextFormField(
                      controller: _emailController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Enter email',
                        prefixIcon: Icon(Icons.email),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: context.read<ThemeProvider>().isDark
                            ? Colors.black.withOpacity(.7)
                            : const Color.fromARGB(255, 183, 183, 183)),
                    child: TextFormField(
                      controller: _phoneController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Phone',
                        prefixIcon: Icon(Icons.call),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_emailController.text.isNotEmpty &&
                            _phoneController.text.isNotEmpty &&
                            _nameController.text.isNotEmpty) {
                          await context
                              .read<ContactsProvider>()
                              .setLoading(true);
                          await context
                              .read<ContactsProvider>()
                              .updateContactDetails(
                                context.read<AuthProvider>().accessToken,
                                _nameController.text,
                                _emailController.text,
                                _phoneController.text,
                                widget.id,
                              );
                          if (context.read<ContactsProvider>().error.isEmpty &&
                              context
                                  .read<ContactsProvider>()
                                  .contact
                                  .id
                                  .isNotEmpty) {
                            context.read<ContactsProvider>().setLoading(false);
                            _emailController.clear();
                            _nameController.clear();
                            _phoneController.clear();
                            Fluttertoast.showToast(
                                msg: 'Contact Updated Successfully',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactDetailsScreen(
                                  id: context
                                      .read<ContactsProvider>()
                                      .contact
                                      .id,
                                ),
                              ),
                            );
                          } else {
                            context.read<ContactsProvider>().setLoading(false);
                            Fluttertoast.showToast(
                                msg: context.read<ContactsProvider>().error,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else {
                          context.read<AuthProvider>().setLoading(false);
                          Fluttertoast.showToast(
                              msg: "Email,name and phone can not be blank!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 212, 212, 212),
                      ),
                      child: Consumer<ContactsProvider>(
                        builder: (context, provider, child) {
                          return provider.isLoading
                              ? const Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
