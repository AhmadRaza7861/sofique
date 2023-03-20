import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/screens/login_screen.dart';
import 'package:sofiqe/screens/signup_screen.dart';
import 'package:sofiqe/widgets/capsule_button.dart';
import 'package:sofiqe/widgets/profile_picture.dart';

class GeneralAccountScreen extends StatelessWidget {
  final Function onSuccess;
  final String message;
  final String prompt;
  const GeneralAccountScreen({
    Key? key,
    required this.onSuccess,
    required this.message,
    required this.prompt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'sofiqe',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: size.height * 0.035,
                  ),
            ),
            Container(
              height: size.height * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfilePicture(),
                  Container(
                    width: size.width * 0.7,
                    child: Text(
                      '$message',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.white,
                            fontSize: size.height * 0.022,
                          ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.7,
                    child: Text(
                      '$prompt',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.white,
                            fontSize: size.height * 0.014,
                          ),
                    ),
                  ),
                  CapsuleButton(
                    backgroundColor: Color(0xFFF2CA8A),
                    height: size.height * 0.068,
                    width: size.width * 0.7,
                    onPress: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext c) {
                            return SignupScreen();
                          },
                        ),
                      );
                      if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
                        this.onSuccess();
                      }
                    },
                    child: Text(
                      'JOIN SOFIQE FOR FREE',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.black,
                            fontSize: size.width * 0.034,
                            letterSpacing: 0,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            CapsuleButton(
              borderColor: Colors.white54,
              height: size.height * 0.068,
              width: size.width * 0.7,
              onPress: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext c) {
                      return LoginScreen();
                    },
                  ),
                );
                if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
                  this.onSuccess();
                }
              },
              child: Text(
                'ALREADY A SOFIQE? SIGN IN',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.white,
                      fontSize: size.width * 0.034,
                      letterSpacing: 0,
                    ),
              ),
            ),
            SizedBox(height: size.height * 0.001),
          ],
        ),
      ),
    );
  }
}
