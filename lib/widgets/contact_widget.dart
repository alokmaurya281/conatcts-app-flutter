import 'package:flutter/material.dart';

class ContactWidgetTile extends StatelessWidget {
  const ContactWidgetTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: SizedBox(
          width: 60,
          height: 60,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/image1.jpg'),
          ),
        ),
        title: Text(
          'Alok Maurya',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
