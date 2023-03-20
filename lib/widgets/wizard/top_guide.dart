import 'package:flutter/material.dart';

class TopGuide extends StatelessWidget {
  final String demoImageUrl;
  TopGuide({required this.demoImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.70,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          image: AssetImage('assets/images/wizard_background.png'),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _SofiqeBrand(),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child:
                _GuideImage(key: Key(demoImageUrl), demoImageUrl: demoImageUrl),
          ),
        ],
      ),
    );
  }
}

class _SofiqeBrand extends StatelessWidget {
  _SofiqeBrand();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Text(
        'sofiqe',
        style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: 30,
            ),
      ),
    );
  }
}

class _GuideImage extends StatelessWidget {
  final String demoImageUrl;

  _GuideImage({Key? key, required this.demoImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.37,
      //width: size.width * 0.,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('$demoImageUrl'),
        ),
      ),
    );
  }
}
