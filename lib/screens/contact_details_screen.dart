import 'package:contacts_app/screens/contact_update_form_screen.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ContactUpdateFormScreen(
                //       id: widget.id,
                //       email: '',
                //       phone: '',
                //       name: '',
                //     ),
                //   ),
                // );
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
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.more_vert,
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
                // Consumer<ContactsProvider>(
                //   builder: (context, provider, child) {
                //     return Text(
                //       provider.contact.name,
                //       style: const TextStyle(
                //         fontSize: 22,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     );
                //   },
                // ),
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
                    // Consumer<ContactsProvider>(
                    //   builder: (context, provider, child) {
                    //     return Text(
                    //       provider.contact.phone,
                    //       style: const TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     );
                    //   },
                    // ),
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
          SizedBox(
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
                    // Consumer<ContactsProvider>(
                    //   builder: (context, provider, child) {
                    //     return Text(
                    //       provider.contact.email,
                    //       style: const TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     );
                    //   },
                    // ),
                    const Text('Email'),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.email,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
