import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'Models/country.dart';

class CountryDropDown extends StatelessWidget {
  const CountryDropDown(this.listcountries, {super.key, required this.onChanged, this.selectedItem});

  final List<Country> listcountries;
  final void Function(Country?)? onChanged;
  final Country? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Country'.toUpperCase(),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
            ),
            Text(
              ' *',
              style: TextStyle(fontSize: 11, color: Colors.red),
            ),
          ],
        ),
        SizedBox(height: 10),
        DropdownSearch<Country>(
          items: listcountries,
          selectedItem: selectedItem,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(hintText: "Select Country", border: InputBorder.none),
          ),
          itemAsString: (Country c) => c.fullNameEnglish!,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
