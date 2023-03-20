// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/png_icon.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final bool isTerm;
  final bool isReturnPolicy;

  const PrivacyPolicyScreen(
      {Key? key, required this.isTerm, required this.isReturnPolicy})
      : super(key: key);

  @override
  createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final _key = UniqueKey();

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: [SystemUiOverlay.top]);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.08),

        child: AppBar(
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
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'sofiqe',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: size.height * 0.035,
                    letterSpacing: 0.6),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Text(
                widget.isReturnPolicy
                    ? 'Return Policy'.toUpperCase()
                    : widget.isTerm
                    ? 'Terms and Conditions'.toUpperCase()
                    : 'Privacy Policy'.toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w300),

              ),
              SizedBox(
                height: size.height * 0.025,
              ),
            ],
          ),
        ),
      ),
      // custom
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.all(3),
              child: WebView(
                  backgroundColor: Colors.white,
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (finish) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  // initialUrl: widget.isReturnPolicy ? 'https://dev.sofiqe.com/sReturnsPolicy.htm' : widget.isTerm
                  //     ? 'http://dev.sofiqe.com/sTermsNConditions.htm'
                  //     : 'http://dev.sofiqe.com/sPrivacyPolicy.htm')),
                  initialUrl: widget.isReturnPolicy
                      ? 'https://sofiqe.com/sReturnsPolicy.htm'
                      : widget.isTerm
                          ? 'https://sofiqe.com/sTermsNConditions.htm'
                          : 'https://sofiqe.com/sPrivacyPolicy.htm')),
          Visibility(
            visible: isLoading,
            child: Center(
              child: SpinKitDoubleBounce(
                color: Color(0xffF2CA8A),
                size: 50.0,
              ),
            ),
          ),
        ],
      ),

      // body: SingleChildScrollView(
      //
      //   child: Column(
      //     children: [
      //       Container(
      //
      //         padding: EdgeInsets.only(top: 8),
      //
      //          height:  MediaQuery.of(context).size.height/2,
      //           child: WebView(
      //               key: _key,
      //               javascriptMode: JavascriptMode.unrestricted,
      //               initialUrl: widget.scoreurl)),
      //               Container(
      //                 height: MediaQuery.of(context).size.height/3,
      //
      //                 // flex:2,
      //           child: WebView(
      //               key: _key,
      //               javascriptMode: JavascriptMode.unrestricted,
      //               initialUrl: url))
      //     ],
      //   ),
      // )
    );
  }
}
//                 height: MediaQuery.of(context).size.height/3,