import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';

class StaticDetails extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  StaticDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(json.decode(data).runtimeType);
    List details = [];
    data['values'].forEach(
      (key, value) {
        var option;
        switch (key) {
          case 'shippinganddelivery':
            option = 'Shipping And Delivery';
            break;
          case 'returnsandexchanges':
            option = 'Returns And Exchanges';
            break;
          default:
            option = key;
        }
        if (key != "packaging") details.add(_StaticDetail(optionName: option, description: value));
      },
    );
    return Container(
      child: Column(
        children: [
          ...details,
        ],
      ),
    );
  }
}

class _StaticDetail extends StatefulWidget {
  final optionName;
  final String description;
  const _StaticDetail({Key? key, required this.optionName, required this.description}) : super(key: key);

  @override
  __StaticDetailState createState() => __StaticDetailState();
}

class __StaticDetailState extends State<_StaticDetail> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
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
                            widget.optionName[0].toLowerCase() == "packaging"
                                ? ''
                                : '${widget.optionName[0].toUpperCase()}${widget.optionName.substring(1)}',
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
                          color: Colors.white,
                          child: Html(
                            data: '${widget.description}',
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
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
