import 'package:flutter/material.dart';
import 'package:sofiqe/widgets/png_icon.dart';

class GenderSelector extends StatefulWidget {
  final Function onSelect;
  const GenderSelector({Key? key, required this.onSelect}) : super(key: key);

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String current = 'female';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1, vertical: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'I\'M A',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.014,
                  letterSpacing: 0.4,
                ),
          ),
          SizedBox(height: size.height * 0.022),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  current = 'female';
                  widget.onSelect('female');
                  setState(() {});
                },
                child: GenderOption(
                  value: 'female',
                  current: current,
                  icon: 'assets/icons/gender_female.png',
                  name: 'female',
                ),
              ),
              GestureDetector(
                onTap: () {
                  current = 'male';
                  widget.onSelect('male');
                  setState(() {});
                },
                child: GenderOption(
                  value: 'male',
                  current: current,
                  icon: 'assets/icons/gender_male.png',
                  name: 'male',
                ),
              ),
              GestureDetector(
                onTap: () {
                  current = 'genderless';
                  widget.onSelect('genderless');
                  setState(() {});
                },
                child: GenderOption(
                  value: 'genderless',
                  current: current,
                  icon: 'assets/icons/gender_genderless.png',
                  name: 'genderless',
                ),
              ),
              GestureDetector(
                onTap: () {
                  current = 'lgbt';
                  widget.onSelect('lgbt');
                  setState(() {});
                },
                child: GenderOption(
                  value: 'lgbt',
                  current: current,
                  icon: 'assets/icons/gender_lbgt.png',
                  name: 'lgbt',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GenderOption extends StatelessWidget {
  final String icon;
  final String name;
  final String current;
  final String value;
  const GenderOption(
      {Key? key,
      required this.icon,
      required this.name,
      required this.current,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.11,
      width: size.width * 0.18,
      decoration: BoxDecoration(
        color: value == current ? Color(0xFFF4F2F0) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: value == current ? Color(0xFFF2CA8A) : Colors.white,
            width: 1.5,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PngIcon(image: icon, height: size.height * 0.028),
          Text(
            '${name.toUpperCase()}',
            textAlign: TextAlign.center,
            softWrap: false,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.011,
                  letterSpacing: 0.4,
                ),
          ),
        ],
      ),
    );
  }
}
