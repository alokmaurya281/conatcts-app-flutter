import 'package:flutter/material.dart';

class ContactWidgetTile extends StatelessWidget {
  final String name;
  final String image;
  const ContactWidgetTile({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
    );
  }
}
