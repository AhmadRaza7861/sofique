import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ClearPayPayment extends StatefulWidget {
  final void Function(String) callback;

  final String redirectUrl;

  ClearPayPayment({required this.redirectUrl, required this.callback});

  @override
  State<StatefulWidget> createState() {
    return ClearPayPaymentState();
  }
}

class ClearPayPaymentState extends State<ClearPayPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String returnURL = 'https://sofiqe.com/clearpayconfirm.html';
  String cancelURL = 'https://sofiqe.com/clearpaycancel.html';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.redirectUrl);
    if (widget.redirectUrl != "null") {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.08),
          child: AppBar(
            // toolbarHeight: size.height * 0.11,
            leading: IconButton(
              icon: Transform.rotate(
                angle: 3.14159,
                child: PngIcon(
                  image: 'assets/icons/arrow-2-white.png',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'sofiqe',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white, fontSize: 25, letterSpacing: 2.5),
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text(
                  'Clearpay',
                  style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
              ],
            ),
          ),
        ),
        body: WebView(
          initialUrl: widget.redirectUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            print("returnURL=${request.url}");
            // widget.onFinish("SUCCESS");
            // Navigator.of(context).pop();
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final status = uri.queryParameters['status'];
              if (status!.contains("SUCCESS")) {
                widget.callback("SUCCESS");
                // widget.onFinish("SUCCESS");
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context1) {
                //   return OrderProcessing(
                //     cardDetails: "SUCCESS",
                //     payment_method: "clearPay",
                //   );
                // }));
                Navigator.of(context).pop();
              } else {
                Get.showSnackbar(GetSnackBar(
                  title: "Order",
                  message: "Payment failed.",
                  duration: Duration(milliseconds: 1500),
                ));
                Navigator.of(context).pop();
              }
            }
            if (request.url.contains(cancelURL)) {
              Get.showSnackbar(GetSnackBar(
                title: "Order",
                message: "Payment failed or Canceled.",
                duration: Duration(milliseconds: 1500),
              ));
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: size.height * 0.11,
          leading: Padding(
            padding: EdgeInsets.only(top: 30.0, left: 20),
            child: Container(
              child: IconButton(
                icon: Transform.rotate(
                  angle: 3.14159,
                  child: PngIcon(
                    image: 'assets/icons/arrow-2-white.png',
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Column(
            children: [
              Text(
                'sofiqe',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white, fontSize: 25, letterSpacing: 2.5),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Clearpay',
                style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1),
              ),
            ],
          ),
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}