import 'package:flutter/material.dart';

class ContactDetailsScreen extends StatefulWidget {
  const ContactDetailsScreen({super.key});

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name of contact'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.edit,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.qr_code,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/image1.jpg'),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Name of contact',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '0987654321',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text('Mobile'),
                  ],
                ),
              ),
              Row(
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
          )
        ],
      ),
    );
  }
}
