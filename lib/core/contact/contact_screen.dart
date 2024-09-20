import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                leading: Image.asset(
                  'assets/images/Gmail-Logo.png',
                  scale: 60,
                ),
                title: Text(dotenv.env['EMAIL']!,),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Image.asset(
                  'assets/images/linkedin.png',
                  scale: 70,
                ),
                title: Text(dotenv.env['LINKEDIN']!,),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
