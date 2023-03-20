import 'package:flutter/material.dart';

// Utils
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/utils/constants/route_names.dart';
import 'package:sofiqe/utils/states/launch_status.dart';

// 3rd party packages

// Custom packages
import 'package:sofiqe/widgets/capsule_button.dart';
import 'package:sofiqe/widgets/wizard/bubble_tab.dart';
import 'package:sofiqe/widgets/privacy_policy.dart';

class BottomGuide extends StatelessWidget {
  final Function onPressNext;
  final Map<String, dynamic> sectionData;
  BottomGuide({required this.onPressNext, required this.sectionData});

  @override
  Widget build(BuildContext context) {
    int currentIndex = sectionData['index'];
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.32,
      child: Stack(
        children: [
          Column(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 100),
                child: _GuideTabs(
                    key: Key('$currentIndex'), current: sectionData['index']),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 100),
                child: _GuideTitle(
                    key: Key('$currentIndex'), title: sectionData['title']),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 100),
                child: currentIndex != 3
                    ? _GuideDetail(
                        key: Key('$currentIndex'),
                        detail: sectionData['detail'])
                    : _GuideDetail(
                        key: Key('$currentIndex'),
                        detail: "\n\n"),
              ),
              currentIndex != 3
                  ? _GuideNext(
                      key: Key('$currentIndex'),
                      onPressNext: onPressNext,
                    )
                  : _GuideNextPage(
                      key: Key('$currentIndex'),
                    ),
            ],
          ),
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    child: currentIndex != 3
                        ? Container()
                        : Container(
                            margin: EdgeInsets.all(24),
                            child: PrivacyPolicy())),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GuideTabs extends StatelessWidget {
  final int current;
  _GuideTabs({Key? key, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.width * 0.06, horizontal: 20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: BubbleTab(length: 4, current: current),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  skipIntro(context);
                },
                child: Text(
                  '${current != 3 ? 'skip intro' : ''}',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: size.width < 400 ? 8 : 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              )),
        ],
      ),
    );
  }

  void skipIntro(BuildContext c) async {
    await sfAppLaunchedOnce();
    Navigator.pushReplacementNamed(c, RouteNames.homeScreen);
  }
}

class _GuideTitle extends StatelessWidget {
  final String title;
  _GuideTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),

      // width: 260,
      child: Text(
        '$title',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              fontSize: size.width > 400 ? 24 : 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
      ),
    );
  }
}

class _GuideDetail extends StatelessWidget {
  // Animation
  final String? detail;
  _GuideDetail({Key? key, this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: 0),
      width: size.width * 0.6,
      // height: 30,
      child: Text(
        '$detail',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              fontSize: size.width < 400 ? 9 : 16,
              letterSpacing: 0.45,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

class _GuideNext extends StatelessWidget {
  final Function onPressNext;
  _GuideNext({Key? key, required this.onPressNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(media.width * 0.008),
      child: CapsuleButton(
        horizontalPadding: 22,
        width: media.aspectRatio < 18 / 37 ? 94 : 60,
        height: media.aspectRatio < 18 / 37 ? 60 : 38,
        child: Image.asset(
          'assets/icons/arrow-2.png',
          width: media.aspectRatio < 18 / 37 ? 18.5 : 22,
          height: media.aspectRatio < 18 / 37 ? 10.2 : 12.3,
        ),
        onPress: () {
          onPressNext();
        },
      ),
    );
  }
}

class _GuideNextPage extends StatefulWidget {
  _GuideNextPage({Key? key}) : super(key: key);

  @override
  __GuideNextPageState createState() => __GuideNextPageState();
}

class __GuideNextPageState extends State<_GuideNextPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return FadeTransition(
      opacity: _animation,
      child: Container(
        // margin: EdgeInsets.only(
        //     top: media.aspectRatio > 18 / 37
        //         ? media.width * 0.05
        //         : media.width * 0.12),
      margin: EdgeInsets.all(media.width * 0.008),
        child: CapsuleButton(
          width: media.aspectRatio < 18 / 37 ? media.width * 0.5 : 140,
          height: media.aspectRatio < 18 / 37 ? media.width * 0.15 : 39.60,
          child: Text(
            'GO',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: 13,
                  wordSpacing: 0.65,
                  color: AppColors.primaryColor,
                ),
          ),
          onPress: () {
            finishGuide(context);
          },
        ),
      ),
    );
  }

  void finishGuide(BuildContext c) async {
    await sfAppLaunchedOnce();
    Navigator.pushReplacementNamed(c, RouteNames.homeScreen);
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    //todo: uncomment bellow.
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }
}
