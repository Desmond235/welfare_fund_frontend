import 'package:church_clique/features/payment/data/data.dart';
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
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            setState(() {
              _hasError = true;
            });
            Center(child: Text('An error occurred'),);
          },
          onPageFinished: (url) {
            setState(() {
              _hasError = false;
            });
          },
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
      print(newUrl);
      _webViewController.loadRequest(Uri.parse(_url!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _url == null
            ? Center(child: CircularProgressIndicator())
            : _hasError
                ? Center(child: Text('An error occurred'))
                : WebViewWidget(controller: _webViewController),
      ),
    );
  }
}
