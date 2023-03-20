import 'package:flutter/material.dart';

// Utils
import 'package:sofiqe/utils/constants/app_colors.dart';

// Custom packages
import 'package:sofiqe/widgets/wizard/bottom_guide.dart';
import 'package:sofiqe/widgets/wizard/top_guide.dart';

class WizardScreen extends StatefulWidget {
  WizardScreen();

  @override
  _WizardScreenState createState() => _WizardScreenState();
}

class _WizardScreenState extends State<WizardScreen> {
  final List<Map<String, dynamic>> _section = [
    {
      'image': 'assets/images/guide_image_01.png',
      'title': 'TRY-ON PRODUCTS',
      'detail': 'Try-on products from your favourite store or directly from our more than 1.000 products',
      'index': 0,
    },
    {
      'image': 'assets/images/guide_image_02.png',
      'title': 'SKIN ANALYSIS',
      'detail': 'Let Sofiqe make a skin-analysis in the app and get specific product recommendations',
      'index': 1,
    },
    {
      'image': 'assets/images/guide_image_03.png',
      'title': 'GET RECOMMENDATIONS',
      'detail': 'Let Sofiqe make a skin-analysis in the app and get specific product recommendations',
      'index': 2,
    },
    {
      'image': 'assets/images/guide_image_04.png',
      'title': 'WELCOME TO SOFIQE',
      'index': 3,
    },
  ];
  int _sectionIndex = 0;
  late Map<String, dynamic> _currentSection = _section[_sectionIndex];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: TopGuide(
                  demoImageUrl: _currentSection['image'],
                ),
              ),
              BottomGuide(
                sectionData: _currentSection,
                onPressNext: _sectionIndex != 3 ? _nextSection : _nextSection,
                // : () {
                //     _endGuide(context);
                //   },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _nextSection() {
    if (_sectionIndex == 3) {
      _sectionIndex = 0;
    } else {
      _sectionIndex++;
    }

    _currentSection = _section[_sectionIndex];
    setState(() {});
  }
}
