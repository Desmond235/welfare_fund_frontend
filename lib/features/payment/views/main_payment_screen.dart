import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/verify_payment_service.dart';
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
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          
          onWebResourceError: (error) {
            setState(() {
              _hasError = true;
            });
            const Center(
              child: Text('An error occurred'),
            );
          },
          onPageFinished: (url) {
            print(url);
            setState(() {
              _hasError = false;
            });
          },
          onUrlChange: (change) {
            // print(change);
          },
          onNavigationRequest: (request) async {
            if(request.url.contains('facebook.com')){
              // final payment = await verifyPayment(_url!);
              // print(payment.data);
              print('authorization url: ${request.url.toString()}');
              Navigator.pop(context);
            }
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
            ? const Center(child: CircularProgressIndicator())
            : _hasError
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error),
                            const Text('An error occurred'),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: priCol(context),
                              ),
                              onPressed: () {
                                _webViewController.reload();
                              },
                              child: const Text(
                                'reload',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                : WebViewWidget(controller: _webViewController),
      ),
    );
  }
}
