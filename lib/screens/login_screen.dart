import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sofiqe/widgets/account/login_page.dart';
import 'package:sofiqe/widgets/png_icon.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'sofiqe',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white, fontSize: size.height * 0.035, letterSpacing: 0.6),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Text(
                "LET'S LOGIN",
                style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
            ],
          ),
        ),
      ),
      body: LoginPage(),
    );
  }
}