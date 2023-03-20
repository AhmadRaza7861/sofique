import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/banner_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Banner 1
class Banner1 extends StatefulWidget {
  const Banner1({Key? key}) : super(key: key);

  @override
  State<Banner1> createState() => _Banner1State();
}

class _Banner1State extends State<Banner1> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<BannerProvider>(
        /// Call Consumer Widget in which data related to Banner will show. The API is already called on Splash Screen.
        builder: (_, provider, __) {
          return Stack(
            children: [

              Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        )
                      ]),
                  width: size.width,
                  //padding: EdgeInsets.symmetric(vertical: size.height * 0.028),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      debuggingEnabled: true,
                      initialUrl: provider.bannerListModel![0].cmspageUrl,
                      onPageFinished: (finish) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  )),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(),
            ],
          );
        },
      ),
    );
  }
}

/// Banner 2
class Banner2 extends StatefulWidget {
  const Banner2({Key? key}) : super(key: key);

  @override
  State<Banner2> createState() => _Banner2State();
}

class _Banner2State extends State<Banner2> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<BannerProvider>(
        /// Call Consumer Widget in which data related to Banner will show. The API is already called on Splash Screen.

        builder: (_, provider, __) {
          return Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        )
                      ]),
                  width: size.width,
                  //padding: EdgeInsets.symmetric(vertical: size.height * 0.028),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      debuggingEnabled: true,
                      initialUrl: provider.bannerListModel![1].cmspageUrl,
                      onPageFinished: (finish) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  )),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(),
            ],
          );
        },
      ),
    );
  }
}

/// Banner 3
class Banner3 extends StatefulWidget {
  const Banner3({Key? key}) : super(key: key);

  @override
  State<Banner3> createState() => _Banner3State();
}

class _Banner3State extends State<Banner3> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<BannerProvider>(
        /// Call Consumer Widget in which data related to Banner will show. The API is already called on Splash Screen.
        builder: (_, provider, __) {
          return Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        )
                      ]),
                  width: size.width,
                  //padding: EdgeInsets.symmetric(vertical: size.height * 0.028),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      debuggingEnabled: true,
                      initialUrl: provider.bannerListModel![2].cmspageUrl,
                      onPageFinished: (finish) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  )),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
