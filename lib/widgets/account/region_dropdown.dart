import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sofiqe/widgets/account/Models/country.dart';

class AvailableRegionsDropDown extends StatelessWidget {
  const AvailableRegionsDropDown(this.listcountries, {super.key, required this.onChanged, this.selectedItem});

  final List<AvailableRegions> listcountries;
  final void Function(AvailableRegions?)? onChanged;
  final AvailableRegions? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Region'.toUpperCase(),
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
        DropdownSearch<AvailableRegions>(
          items: listcountries,
          selectedItem: selectedItem,
          itemAsString: (AvailableRegions c) => c.name!,
          onChanged: onChanged,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(hintText: "Select Region", border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
