// ignore_for_file: deprecated_member_use, unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/msProfileController.dart';
import 'package:sofiqe/helper/CardExpirationFormatter.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/screens/Ms1/editProfileAppbar.dart';

import '../../model/AddressClass.dart';
import '../../utils/api/shipping_address_api.dart';
import '../../utils/api/user_account_api.dart';
import '../../utils/constants/api_tokens.dart';
import '../../widgets/account/Models/country.dart';
import '../../widgets/account/country_dropdown.dart';
import '../../widgets/account/phone_number_field.dart';
import '../../widgets/account/region_dropdown.dart';
import '../../widgets/catalog/payment/delivery_details_page.dart';
import '../../widgets/field_loader.dart';

class SofiqueEditProfile extends StatefulWidget {
  const SofiqueEditProfile({Key? key}) : super(key: key);

  @override
  _SofiqueEditProfileState createState() => _SofiqueEditProfileState();
}

class _SofiqueEditProfileState extends State<SofiqueEditProfile> {
  MsProfileController _ = Get.find<MsProfileController>();

  // String selectedGender = "";
  // bool sameAsShippingAddress = false;
  final _formKey = GlobalKey<FormState>();
  bool isUpdate = true;

  @override
  initState() {
    super.initState();
    int id = Provider.of<AccountProvider>(context, listen: false).customerId;
    loadCountries();
    sfAPIGetBillingAddressFromCustomerID(customerId: id);
    sfAPIGetShippingAddressFromCustomerID(customerId: id);

    //  selectedGender = _.getUserProfile();
    // print(selectedGender);
    // ;
  }

  Country? selectedCountry;
  AvailableRegions? selectedRegion;
  Country? selectedCountryBilling;
  AvailableRegions? selectedRegionBilling;
  List<Country> listCountries = [];
  List<AvailableRegions> listAvailableRegions = [];
  List<AvailableRegions> listAvailableRegionsBilling = [];
  bool flagLoadingCountries = true;
  loadCountries() async {
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
  }

  FocusNode focusNodeFirstName = FocusNode();
  FocusNode focusNodeLastName = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodeStreet = FocusNode();
  FocusNode focusNodeCity = FocusNode();
  FocusNode focusNodeZipCode = FocusNode();
  FocusNode focusNodeCountry = FocusNode();

  bool isUpdating = false;
  bool isBillingRegion = false;
  bool isBillingCountry = false;
  @override
  Widget build(BuildContext context) {
    AccountProvider ap = Provider.of<AccountProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          child: ModalProgressHUD(
            inAsyncCall: isUpdating,
            progressIndicator: SpinKitDoubleBounce(
              color: Colors.black,
              // color: Color(0xffF2CA8A),
              size: 50.0,
            ),
            child: Column(
              children: [
                EditProfileAppbar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'THANKS FOR BEING A SOFIQE',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Here you can amend your profile etc.',
                            style: TextStyle(fontSize: 10, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          coverWidgetWithPadding(
                            child: Row(
                              children: [
                                Text(
                                  'I’M A',
                                  style: TextStyle(fontSize: 9, color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          coverWidgetWithPadding(
                            child: Container(
                              height: 85,
                              width: Get.width,
                              // color: Colors.yellow,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  displayGenderContainer(image: "woman.png", title: 'FEMALE'),
                                  displayGenderContainer(image: "male.png", title: 'MALE'),
                                  displayGenderContainer(image: "heart-3.png", title: 'GENDERLESS'),
                                  displayGenderContainer(image: "heart-2.png", title: 'LBGT'),
                                ],
                              ),
                            ),
                          ),
                          displayColorDivider(),
                          displayTextFieldContainer(
                              title: 'MY FIRST NAME IS',
                              controller: _.firstNameController,
                              focusNode: focusNodeFirstName,
                              onFieldSubmitted: ((p0) {
                                focusNodeLastName.requestFocus();
                              })),
                          Container(
                            height: 5,
                            color: Color(0xffF4F2F0),
                          ),
                          displayTextFieldContainer(
                              title: 'MY LAST NAME IS',
                              controller: _.lastNameController,
                              focusNode: focusNodeLastName,
                              onFieldSubmitted: ((p0) {
                                focusNodeEmail.requestFocus();
                              })
                              //  backgroundColor: Color(0xffF4F2F0)
                              ),
                          Container(
                            height: 5,
                            color: Color(0xffF4F2F0),
                          ),
                          displayTextFieldContainer(
                              title: 'MY EMAIL IS',
                              controller: _.emailController,
                              hint: "Email",
                              focusNode: focusNodeEmail,
                              onFieldSubmitted: ((p0) {
                                focusNodePhone.requestFocus();
                              })),
                          displayTextFieldPhoneContainer(
                              title: 'PHONE',
                              controller: _.phoneController,
                              prefix: /*CountryCodePicker(
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
                              );*/
                                  CountryCodeDropDown(
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
                              textInputType: TextInputType.phone),
                          Container(
                            height: 25,
                            color: Color(0xffF4F2F0),
                            alignment: Alignment.centerLeft,
                            child: coverWidgetWithPadding(
                                child: Text(
                              'SHIPPING ADDRESS',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                            )),
                          ),
                          // displayTextFieldContainer(
                          //     title: 'COUNTRY',
                          //     controller: _.countryController,
                          //     hint: "Denmark"),
                          // displayColorDivider(),

                          displayTextFieldContainer(
                              title: 'STREET',
                              controller: _.streetController,
                              hint: "",
                              focusNode: focusNodeStreet,
                              onFieldSubmitted: ((p0) {
                                focusNodeCity.requestFocus();
                              })
                              // backgroundColor: Color(0xffF4F2F0),
                              ),
                          displayColorDivider(),
                          displayTextFieldContainer(
                              title: 'CITY',
                              controller: _.cityController,
                              hint: "",
                              focusNode: focusNodeCity,
                              onFieldSubmitted: ((p0) {
                                focusNodeCountry.requestFocus();
                              })
                              // backgroundColor: Color(0xffF4F2F0),
                              ),
                          displayColorDivider(),
                          displayTextFieldContainer(
                              title: 'POST/ZIP CODE',
                              textInputType: TextInputType.phone,
                              controller: _.postCodeController,
                              focusNode: focusNodeZipCode,
                              onFieldSubmitted: ((p0) {
                                focusNodeLastName.unfocus();
                              })),
                          Container(
                            height: 5,
                            color: Color(0xffF4F2F0),
                          ),
                          (flagLoadingCountries)
                              ? FieldLoader()
                              : Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                                  child: CountryDropDown(listCountries, selectedItem: selectedCountry,
                                      onChanged: (country) {
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

                          // displayTextFieldContainer(
                          //     title: 'COUNTRY', controller: _.countryController, hint: "United Kingdom"),
                          // PhoneNumberField(
                          //   onTap: () {
                          //     setState(() {});
                          //   },
                          //   isBeingEdited: false,
                          //   phoneNumberController:_.phoneController,
                          //   phoneNumberCodeController: _.phoneNumberCodeController,
                          //   // phoneNumberCodeController: widget.phoneNumberCodeController,
                          // ),

                          displayColorDivider(),
                          Container(
                            height: 90,
                            child: coverWidgetWithPadding(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SizedBox(height: 20,),

                                  Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        color: Color(0xffF4F2F0),
                                        alignment: Alignment.centerLeft,
                                        child: coverWidgetWithPadding(
                                            child: Text(
                                          'BILLING ADDRESS',
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "BILLING ADDRESS",
                                      //       style: TextStyle(
                                      //           fontSize: 11,
                                      //           color: Colors.black),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Same as shipping address",
                                        style: TextStyle(fontSize: 11, color: Colors.black),
                                      ),
                                      Transform.scale(
                                        scale: 0.8,
                                        child: CupertinoSwitch(
                                            value: _.isShiping.value,
                                            activeColor: Colors.green,
                                            trackColor: Colors.red,
                                            thumbColor: Colors.white,
                                            onChanged: (val) {
                                              _.isShiping.value = val;
                                              setState(() {});
                                            }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          _.isShiping.value
                              ? Container()
                              : Column(
                                  children: [
                                    // Container(
                                    //   height: 25,
                                    //   color: Color(0xffF4F2F0),
                                    //   alignment: Alignment.centerLeft,
                                    //   child: coverWidgetWithPadding(
                                    //       child: Text(
                                    //     'SHIPPING ADDRESS',
                                    //     style: TextStyle(
                                    //         fontSize: 11, fontWeight: FontWeight.bold),
                                    //   )),
                                    // ),

                                    displayTextFieldContainer(
                                      title: 'STREET',
                                      controller: _.billingStreetController,
                                      hint: "",
                                      // backgroundColor: Color(0xffF4F2F0),
                                    ),
                                    displayColorDivider(),
                                    displayTextFieldContainer(
                                      title: 'CITY',
                                      controller: _.billingCityController,
                                      hint: "",
                                      // backgroundColor: Color(0xffF4F2F0),
                                    ),
                                    displayColorDivider(),

                                    displayTextFieldContainer(
                                        title: 'POST/ZIP CODE',
                                        textInputType: TextInputType.phone,
                                        controller: _.billingPostZipController),
                                    displayColorDivider(),
                                    (flagLoadingCountries)
                                        ? FieldLoader()
                                        : Padding(
                                            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                                            child: CountryDropDown(listCountries, selectedItem: selectedCountryBilling,
                                                onChanged: (country) {
                                              _.billingCountryCodeController.text =
                                                  country!.twoLetterAbbreviation ?? "";
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

                                    displayColorDivider(),

                                    // displayTextFieldContainer(
                                    //   title: 'COUNTRY',
                                    //   controller: _.billingCountryController,
                                    //   hint: "",
                                    //   // backgroundColor: Color(0xffF4F2F0),
                                    // ),
                                    displayColorDivider(),
                                  ],
                                ),

                          // displayColorDivider(),
                          Container(
                            height: 220,
                            color: Color(0xffF4F2F0),
                            child: coverWidgetWithPadding(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      Text(
                                        "CARD DETAILS",
                                        style: TextStyle(fontSize: 11, color: Colors.black),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(fontSize: 11, color: Colors.red),
                                      ),
                                    ],
                                  ),

                                  TextFormField(
                                    controller: _.cardNumberController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none,
                                        hintText: 'CARD NUMBER',
                                        suffix: Icon(Icons.credit_card)),
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Container(
                                          // width: 150,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            maxLength: 5,
                                            inputFormatters: [
                                              CardExpirationFormatter(),
                                            ],
                                            controller: _.monthCardController,
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: InputBorder.none,
                                              counter: SizedBox(
                                                width: 0,
                                                height: 0,
                                              ),
                                              hintText: 'MONTH / YEAR',
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        // width: 150,
                                        child: TextFormField(
                                          maxLength: 4,
                                          controller: _.cvcController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            counter: SizedBox(
                                              width: 0,
                                              height: 0,
                                            ),
                                            border: InputBorder.none,
                                            hintText: 'CVC',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       height: 20,
                                  //       width: 20,
                                  //       decoration: BoxDecoration(shape: BoxShape.circle),
                                  //       child: Icon(
                                  //         Icons.camera_alt_outlined,
                                  //         size: 18,
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     Text(
                                  //       "SCAN YOUR CARD",
                                  //       style: TextStyle(fontSize: 9, color: Colors.black),
                                  //     ),
                                  //     Spacer(),
                                  //     Container(
                                  //         height: 20,
                                  //         width: 20,
                                  //         alignment: Alignment.center,
                                  //         decoration: BoxDecoration(
                                  //             shape: BoxShape.circle, color: Colors.black),
                                  //         child: Text(
                                  //           "?",
                                  //           style: TextStyle(color: Colors.white),
                                  //         ) //Icon(,size: 18,),
                                  //         ),
                                  //     SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     Text(
                                  //       "SCAN YOUR CARD",
                                  //       style: TextStyle(fontSize: 9, color: Colors.black),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {});
                      //need to use form validator
                      final isValid = _formKey.currentState?.validate();
                      if (!checkEmpty()) {
                        print("true");
                        //
                        if (!_.isShiping.value && _.billingStreetController.text.isEmpty) {
                          Get.showSnackbar(GetSnackBar(
                            message: 'Please add billing address as well or swtich the toggle',
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          setState(() {
                            isUpdating = true;
                          });
                          if (await _.updateUserProfile()) {
                            print("Success Login");
                            ap.getUserDetails(await APITokens.customerSavedToken);
                            _.getUserProfile();
                            setState(() {
                              isUpdating = false;
                            });
                          } else {
                            setState(() {
                              isUpdating = false;
                            });
                          }
                        }

                        //
                        // print(
                        //     'billing street is ${_.billingStreetController.text.length}');
                        // print(
                        //     'billing street is not empty ${_.billingStreetController.text.isEmpty}');

                      } else {
                        Get.showSnackbar(GetSnackBar(
                          message: 'Please fill out all fields',
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                    child: InkWell(
                      onTap: () async {
                        showLoaderDialog(context);

                        Region r = Region(
                            region: _.countryController.value.text,
                            regionCode: '${_.regionCodeController.value.text}',
                            regionId: int.parse(
                                _.regionIdController.value.text.isEmpty ? "0" : _.regionIdController.value.text));
                        Region r1 = Region(
                            region: _.billingCountryController.value.text.trim().isEmpty
                                ? _.countryController.value.text
                                : _.billingCountryController.value.text,
                            regionCode:
                                '${_.billingCountryCodeController.value.text.trim().isEmpty ? _.regionCodeController.value.text : _.billingCountryCodeController.value.text}',
                            regionId: int.parse(_.billingIdodeController.value.text.isEmpty
                                ? "0"
                                : _.billingIdodeController.value.text));
                        Addresses1 shipping = Addresses1(
                            city: _.cityController.text,
                            countryId: _.countryCodeController.value.text,
                            defaultBilling: true,
                            defaultShipping: true,
                            firstname: '${_.firstNameController.text}',
                            lastname: _.lastNameController.text,
                            postcode: _.postCodeController.value.text,
                            region: r,
                            street: ['${_.streetController.text}'],
                            telephone: _.phoneController.text);

                        Addresses1 biiling = Addresses1(
                            city: _.cityController.text,
                            countryId: _.countryCodeController.value.text,
                            defaultBilling: true,
                            defaultShipping: true,
                            firstname: '${_.firstNameController.text}',
                            lastname: '${_.lastNameController.text}',
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
                            firstname: '${_.firstNameController.text}',
                            lastname: '${_.lastNameController.text}',
                            addresses1: [shipping, biiling],
                            email: "${_.emailController.value.text}",
                            websiteId: 1);
                        print(NewAddressClass(customer1: c).toJson());
                        await sfAPIUpdateUserDetails(
                            await APITokens.customerSavedToken, NewAddressClass(customer1: c).toJson());
                        int id = Provider.of<AccountProvider>(context, listen: false).customerId;
                        await sfAPIGetBillingAddressFromCustomerID(customerId: id);
                        await sfAPIGetShippingAddressFromCustomerID(customerId: id);
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Container(
                        height: 45,
                        width: Get.width,
                        decoration: BoxDecoration(color: Color(0xffF2CA8A), borderRadius: BorderRadius.circular(50)),
                        alignment: Alignment.center,
                        child: Text(
                          "SAVE",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
        setState(() {});
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
    if (_.firstNameController.value.text.isEmpty ||
        _.lastNameController.value.text.isEmpty ||
        _.emailController.value.text.isEmpty ||
        _.countryController.value.text.isEmpty ||
        _.streetController.value.text.isEmpty ||
        _.phoneController.value.text.isEmpty ||
        _.selectedGender == "") {
      return true;
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
            validator: (str) {
              if (str == '' || str == null) {
                isUpdate = false;
              }
              return null;
            },
            keyboardType: textInputType ?? TextInputType.text,
            controller: controller,
            onFieldSubmitted: onFieldSubmitted,
            focusNode: focusNode,
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
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: textInputType ?? TextInputType.text,
            controller: controller,
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
}
