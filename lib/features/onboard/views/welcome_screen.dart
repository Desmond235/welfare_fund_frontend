import 'package:church_clique/core/constants/constants.dart';
// ignore: unused_import
import 'package:church_clique/features/auth/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              priCol(context).withOpacity(0.8),
              priCol(context).withOpacity(0.75),
              priCol(context),
            ])),
            child: ShaderMask(
              blendMode: BlendMode.dstOut,
              shaderCallback: (rect) {
                return LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.0),
                    ]).createShader(rect);
              },
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/images/welcome.jpg',
                  ),
                  fit: BoxFit.cover
                )),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome to Church',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.95)),
                      ),
                      TextSpan(
                        text: '\nClique',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.95)),
                      ),
                      TextSpan(
                        text: '\n\nCreate a new account or login to access .',
                        style: TextStyle(fontSize: 16, ),
                      ),
                      TextSpan(
                        text: '\n your personalized welfare management app.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 30,
              right: 30,
              left: 30,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: priCol(context),
                    padding: const EdgeInsets.all(20)),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('auth');
                },
                child: Text(
                  'GET STARTED',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ))
        ],
      ),
    );
  }
}
