import 'package:flutter/material.dart';
import 'package:sofiqe/widgets/custom_drop_down.dart';

class CountryDropDown extends StatefulWidget {
  final Function onSelect;
  final List countryList;
  CountryDropDown({Key? key, required this.onSelect, required this.countryList}) : super(key: key);

  @override
  _CountryDropDownState createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
  late var country = widget.countryList[0];
  late var region;
  var showRegion = false;

  @override
  Widget build(BuildContext context) {
    if (country.containsKey('available_regions')) {
      showRegion = true;
      if (region == null) {
        region = country['available_regions'][0];
      }
    } else {
      showRegion = false;
      region = null;
    }
    return Container(
      child: Column(
        children: [
          CustomDropDown(
            getLabel: (item) {
              return item['full_name_english'];
            },
            label: 'COUNTRY',
            items: widget.countryList,
            initialValue: country,
            callback: (newVal) {
              country = newVal;
              widget.onSelect(newVal, null);
              setState(() {});
            },
            width: MediaQuery.of(context).size.width,
          ),
          showRegion ? SizedBox(height: 24) : Container(),
          showRegion
              ? CustomDropDown(
                  getLabel: (item) {
                    return item['name'];
                  },
                  label: 'REGION',
                  items: country['available_regions'],
                  initialValue: region,
                  callback: (newVal) {
                    region = newVal;
                    widget.onSelect(country, newVal);
                    setState(() {});
                  },
                  width: MediaQuery.of(context).size.width,
                )
              : Container(),
        ],
      ),
    );
  }
}
