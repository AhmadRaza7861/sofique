import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sofiqe/utils/states/local_storage.dart';
import 'package:sofiqe/widgets/account/signup_form_field.dart';
import 'package:country_code_picker/country_code_picker.dart';

class PhoneNumberField extends StatelessWidget {
  final void Function() onTap;
  final bool isBeingEdited;
  final TextEditingController phoneNumberController;
  final TextEditingController phoneNumberCodeController;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;

  const PhoneNumberField({
    Key? key,
    required this.onTap,
    required this.isBeingEdited,
    required this.phoneNumberController,
    required this.phoneNumberCodeController,
    this.focusNode,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // String locale = await Devicelocale.currentLocale;

    return Container(
      child: SignUpFormField(
        prefix: CountryCodeDropDown(
          callback: (CountryCode code) {
            phoneNumberCodeController.text = code.dialCode as String;
            print(code);
          },
          init: (CountryCode? code) {
            phoneNumberCodeController.text = code!.dialCode as String;
          },
        ),
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        onTap: onTap,
        isBeingEdited: isBeingEdited,
        width: size.width,
        label: 'MY PHONE NUMBER IS',
        controller: phoneNumberController,
        inputType: TextInputType.number,
      ),
    );
  }
}

class CountryCodeDropDown extends StatefulWidget {
  final void Function(CountryCode) callback;
  final void Function(CountryCode?) init;
  final String? byDefaultSelection;
  CountryCodeDropDown({
    Key? key,
    required this.callback,
    required this.init,
    this.byDefaultSelection,
  }) : super(key: key);

  @override
  _CountryCodeDropDownState createState() => _CountryCodeDropDownState();
}

class _CountryCodeDropDownState extends State<CountryCodeDropDown> {
  int? value = 0;
  String? initialSelection = '';
  // String? initialSelection = 'AT';
  @override
  void initState() {
    super.initState();
    // getCountryCode();
  }

  Future<void> getCorrectPhonePrefix() async {
    if (widget.byDefaultSelection != null) {
      initialSelection = widget.byDefaultSelection;
    } else {
      Map countryCodeMap = await sfQueryForSharedPrefData(fieldName: 'country-code', type: PreferencesDataType.STRING);
      if (countryCodeMap['found']) {
        initialSelection = countryCodeMap['country-code'];
        // initialSelection = '+91';
        print('initialSelection  ${initialSelection.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: FutureBuilder(
          future: getCorrectPhonePrefix(),
          builder: (BuildContext c, AsyncSnapshot<void> snapshot) {
            return CountryCodePicker(
              onInit: widget.init,
              onChanged: widget.callback,
              initialSelection: initialSelection,
              padding: EdgeInsets.all(0.0),
              textStyle: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.019,
                  ),
              showFlag: false,
              showCountryOnly: true,
            );
          }),
    );
  }

  Future<void> getCountryCode() async {
    initialSelection = '';
    print(initialSelection);
  }
}
