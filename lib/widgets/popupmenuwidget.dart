import 'package:contacts_app/providers/auth_provider.dart';
import 'package:contacts_app/screens/login_screen.dart';
import 'package:contacts_app/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopUpMenuWidget extends StatelessWidget {
  const PopUpMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem(
              value: '1',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Profile'), Icon(Icons.person)],
              ),
            ),
            const PopupMenuItem(
              value: '2',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logout'),
                  Icon(
                    Icons.logout,
                    size: 18,
                  ),
                ],
              ),
            ),
          ];
        },
        onSelected: (value) {
          if (value == '1') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserProfileScreen(),
              ),
            );
          }
          if (value == '2') {
            context.read<AuthProvider>().signout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
