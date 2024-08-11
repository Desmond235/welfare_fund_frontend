import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/payment_service.dart';
import 'package:church_clique/features/payment/data/data.dart';
import 'package:church_clique/features/payment/transaction/models/paystack_auth_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainPaymentScreen extends StatefulWidget {
  const MainPaymentScreen({super.key});

  @override
  State<MainPaymentScreen> createState() => _MainPaymentScreenState();
}

class _MainPaymentScreenState extends State<MainPaymentScreen> {
  String? _url;
  late WebViewController _webViewController;
  late AuthorizationUrl provider;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
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
      );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access the provider and update the URL
    provider = Provider.of<AuthorizationUrl>(context);
    final newUrl = provider.authorization_url;

    // Load the URL only if it has changed
    if (_url != newUrl && newUrl.isNotEmpty) {
      _url = newUrl;
      _webViewController.loadRequest(Uri.parse(_url!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _url == null
            ? Center(child: CircularProgressIndicator())
            : WebViewWidget(controller: _webViewController),
      ),
    );
  }
}
