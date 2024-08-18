import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/features/onboard/provider/onboard_state_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  PageController controller = PageController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void sendData() {
    final provider = Provider.of<OnboardStatePage>(context, listen: false);
    if (provider.currentPage == 4) {
      Navigator.pushReplacementNamed(context, 'auth');
    } else {
      provider.incrementPage();
      controller.animateToPage(
        provider.currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardStatePage>(
      builder: (_, ref, __) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: mainSystemUiOverlayStyle(context),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Membership Form'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    Expanded(
                      child: AnimatedBuilder(
                        animation: ref,
                        builder: (context, child) {
                          return PageView.builder(
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: kOnboardPage.length,
                            itemBuilder: (context, index) {
                              return kOnboardPage[index];
                            },
                            onPageChanged: (value) {
                              ref.setCurrentPage(value);
                            },
                          );
                        },
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
