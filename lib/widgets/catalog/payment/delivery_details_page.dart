import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/controller/msProfileController.dart';
import 'package:sofiqe/model/AddressClass.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/checkout_screen.dart';
import 'package:sofiqe/utils/api/shipping_address_api.dart';
import 'package:sofiqe/utils/api/shopping_cart_api.dart';
import 'package:sofiqe/utils/api/user_account_api.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';
import 'package:sofiqe/utils/states/user_account_data.dart';
import 'package:sofiqe/widgets/account/Models/country.dart';
import 'package:sofiqe/widgets/account/phone_number_field.dart';
import 'package:sofiqe/widgets/capsule_button_checkout.dart';
import 'package:sofiqe/widgets/custom_form_field.dart';
import 'package:sofiqe/widgets/custom_white_cards.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/states/local_storage.dart';
import '../../account/country_dropdown.dart';
import '../../account/region_dropdown.dart';
import '../../field_loader.dart';

class DeliveryDetailsPage extends StatefulWidget {
  final void Function(Map<String, String>) callback;
  final String paycodeKey;

  DeliveryDetailsPage(this.paycodeKey, {Key? key, required this.callback}) : super(key: key);

  @override
  State<DeliveryDetailsPage> createState() => _DeliveryDetailsPageState();
}

class _DeliveryDetailsPageState extends State<DeliveryDetailsPage> {
  MsProfileController _ = Get.find<MsProfileController>();
  String orderId = "";

  @override
  void initState() {
    super.initState();
    // Get.put(CartProvider());

    addLisnertoController();
    loadcontrollers();
    loadCountries();
    loaddataToControllers();
    if (!_.isShiping.value) {
      billingInformation = "Off";
    } else {
      billingInformation = "On";
    }
  }

  loaddataToControllers() async {
    dynamic shipping_address =
        await sfQueryForSharedPrefData(fieldName: 'shipping_address', type: PreferencesDataType.STRING);
    dynamic billing_address =
        await sfQueryForSharedPrefData(fieldName: 'billing_address', type: PreferencesDataType.STRING);
    dynamic phoneNoCode = await sfQueryForSharedPrefData(fieldName: 'phone_no_code', type: PreferencesDataType.STRING);
    dynamic phoneNoCodeBilling =
        await sfQueryForSharedPrefData(fieldName: 'phone_no_code_billing', type: PreferencesDataType.STRING);

    print("Shippind Data");
    print(shipping_address);

    if (shipping_address["found"]) {
      dynamic shippind_data = jsonDecode(shipping_address["shipping_address"]);
      _.countryController.text = shippind_data["region"] ?? "";
      _.streetController.text = (shippind_data["street"] ?? [""])[0];
      _.nameController.text = (shippind_data["firstname"] ?? "") + " " + (shippind_data["lastname"] ?? "");
      _.phoneController.text = shippind_data["telephone"] ?? "";
      _.phoneNumberCodeController.text = phoneNoCode["found"] ? phoneNoCode["phone_no_code"] : "+1";
      _.postCodeController.text = shippind_data["postcode"] ?? "";
      _.cityController.text = shippind_data["city"] ?? "";
      _.countryCodeController.text = shippind_data["country_id"] ?? "";
      _.regionCodeController.text = shippind_data["region_code"] ?? "";
      _.regionIdController.text = (shippind_data["region_id"] ?? "").toString();
      _.emailController.text = shippind_data["email"] ?? "";
      setState(() {
        _.isShiping.value = (shippind_data["sameAsBilling"] ?? "0").toString() == "1" ? true : false;
        billingInformation = (shippind_data["sameAsBilling"] ?? "0").toString() == "1" ? "On" : "Off";
      });
    }
    print("Biliing Data");
    print(billing_address);

    if (billing_address["found"]) {
      dynamic billing_data = jsonDecode(billing_address["billing_address"]);
      print((billing_data["firstname"] ?? "") + " " + (billing_data["lastname"] ?? ""));
      _.billingNameController.text = (billing_data["firstname"] ?? "") + " " + (billing_data["lastname"] ?? "");
      _.billingCountryController.text = billing_data["region"] ?? "";
      _.billingStreetController.text = (billing_data["street"] ?? [""])[0];
      _.billingPostZipController.text = billing_data["postcode"] ?? "";
      _.billingCityController.text = billing_data["city"] ?? "";
      _.billingPhoneController.text = billing_data["telephone"] ?? "";
      _.billingPhoneNumberCodeController.text =
          phoneNoCodeBilling["found"] ? phoneNoCodeBilling["phone_no_code_billing"] : "+1";
      _.billingCountryCodeController.text = billing_data["country_id"] ?? "";
      _.billingRegionCodeController.text = billing_data["region_code"] ?? "";
      _.billingIdodeController.text = (billing_data["region_id"] ?? "").toString();
    }
  }

  addLisnertoController() {
    _.billingNameController.addListener(rebuildOnChange);
    _.billingCountryController.addListener(rebuildOnChange);
    _.billingStreetController.addListener(rebuildOnChange);
    _.billingPostZipController.addListener(rebuildOnChange);
    _.billingCityController.addListener(rebuildOnChange);
    _.billingPhoneController.addListener(rebuildOnChange);
    _.billingPhoneNumberCodeController.addListener(rebuildOnChange);
    _.billingCountryCodeController.addListener(rebuildOnChange);
    _.billingRegionCodeController.addListener(rebuildOnChange);
    _.countryController.addListener(rebuildOnChange);
    _.streetController.addListener(rebuildOnChange);
    _.nameController.addListener(rebuildOnChange);
    _.phoneController.addListener(rebuildOnChange);
    _.phoneNumberCodeController.addListener(rebuildOnChange);
    _.postCodeController.addListener(rebuildOnChange);
    _.cityController.addListener(rebuildOnChange);
    _.countryCodeController.addListener(rebuildOnChange);
    _.regionCodeController.addListener(rebuildOnChange);
    _.billingIdodeController.addListener(rebuildOnChange);
    _.regionIdController.addListener(rebuildOnChange);
  }

  checkisEmpty() {
    if (_.countryController.value.text.isEmpty ||
        _.streetController.value.text.isEmpty ||
        _.nameController.value.text.isEmpty ||
        _.phoneController.value.text.isEmpty ||
        _.phoneNumberCodeController.value.text.isEmpty ||
        _.postCodeController.value.text.isEmpty ||
        _.cityController.value.text.isEmpty) {
      print("Here 1");
      return true;
    } else {
      if (!_.isShiping.value) {
        if (_.billingNameController.value.text.isEmpty ||
            _.billingCountryController.value.text.isEmpty ||
            _.billingStreetController.value.text.isEmpty ||
            _.billingPostZipController.value.text.isEmpty ||
            _.billingPhoneController.value.text.isEmpty ||
            _.billingPhoneNumberCodeController.value.text.isEmpty ||
            _.billingCountryCodeController.value.text.isEmpty) {
          print("Here 2");
          return true;
        } else {
          if (listAvailableRegionsBilling.isNotEmpty) {
            if (_.billingRegionCodeController.value.text.isEmpty) {
              print("Here 3");
              return true;
            }
          }
          print("Here 4");
          return false;
        }
      } else {
        if (listAvailableRegions.isNotEmpty) {
          if (_.regionCodeController.value.text.isEmpty) {
            print("Here 5");
            return true;
          }
        }
        print("Here 6");
        return false;
      }
    }
  }

  void rebuildOnChange() {
    setState(() {});
  }

  loadcontrollers() async {}
  Country? selectedCountry;
  AvailableRegions? selectedRegion;
  Country? selectedCountryBilling;
  AvailableRegions? selectedRegionBilling;
  List<Country> listCountries = [];
  List<AvailableRegions> listAvailableRegions = [];
  List<AvailableRegions> listAvailableRegionsBilling = [];
  bool flagLoadingCountries = true;
  loadCountries() async {
    try {
      List<Country> listCountriestemp = [];

      http.Response res = await sfAPIFetchCountryDetails();
      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        for (int i = 0; i < data.length; i++) {
          listCountriestemp.add(new Country.fromJson(data[i]));
        }
        Country? selectedCountryTemp;
        AvailableRegions? selectedRegionsTemp;
        List<AvailableRegions> listTemp = [];

        Country? selectedCountryTempbilling;
        AvailableRegions? selectedRegionsTempbilling;
        List<AvailableRegions> listTempbilling = [];
        if (_.billingCountryCodeController.text.isNotEmpty) {
          for (int i = 0; i < listCountriestemp.length; i++) {
            if (_.billingCountryCodeController.text == listCountriestemp[i].id) {
              selectedCountryTempbilling = listCountriestemp[i];
              listTempbilling = listCountriestemp[i].availableRegions ?? [];
              _.countryController.text = listCountriestemp[i].fullNameEnglish ?? "";
            }
          }
          for (int i = 0; i < listTempbilling.length; i++) {
            if (_.billingIdodeController.text == listTempbilling[i].id) {
              selectedRegionsTempbilling = listTempbilling[i];
            }
          }
        }
        if (_.countryCodeController.text.isNotEmpty) {
          for (int i = 0; i < listCountriestemp.length; i++) {
            if (_.countryCodeController.text == listCountriestemp[i].id) {
              selectedCountryTemp = listCountriestemp[i];
              listTemp = listCountriestemp[i].availableRegions ?? [];
              _.billingCountryController.text = listCountriestemp[i].fullNameEnglish ?? "";
            }
          }
          for (int i = 0; i < listTemp.length; i++) {
            if (_.regionIdController.text == listTemp[i].id) {
              selectedRegionsTemp = listTemp[i];
            }
          }
        }

        print("List of countries");
        print(listCountriestemp);
        print(selectedRegion);
        print(_.regionIdController.text);
        print(listTemp);

        setState(() {
          selectedCountry = selectedCountryTemp;
          selectedRegion = selectedRegionsTemp;
          selectedCountryBilling = selectedCountryTempbilling;
          selectedRegionBilling = selectedRegionsTempbilling;
          listAvailableRegions = listTemp;
          listAvailableRegionsBilling = listTempbilling;
          listCountries = listCountriestemp;
          flagLoadingCountries = false;
        });
      } else {
        setState(() {
          flagLoadingCountries = false;
        });
      }
    } catch (e) {
      setState(() {
        flagLoadingCountries = false;
      });
    }
  }

  setupdatafromPrevious() {}

  void autoFillIfAvailable() async {}

  bool showCard = false;
  bool storeCard = true;
  bool setDefault = true;
  String saveCardInformation = "on";
  String saveCreditInformation = "on";
  String billingInformation = "on";
  var height;
  var isLoggedIn;
  var cartId;
  bool isBillingName = false;
  bool isBillingCountry = false;
  bool isBillingStreet = false;
  bool isBillingPostCode = false;
  bool isBillingCity = false;
  bool isBillingPhone = false;
  bool isBillingRegion = false;

  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodeStreet = FocusNode();
  FocusNode focusNodeZip = FocusNode();
  FocusNode focusNodeCity = FocusNode();
  FocusNode focusNodeBName = FocusNode();
  FocusNode focusNodeBPhone = FocusNode();
  FocusNode focusNodeBEmail = FocusNode();
  FocusNode focusNodeBStreet = FocusNode();
  FocusNode focusNodeBZip = FocusNode();
  FocusNode focusNodeBSCity = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    // AccountProvider ap = Provider.of<AccountProvider>(context);
    isLoggedIn = Provider.of<CartProvider>(context).isLoggedIn;
    cartId = Provider.of<CartProvider>(context).cartDetails!['id'];
    final TryItOnProvider tiop=Get.find();
    return SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
        child: Column(
          children: [
            Container(
              height: size.height * 0.045,
              color: Colors.white,
              alignment: Alignment.centerLeft,
              child: coverWidgetWithPadding(
                  child: Text(
                'SHIPPING ADDRESS',
                style: TextStyle(fontSize: height * 0.014, fontWeight: FontWeight.bold),
              )),
            ),
            Divider(
              color: Color(0xffF4F2F0),
              thickness: 8,
            ),
            displayTextFieldContainer(
                title: 'NAME',
                controller: _.nameController,
                hint: "",
                onChanged: (value) {
                  if (!isBillingName) {
                    _.billingNameController.text = _.nameController.text;
                  }
                },
                focusNode: focusNodeName,
                onFieldSubmitted: (e) {
                  focusNodeEmail.requestFocus();
                }),
            displayColorDivider(),
            displayTextFieldContainer(
                title: 'Email',
                controller: _.emailController,
                hint: "",
                focusNode: focusNodeEmail,
                onFieldSubmitted: (e) {
                  focusNodePhone.requestFocus();
                }),
            displayColorDivider(),
            displayTextFieldPhoneContainer(
              title: 'PHONE',
              controller: _.phoneController,
              focusNode: focusNodePhone,
              onFieldSubmitted: (e) {
                focusNodeStreet.requestFocus();
              },
              prefix: CountryCodeDropDown(
                byDefaultSelection: _.phoneNumberCodeController.text.toString(),
                callback: (CountryCode code) {
                  _.phoneNumberCodeController.text = code.dialCode as String;
                  print(code);
                },
                init: (CountryCode? code) {
                  _.phoneNumberCodeController.text = code!.dialCode as String;
                },
              ),
              hint: '',
              onChange: (value) {
                if (!isBillingPhone) {
                  _.billingPhoneController.text = _.phoneController.text;
                }
              },
              textInputType: TextInputType.phone,
            ),
            displayColorDivider(),
            displayTextFieldContainer(
              title: 'STREET',
              controller: _.streetController,
              hint: "",
              focusNode: focusNodeStreet,
              onFieldSubmitted: (e) {
                focusNodeZip.requestFocus();
              },
              onChanged: (value) {
                if (!isBillingStreet) {
                  _.billingStreetController.text = _.streetController.text;
                }
              },
            ),
            Container(
              height: height * 0.006,
              color: Color(0xffF4F2F0),
            ),
            Container(
              color: Color(0xffF4F2F0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(right: 2, left: 20, top: 10),
                      color: Colors.white,
                      child: CustomFormField(
                        label: 'POST/ZIP CODE',
                        focusNode: focusNodeZip,
                        onFieldSubmitted: (e) {
                          focusNodeCity.requestFocus();
                        },
                        onChange: (value) {
                          if (!isBillingPostCode) {
                            _.billingPostZipController.text = _.postCodeController.text;
                          }
                        },
                        controller: _.postCodeController,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(right: 2, left: 20, top: 10),
                      margin: EdgeInsets.only(left: 4),
                      color: Colors.white,
                      child: CustomFormField(
                        label: 'CITY',
                        focusNode: focusNodeCity,
                        onFieldSubmitted: (e) {
                          focusNodeCity.unfocus();
                        },
                        onChange: (value) {
                          if (!isBillingCity) {
                            _.billingCityController.text = _.cityController.text;
                          }
                        },
                        controller: _.cityController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            displayColorDivider(),
            (flagLoadingCountries)
                ? FieldLoader()
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: CountryDropDown(listCountries, selectedItem: selectedCountry, onChanged: (country) {
                      _.countryCodeController.text = country!.twoLetterAbbreviation ?? "";
                      _.countryController.text = country.fullNameEnglish ?? "";
                      _.regionCodeController.text = "";
                      setState(() {
                        selectedCountry = country;
                        if (!isBillingRegion) {
                          _.billingCountryCodeController.text = country.twoLetterAbbreviation ?? "";
                          selectedCountryBilling = country;
                          _.billingCountryController.text = country.fullNameEnglish ?? "";
                          _.billingRegionCodeController.text = "";
                          _.billingIdodeController.text = "";

                          listAvailableRegionsBilling = country.availableRegions ?? [];
                          selectedRegionBilling = null;
                        }
                        selectedRegion = null;
                        listAvailableRegions = country.availableRegions ?? [];
                        _.regionCodeController.text = "";
                        _.regionIdController.text = "";
                      });
                    })),
            if (listAvailableRegions.isNotEmpty) displayColorDivider(),
            if (listAvailableRegions.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: AvailableRegionsDropDown(
                  listAvailableRegions,
                  selectedItem: selectedRegion,
                  onChanged: (ar) {
                    selectedRegion = ar;
                    _.regionCodeController.text = ar!.code ?? "";
                    _.regionIdController.text = ar.id ?? "";
                    if (!isBillingRegion || _.isShiping.value) {
                      _.billingRegionCodeController.text = ar.code ?? "";
                      _.billingIdodeController.text = ar.id ?? "";
                      setState(() {
                        selectedRegionBilling = ar;
                      });
                    }
                  },
                ),
              ),
            displayColorDivider(),
            Container(
              height: 90,
              child: coverWidgetWithPadding(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "BILLING ADDRESS",
                              style: TextStyle(fontSize: height * 0.014, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Same as shipping address",
                          style: TextStyle(fontSize: height * 0.013, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Spacer(),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                              value: _.isShiping.value,
                              activeColor: Colors.green,
                              trackColor: Colors.red,
                              thumbColor: Colors.white,
                              onChanged: (val) {
                                _.isShiping.value = val;
                                if (!_.isShiping.value) {
                                  billingInformation = "Off";
                                } else {
                                  _.billingNameController.text = _.nameController.value.text;
                                  _.billingCountryController.text = _.countryController.value.text;
                                  _.billingCountryCodeController.text = _.countryCodeController.value.text;
                                  _.billingStreetController.text = _.streetController.value.text;
                                  _.billingPostZipController.text = _.postCodeController.value.text;
                                  _.billingCityController.text = _.cityController.value.text;
                                  _.billingPhoneController.text = _.phoneController.value.text;
                                  selectedCountryBilling = selectedCountry;
                                  selectedRegionBilling = selectedRegion;
                                  billingInformation = "On";
                                }
                                setState(() {});
                              }),
                        ),
                        Text("$billingInformation"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            displayColorDivider(),
            _.isShiping.value
                ? Container()
                : Column(
                    children: [
                      displayTextFieldContainer(
                        title: 'NAME',
                        controller: _.billingNameController,
                        hint: "Enter Name",
                        focusNode: focusNodeBName,
                        onFieldSubmitted: (p0) {
                          focusNodeBPhone.requestFocus();
                        },
                        onChanged: (value) {
                          isBillingName = true;
                        },
                      ),
                      displayColorDivider(),
                      displayTextFieldPhoneContainer(
                          title: 'PHONE',
                          onChange: (value) {
                            isBillingPhone = true;
                          },
                          focusNode: focusNodeBPhone,
                          onFieldSubmitted: (p0) {
                            focusNodeBStreet.requestFocus();
                          },
                          controller: _.billingPhoneController,
                          prefix: CountryCodeDropDown(
                            byDefaultSelection: _.billingPhoneNumberCodeController.text.toString(),
                            callback: (CountryCode code) {
                              _.billingPhoneNumberCodeController.text = code.dialCode as String;
                              print(code);
                            },
                            init: (CountryCode? code) {
                              _.billingPhoneNumberCodeController.text = code!.dialCode as String;
                            },
                          ),
                          hint: '',
                          textInputType: TextInputType.phone),
                      displayColorDivider(),
                      displayTextFieldContainer(
                        title: 'STREET',
                        controller: _.billingStreetController,
                        focusNode: focusNodeBStreet,
                        onFieldSubmitted: (p0) {
                          focusNodeBZip.requestFocus();
                        },
                        hint: "",
                        onChanged: (value) {
                          isBillingStreet = true;
                        },
                      ),
                      Container(
                        height: height * 0.006,
                        color: Color(0xffF4F2F0),
                      ),
                      Container(
                        color: Color(0xffF4F2F0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(right: 2, left: 20, top: 10),
                                color: Colors.white,
                                child: CustomFormField(
                                  label: 'POST/ZIP CODE',
                                  focusNode: focusNodeBZip,
                                  onFieldSubmitted: (p0) {
                                    focusNodeBSCity.requestFocus();
                                  },
                                  controller: _.billingPostZipController,
                                  onChange: (value) {
                                    isBillingPostCode = true;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.only(right: 2, left: 20, top: 10),
                                margin: EdgeInsets.only(left: 4),
                                color: Colors.white,
                                child: CustomFormField(
                                  label: 'CITY',
                                  focusNode: focusNodeBSCity,
                                  onFieldSubmitted: (p0) {
                                    focusNodeBSCity.unfocus();
                                  },
                                  onChange: (value) {
                                    isBillingCity = true;
                                  },
                                  controller: _.billingCityController,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      displayColorDivider(),
                      (flagLoadingCountries)
                          ? FieldLoader()
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                              child: CountryDropDown(listCountries, selectedItem: selectedCountryBilling,
                                  onChanged: (country) {
                                _.billingCountryCodeController.text = country!.twoLetterAbbreviation ?? "";
                                _.billingCountryController.text = country.fullNameEnglish ?? "";
                                _.billingRegionCodeController.text = "";
                                _.billingIdodeController.text = "";

                                setState(() {
                                  isBillingCountry = true;
                                  selectedRegionBilling = null;
                                  listAvailableRegionsBilling = country.availableRegions ?? [];
                                });
                              })),
                      if (listAvailableRegionsBilling.isNotEmpty) displayColorDivider(),
                      if (listAvailableRegionsBilling.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: AvailableRegionsDropDown(
                            listAvailableRegionsBilling,
                            selectedItem: selectedRegionBilling,
                            onChanged: (ar) {
                              setState(() {
                                isBillingRegion = true;
                              });

                              _.billingRegionCodeController.text = ar!.code ?? "";
                              _.billingIdodeController.text = ar.id ?? "";
                            },
                          ),
                        ),

                      // Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      //   child: FutureBuilder(
                      //     future: sfAPIFetchCountryDetails(),
                      //     builder: (BuildContext context, snapshot) {
                      //       if (!snapshot.hasData) {
                      //         return Column(
                      //           children: [
                      //             CustomFormField(
                      //               label: 'COUNTRY',
                      //               controller: _.billingCountryController,
                      //               width: MediaQuery.of(context).size.width,
                      //             ),
                      //           ],
                      //         );
                      //       }
                      //       return CountryField(
                      //         onSelect: (country, region) async {
                      //           _.billingCountryCodeController.text = await country['two_letter_abbreviation'];
                      //           _.billingCountryController.text = country['full_name_english'];
                      //           if (region != null) {
                      //             _.billingRegionCodeController.text = region['code'];
                      //           } else {
                      //             _.billingRegionCodeController.text = '';
                      //           }
                      //         },
                      //         countryList: snapshot.data as List,
                      //       );
                      //     },
                      //   ),
                      // ),

                      Container(
                        height: height * 0.007,
                        color: Color(0xffF4F2F0),
                      ),
                    ],
                  ),
            Container(
              height: height * 0.007,
              color: Color(0xffF4F2F0),
            ),
            CustomWhiteCards(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              child: [
                CapsuleButtonCheckout(
                  height: 50,
                  backgroundColor: checkisEmpty() ? Colors.black38 : Colors.black,
                  borderColor: checkisEmpty() ? Colors.black38 : Colors.black,
                  onPress: () async {
                    tiop.isChangeButtonColor.value=true;
                    tiop.playSound();
                    Future.delayed(Duration(milliseconds: 10)).then((value)async
                    {
                      tiop.isChangeButtonColor.value=false;
                      tiop.sku.value="";
                      // try {
                      // showLoaderDialog(context);
                      if (!checkisEmpty()) {
                        if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(_.emailController.value.text.trim())) {
                          context.loaderOverlay.show();
                          Map<String, dynamic> addressInfo = {
                            "addressInformation": {
                              "shippingAddress": {
                                "region": '${_.countryController.value.text}',
                                "region_id": int.parse(
                                    _.regionIdController.value.text.isEmpty ? "0" : _.regionIdController.value.text),
                                "country_id": '${_.countryCodeController.value.text}',
                                "street": ['${_.streetController.value.text}'],
                                "company": "Revered-Tech",
                                "telephone": _.phoneController.text,
                                "postcode": '${_.postCodeController.value.text}',
                                "city": '${_.cityController.text}',
                                "firstname": '${_.nameController.text.split(' ')[0]}',
                                "lastname": _.nameController.text.split(' ').length > 1
                                    ? _.nameController.text.split(' ')[1]
                                    : " ",
                                "email": "${_.emailController.value.text.trim()}",
                                "prefix": "",
                                "region_code": '${_.regionCodeController.value.text}',
                                "sameAsBilling": (_.isShiping.value) ? 1 : 0
                              },
                              "billingAddress": {
                                "region": '${_.billingCountryController.value.text}',
                                "region_id": int.parse(_.billingIdodeController.value.text.isEmpty
                                    ? "0"
                                    : _.billingIdodeController.value.text),
                                "country_id": '${_.billingCountryCodeController.value.text}',
                                "street": ['${_.billingStreetController.value.text}'],
                                "company": "Revered-Tech",
                                "telephone": _.billingPhoneController.text,
                                "postcode": "${_.billingPostZipController.value.text}",
                                "city": _.billingCityController.text,
                                "firstname": _.billingNameController.text.split(' ')[0],
                                "lastname": _.billingNameController.text.split(' ').length > 1
                                    ? _.billingNameController.text.split(' ')[1]
                                    : " ",
                                "email": "${_.emailController.value.text.trim()}",
                                "prefix": "",
                                "region_code": '${_.billingRegionCodeController.value.text}',
                              },
                              "shipping_method_code": "flatrate",
                              "shipping_carrier_code": "flatrate"
                            }
                          };
                          Region r = Region(
                              region: _.countryController.value.text,
                              regionCode: '${_.regionCodeController.value.text}',
                              regionId: 0);
                          Region r1 = Region(
                              region: _.billingCountryController.value.text.trim().isEmpty
                                  ? _.countryController.value.text
                                  : _.billingCountryController.value.text,
                              regionCode:
                              '${_.billingCountryCodeController.value.text.trim().isEmpty ? _.regionCodeController.value.text : _.billingCountryCodeController.value.text}',
                              regionId: 0);
                          Addresses1 shipping = Addresses1(
                              city: _.cityController.text,
                              countryId: _.countryCodeController.value.text,
                              defaultBilling: true,
                              defaultShipping: true,
                              firstname: '${_.nameController.text.split(' ')[0]}',
                              lastname:
                              _.nameController.text.split(' ').length > 1 ? _.nameController.text.split(' ')[1] : " ",
                              postcode: _.postCodeController.value.text,
                              region: r,
                              street: ['${_.streetController.text}'],
                              telephone: _.phoneController.text);

                          Addresses1 biiling = Addresses1(
                              city: _.cityController.text,
                              countryId: _.countryCodeController.value.text,
                              defaultBilling: true,
                              defaultShipping: true,
                              firstname: '${_.nameController.text.split(' ')[0]}',
                              lastname:
                              _.nameController.text.split(' ').length > 1 ? _.nameController.text.split(' ')[1] : " ",
                              postcode: _.billingPostZipController.text.trim().isEmpty
                                  ? _.postCodeController.value.text
                                  : _.billingPostZipController.text,
                              region: r1,
                              street: [
                                '${_.billingStreetController.value.text.trim().isEmpty ? _.streetController.text : _.billingStreetController.value.text}'
                              ],
                              telephone: _.billingPhoneController.text.trim().isEmpty
                                  ? _.phoneController.text
                                  : _.billingPhoneController.text);
                          Customer1 c = Customer1(
                              firstname: '${_.nameController.text.split(' ')[0]}',
                              lastname:
                              _.nameController.text.split(' ').length > 1 ? _.nameController.text.split(' ')[1] : " ",
                              addresses1: [shipping, biiling],
                              email: "${_.emailController.value.text.trim()}",
                              websiteId: 1);

                          if (isLoggedIn) {
                            await sfAPIUpdateUserDetails(
                                await APITokens.customerSavedToken, NewAddressClass(customer1: c).toJson());
                    int id = Provider.of<AccountProvider>(context, listen: false).customerId;
                    await sfAPIGetBillingAddressFromCustomerID(customerId: id);
                    await sfAPIGetShippingAddressFromCustomerID(customerId: id);
                    }

                    print("ChartIdFor User" + cartId.toString());
                    // set shipping information, for guest: call API 159,  for customer call 146
                    sfStoreInSharedPrefData(
                    fieldName: 'shipping_address',
                    value: jsonEncode(addressInfo['addressInformation']['shippingAddress']),
                    type: PreferencesDataType.STRING);

                    sfStoreInSharedPrefData(
                    fieldName: 'phone_no_code',
                    value: _.phoneNumberCodeController.value.text,
                      type: PreferencesDataType.STRING);
                      sfStoreInSharedPrefData(
                      fieldName: 'phone_no_code_billing',
                      value: _.billingPhoneNumberCodeController.value.text,
                      type: PreferencesDataType.STRING);
                      sfStoreInSharedPrefData(
                      fieldName: 'billing_address',
                      value: jsonEncode(addressInfo['addressInformation']['billingAddress']),
                      type: PreferencesDataType.STRING);
                      await sfStoreAddressInformation(
                      addressInfo['addressInformation']['billingAddress']); // store at local storage
                      Provider.of<AccountProvider>(context, listen: false).shipAddress =
                      await sfAPIAddShippingAddress(addressInfo, isLoggedIn, cartId);

                    var bodyForEstimateCost;

                    if (isLoggedIn) {
                    bodyForEstimateCost = {
                    "address": {
                    "region": '${_.billingCountryController.value.text}',
                    "region_id": int.parse(_.billingIdodeController.value.text.isEmpty
                    ? "0"
                        : _.billingIdodeController.value.text),
                    "region_code": '${_.billingRegionCodeController.value.text}',
                    "country_id": '${_.billingCountryCodeController.value.text}',
                    "street": ['${_.billingStreetController.value.text}'],
                    "postcode": "${_.billingPostZipController.value.text}",
                    "city": _.billingCityController.text,
                    "firstname": _.billingNameController.text.split(' ')[0],
                    "lastname": _.billingNameController.text.split(' ').length > 1
                    ? _.billingNameController.text.split(' ')[1]
                        : " ",
                    "customer_id": Provider.of<AccountProvider>(context, listen: false).customerId,
                    "email": "${_.emailController.value.text.trim()}",
                    "telephone": _.billingPhoneController.text,
                    "same_as_billing": (_.isShiping.value) ? 1 : 0
                    }
                    };
                    } else {
                    bodyForEstimateCost = {
                    "address": {
                    "region": '${_.billingCountryController.value.text}',
                    "region_id": int.parse(_.billingIdodeController.value.text.isEmpty
                    ? "0"
                        : _.billingIdodeController.value.text),
                    "region_code": '${_.billingRegionCodeController.value.text}',
                    "country_id": '${_.billingCountryCodeController.value.text}',
                    "street": ['${_.billingStreetController.value.text}'],
                    "postcode": "${_.billingPostZipController.value.text}",
                    "city": _.billingCityController.text,
                    "firstname": _.billingNameController.text.split(' ')[0],
                    "lastname": _.billingNameController.text.split(' ').length > 1
                    ? _.billingNameController.text.split(' ')[1]
                        : " ",
                    "email": "${_.emailController.value.text.trim()}",
                    "telephone": _.billingPhoneController.text,
                    "same_as_billing": (_.isShiping.value) ? 1 : 0
                    }
                    };
                    }
                    //call for shipping estimated cost
                    try {
                    if (isLoggedIn) {
                    print("ESC == Call for Loggin");
                    String res = await sfAPIcartIDUser();
                    await checkoutController.sfAPIEstimateShippingCost(
                    bodyForEstimateCost, isLoggedIn, int.parse(res));
                    } else {
                    print("ESC == Call for Guest");

                    await checkoutController.sfAPIEstimateShippingCost(bodyForEstimateCost, isLoggedIn, cartId);
                    }
                    } catch (e) {}
                    /*if (isLoggedIn) {
                print("updates");
                await _.getUserProfile();
                if (await _.updateUserProfileAddress()) {
                  ap.getUserDetails(await APITokens.customerSavedToken);
                  _.getUserProfile();
                }
                }*/
                    print("Now Move to back");
                    print(widget.paycodeKey);
                    if (widget.paycodeKey.contains("CHANGE")) {
                    print(widget.paycodeKey);
                    context.loaderOverlay.hide();
                    Navigator.pop(context);
                    } else if (widget.paycodeKey.contains("LOGINGUEST")) {
                    context.loaderOverlay.hide();
                    Get.to(CheckoutScreen());
                    } else {
                    context.loaderOverlay.hide();
                    Navigator.pop(context);
                    }
                    } else {
                    context.loaderOverlay.hide();
                    Get.showSnackbar(GetSnackBar(
                    message: 'Please enter a valid email address',
                    title: "",
                    dismissDirection: DismissDirection.down,
                    backgroundColor: Colors.black,
                    duration: Duration(seconds: 2),
                    ));
                    }
                      } else {
                    context.loaderOverlay.hide();
                    Get.showSnackbar(GetSnackBar(
                    message: 'Please fill out all fields',
                    title: "",
                    dismissDirection: DismissDirection.down,
                    backgroundColor: Colors.black,
                    duration: Duration(seconds: 2),
                    ));
                    }
                      // } catch (e) {
                      //   print(e.toString());

                      //   context.loaderOverlay.hide();
                      // }
                    });

                  },
                  child: Text(
                    'CONFIRM',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.white,
                          fontSize: height * 0.02,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'By continuing you accept Sofiqes ',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.black,
                            fontSize: 10,
                            letterSpacing: 0.4,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchURL();
                      },
                      child: Text(
                        'terms and condition',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontSize: 10,
                              letterSpacing: 0.4,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool isUpdate = true;
  final String salesPolicyUrl = 'https://sofiqe.com/terms-and-conditions';

  void _launchURL() async {
    await launchUrl(Uri.parse(salesPolicyUrl));
  }

  Widget coverWidgetWithPadding({Widget? child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
  }

  Widget displayGenderContainer({required String image, required String title}) {
    return InkWell(
      onTap: () {
        _.selectedGender = title;
      },
      child: Container(
        height: 65,
        width: 58,
        decoration: BoxDecoration(
          border: (title == _.selectedGender) ? Border(bottom: BorderSide(color: Color(0xffF2CA8A))) : null,
          color: (title == _.selectedGender) ? Color(0xffF4F2F0) : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/$image',
              height: 28,
              width: 15,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 8, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  bool checkEmpty() {
    if (_.isShiping.value) {
      if (_.nameController.value.text.isEmpty ||
          _.countryController.value.text.isEmpty ||
          _.streetController.value.text.isEmpty ||
          _.postCodeController.value.text.isEmpty ||
          _.cityController.value.text.isEmpty ||
          _.emailController.value.text.isEmpty ||
          _.phoneController.value.text.isEmpty) {
        return true;
      } else {
        _.billingNameController.text = _.nameController.value.text;
        _.billingCountryController.text = _.countryController.value.text;
        _.billingCountryCodeController.text = _.countryCodeController.value.text;
        _.billingStreetController.text = _.streetController.value.text;
        _.billingPostZipController.text = _.postCodeController.value.text;
        _.billingCityController.text = _.cityController.value.text;
        _.billingPhoneController.text = _.phoneController.value.text;
        return false;
      }
    } else {
      return false;
    }
  }

  displayTextFieldContainer(
      {String? title,
      TextEditingController? controller,
      Color? backgroundColor,
      String? prefix,
      TextInputType? textInputType,
      ValueChanged<String>? onChanged,
      void Function(String)? onFieldSubmitted,
      FocusNode? focusNode,
      String? hint}) {
    return Container(
      height: 68,
      color: backgroundColor,
      padding: EdgeInsets.only(top: 5),
      child: coverWidgetWithPadding(
          child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    title!,
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                  Text(
                    ' *',
                    style: TextStyle(fontSize: 11, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
          TextFormField(
            enableInteractiveSelection: true,
            validator: (str) {
              if (str == '' || str == null) {
                isUpdate = false;
              }
              return null;
            },
            keyboardType: textInputType ?? TextInputType.text,
            controller: controller,
            onChanged: onChanged,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(hintText: hint, prefixText: prefix, border: InputBorder.none),
          ),
        ],
      )),
    );
  }

  displayTextFieldPhoneContainer(
      {String? title,
      TextEditingController? controller,
      Color? backgroundColor,
      Widget? prefix,
      Function? onChange,
      TextInputType? textInputType,
      void Function(String)? onFieldSubmitted,
      FocusNode? focusNode,
      String? hint}) {
    return Container(
      height: 68,
      color: backgroundColor,
      padding: EdgeInsets.only(top: 5),
      child: coverWidgetWithPadding(
          child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    title!,
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                  Text(
                    ' *',
                    style: TextStyle(fontSize: 11, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            validator: (str) {
              if (str == '' || str == null) {
                isUpdate = false;
              }
              return null;
            },
            onChanged: onChange == null ? (val) {} : onChange as Function(String),
            keyboardType: textInputType ?? TextInputType.text,
            controller: controller,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(hintText: hint, prefixIcon: prefix, border: InputBorder.none),
          ),
        ],
      )),
    );
  }

  displayColorDivider() {
    return Divider(
      color: Color(0xffF4F2F0),
      thickness: 5,
    );
  }

  Future<String?> orderPurchase(BuildContext context, paymentCode) async {
    try {
      print("ADDRESSES TO PaymentDetailsScreenPage");
      orderId = await sfApiPlaceOrder(Provider.of<CartProvider>(context, listen: false).isLoggedIn, cartId,
          widget.paycodeKey, checkoutController.getAdditionalDataforClearPay());

      print("ORDER ID  =$orderId");
      return orderId;
      /*if (orderId == null) {
        orderId = '1';
      }*/
      // await Provider.of<CartProvider>(context, listen: false).deleteCart();
      // Provider.of<CartProvider>(context, listen: false).initializeCart();
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (BuildContext _) {
      //     return GiftCardScreen(
      //       orderId: orderId,
      //     );
      //   }),
      // );
    } catch (e) {
      print('Error setting payment information _NextButton: $e');
      return null;
    }
  }
}

showLoaderDialog(BuildContext context) {
  final alert = SpinKitDoubleBounce(
    color: Colors.white,
    // color: Color(0xffF2CA8A),
    size: 50.0,
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
