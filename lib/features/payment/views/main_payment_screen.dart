import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/payment_service.dart';
import 'package:church_clique/features/payment/data/data.dart';
import 'package:church_clique/features/payment/transaction/models/paystack_auth_response.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainPaymentScreen extends StatefulWidget {
  const MainPaymentScreen({super.key});

  @override
  State<MainPaymentScreen> createState() => _MainPaymentScreenState();
}

class _MainPaymentScreenState extends State<MainPaymentScreen> {
  String? _url;

  @override
  void initState() {
    super.initState();
    _loadUrl();
  }

  // Updated getUrl function
  Future<String> getUrl() async {
    final prefs = await sharedPrefs;
    return prefs.getString('authUrl') ?? '';
  }

  // Load URL and set state
  Future<void> _loadUrl() async {
    final url = await getUrl();
    setState(() {
      _url = url;
    });
  }

  WebViewController controller() {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color(0x00000000))
      ..setNavigationDelegate(  
        NavigationDelegate(
          onPageFinished: (url) {},
          onNavigationRequest: (request) {
            if (request.url.startsWith('http://www.youtube.com')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_url!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _url == null
            ? Center(child: CircularProgressIndicator())
            : WebViewWidget(controller: controller()),
      ),
    );
  }
}
