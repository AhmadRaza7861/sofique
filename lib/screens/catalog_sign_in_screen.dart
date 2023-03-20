import 'package:flutter/material.dart';

// Custom packges
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/translucent_background.dart';
import 'package:sofiqe/widgets/catalog/catalogSignIn/catalog_sign_in.dart';

class CatalogSignInScreen extends StatelessWidget {
  const CatalogSignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          'sofiqe',
          style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white, fontSize: 25, letterSpacing: 2.5),
        ),
      ),
      body: _CatalogSignInPage(),
    );
  }
}

class _CatalogSignInPage extends StatelessWidget {
  const _CatalogSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _CatalogSignInBackgroundImage(),
        TranslucentBackground(opacity: 0.3, color: Colors.black),
        CatalogSignIn(),
      ],
    );
  }
}

class _CatalogSignInBackgroundImage extends StatelessWidget {
  const _CatalogSignInBackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/catalog_signin_proceed_background.png'),
        ),
      ),
    );
  }
}
