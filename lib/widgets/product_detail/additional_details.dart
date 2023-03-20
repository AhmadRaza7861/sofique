import 'package:flutter/material.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';

class AdditionalOptions extends StatelessWidget {
  final List details;
  AdditionalOptions({Key? key, required this.details}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(details);
    return Container(
      child: Column(
        children: [
          ...details.map((detail) {
            String attributeName = detail['attribute_code'];
            switch (attributeName) {
              case 'ingredients':
                return _AdditionalOption(optionName: attributeName, description: detail['value']);
              case 'directions':
                return _AdditionalOption(optionName: attributeName, description: detail['value']);
              default:
                return Container();
            }
          }).toList(),
        ],
      ),
    );
  }
}

class _AdditionalOption extends StatefulWidget {
  final String optionName;
  final String description;
  const _AdditionalOption({Key? key, required this.optionName, required this.description}) : super(key: key);

  @override
  __AdditionalOptionState createState() => __AdditionalOptionState();
}

class __AdditionalOptionState extends State<_AdditionalOption> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Container(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            '${widget.optionName[0].toUpperCase()}${widget.optionName.substring(1)}',
                            style: TextStyle(
                              color: SplashScreenPageColors.textColor,
                              fontFamily: 'Arial, Regular',
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            expanded = !expanded;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.add,
                              color: SplashScreenPageColors.textColor,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: expanded ? 10 : 0),
                  expanded
                      ? Container(
                          child: Text(
                            '${widget.description}',
                            style: Theme.of(context).textTheme.headline2!.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Divider(
              height: 0,
              color: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
