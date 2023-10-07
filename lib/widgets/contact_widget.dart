import 'package:contacts_app/screens/contact_details_screen.dart';
import 'package:flutter/material.dart';

class ContactWidgetTile extends StatelessWidget {
  final String name;
  final String image;
  final String id;

  const ContactWidgetTile({
    super.key,
    required this.image,
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactDetailsScreen(
                id: id,
              ),
            ),
          );
        },
        child: ListTile(
          leading: SizedBox(
            width: 60,
            height: 60,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/image1.jpg'),
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
