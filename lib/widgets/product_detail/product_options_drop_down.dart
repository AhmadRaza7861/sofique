import 'package:flutter/material.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';

class ProductOptionsDropDown extends StatefulWidget {
  final Map<String, dynamic> optionMap;
  final Function options;
  final int type;
  ProductOptionsDropDown({Key? key, required this.optionMap, required this.options, required this.type}) : super(key: key) {
    options(
      {
        'optionId': type == 1 ? '${optionMap['option_id']}' : '${optionMap['attribute_id']}',
        'optionValue': type == 1 ? '${optionMap['values'][0]['option_type_id']}' : '${optionMap['values'][0]['value_index']}',
      },
    );
  }

  @override
  _ProductOptionsDropDownState createState() => _ProductOptionsDropDownState();
}

class _ProductOptionsDropDownState extends State<ProductOptionsDropDown> {
  String pdt4 = '5 ML';
  late var valueChoosen = widget.optionMap['values'][0];
  late List listItem = widget.optionMap['values'];
  @override
  Widget build(BuildContext context) {
    // print(widget.optionMap);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                          widget.type == 1 ? '${valueChoosen['title']}' : '${valueChoosen['value_index']}',
                          style: TextStyle(
                            color: SplashScreenPageColors.textColor,
                            fontSize: 12.0,
                            fontFamily: 'Arial, Regular',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            elevation: 0,
                            value: valueChoosen,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: SplashScreenPageColors.textColor,
                              size: 16,
                            ),
                            items: listItem.map((valueItem) {
                              return DropdownMenuItem(
                                  value: valueItem, child: Text(widget.type == 1 ? '${valueItem['title']}' : '${valueItem['value_index']}'));
                            }).toList(),
                            onChanged: (dynamic newValue) {
                              setState(() {
                                // widget.options = {};
                                widget.options(
                                  widget.type == 1
                                      ? {'optionId': '${widget.optionMap['option_id']}', 'optionValue': '${newValue['option_type_id']}'}
                                      : {'optionId': '${widget.optionMap['id']}', 'optionValue': '${newValue['value_index']}'},
                                );
                                valueChoosen = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
    );
  }
}
