import 'package:contacts_app/providers/auth_provider.dart';
import 'package:contacts_app/providers/theme_provider.dart';
import 'package:contacts_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  void data() {
    Provider.of<UserProvider>(context, listen: false).userProfileData(
      Provider.of<AuthProvider>(context, listen: false).accessToken,
    );
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
        title: Text(
          'My Profile',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          if (provider.user.username.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          _emailController.text = context.read<UserProvider>().user.email;
          _usernameController.text = context.read<UserProvider>().user.username;
          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: context.read<ThemeProvider>().isDark
                    ? Color.fromARGB(255, 55, 55, 55).withOpacity(.7)
                    : Colors.white.withOpacity(.7),
                borderRadius: BorderRadius.circular(15),
              ),
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
                      controller: _usernameController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Enter Username',
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
                      enabled: false,
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
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_emailController.text.isNotEmpty &&
                            _usernameController.text.isNotEmpty) {
                          await context.read<UserProvider>().setLoading(true);
                          await context.read<UserProvider>().updateUserData(
                                context.read<AuthProvider>().accessToken,
                                _usernameController.text,
                                _emailController.text,
                              );
                          if (context.read<UserProvider>().error.isEmpty &&
                              context.read<UserProvider>().user.id.isNotEmpty) {
                            context.read<UserProvider>().setLoading(false);
                            _emailController.clear();
                            _usernameController.clear();
                            Fluttertoast.showToast(
                                msg: 'User Updated Successfully',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ContactDetailsScreen(
                            //       id: context
                            //           .read<UserProvider>()
                            //           .contact
                            //           .id,
                            //     ),
                            //   ),
                            // );
                          } else {
                            context.read<UserProvider>().setLoading(false);
                            Fluttertoast.showToast(
                                msg: context.read<UserProvider>().error,
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
                              msg: "Email,username can not be blank!!",
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
                      child: Consumer<UserProvider>(
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
          );
        },
      ),
    );
  }
}
