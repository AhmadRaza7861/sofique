// // ignore_for_file: deprecated_member_use
//
// import 'dart:convert';
// import 'package:country_code_picker/country_code.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// // 3rd party packges
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:sofiqe/provider/cart_provider.dart';
// import 'package:sofiqe/screens/order_confirmation_screen.dart';
// // Utils
// import 'package:sofiqe/utils/api/shipping_address_api.dart';
// import 'package:sofiqe/utils/states/local_storage.dart';
// import 'package:sofiqe/utils/states/user_account_data.dart';
// import 'package:sofiqe/widgets/account/phone_number_field.dart';
//
// // Custom packages
// import 'package:sofiqe/widgets/capsule_button.dart';
// import 'package:sofiqe/widgets/catalog/checkout/giftcard_or_promocode.dart';
// import 'package:sofiqe/widgets/catalog/delivery/country_field.dart';
// import 'package:sofiqe/widgets/custom_form_field.dart';
// import 'package:sofiqe/screens/delivery_details_screen.dart';
//
// import '../../../controller/controllers.dart';
// import '../checkout/giftcard_page.dart';
//
// class DeliveryDetailsPage extends StatelessWidget {
//   String paymentCode;
//   DeliveryDetailsPage(this.paymentCode, {Key? key}) : super(key: key) {
//     _checkDefaults();
//   }
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _streetController = TextEditingController();
//   final TextEditingController _zipController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _phoneCodeController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _countryNameController = TextEditingController();
//   final TextEditingController _countryCodeController = TextEditingController();
//   final TextEditingController _regionCodeController = TextEditingController();
//
//   bool isLoggedIn = false;
//   var cartId;
//
//   void _checkDefaults() async {
//
//     // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     // print(position);
//     bool success = await _tryAccount();
//     if (!success) {
//
//       _tryLocal();
//     }
//   }
//
//   Future<void> _tryLocal() async {
//     Map<String, dynamic> resultCountryCode = await sfQueryForSharedPrefData(
//         fieldName: 'country', type: PreferencesDataType.STRING);
//     Map<String, dynamic> resultRegionCode = await sfQueryForSharedPrefData(
//         fieldName: 'region', type: PreferencesDataType.STRING);
//     Map<String, dynamic> resultStreet = await sfQueryForSharedPrefData(
//         fieldName: 'street', type: PreferencesDataType.STRING);
//     Map<String, dynamic> resultPostcode = await sfQueryForSharedPrefData(
//         fieldName: 'postcode', type: PreferencesDataType.STRING);
//     Map<String, dynamic> resultCity = await sfQueryForSharedPrefData(
//         fieldName: 'city', type: PreferencesDataType.STRING);
//     Map<String, dynamic> resultName = await sfQueryForSharedPrefData(
//         fieldName: 'name', type: PreferencesDataType.STRING);
//     Map<String, dynamic> resultPhoneNumber = await sfQueryForSharedPrefData(
//         fieldName: 'phone-number', type: PreferencesDataType.STRING);
//     Map<String, dynamic> resultEmail = await sfQueryForSharedPrefData(
//         fieldName: 'email', type: PreferencesDataType.STRING);
//
//     if (resultCountryCode['found']) {
//       _countryCodeController.text = resultCountryCode['country'];
//     }
//     if (resultRegionCode['found']) {
//       _regionCodeController.text = resultRegionCode['region'];
//     }
//     if (resultStreet['found']) {
//       _streetController.text = json.decode(resultStreet['street'])[0];
//     }
//     if (resultPostcode['found']) {
//       _zipController.text = resultPostcode['postcode'];
//     }
//     if (resultCity['found']) {
//       _cityController.text = resultCity['city'];
//     }
//     if (resultName['found']) {
//       _nameController.text = resultName['name'];
//     }
//     if (resultPhoneNumber['found']) {
//       _phoneController.text = resultPhoneNumber['phone-number'];
//     }
//     if (resultEmail['found']) {
//       _emailController.text = resultEmail['email'];
//     }
//   }
//
//   Future<bool> _tryAccount() async {
//
//     if(isLoggedIn)
//       {
//         Map<String, dynamic> result = await sfQueryForSharedPrefData(
//             fieldName: 'customer-id', type: PreferencesDataType.INT);
//
//         if (result['found']) {
//           http.Response responseString = await sfAPIGetShippingAddressFromCustomerID(customerId: result['customer-id']);
//           var responseObject = json.decode(responseString.body);
//           print(responseObject);
//           if (responseObject.runtimeType == (Map<String, dynamic>()).runtimeType) {
//             // Name
//             _nameController.text =
//             '${responseObject['firstname']} ${responseObject['lastname']}';
//             // Street
//             String street = '';
//             responseObject['street'].forEach((streetInput) {
//               street = '$street $streetInput,';
//             });
//             street = street.replaceAll(RegExp(r',$'), '');
//             _streetController.text = '$street';
//             // Zip
//             _zipController.text = responseObject['postcode'];
//             // City
//             _cityController.text = responseObject['city'];
//             // Email
//             Map<String, dynamic> emailResult = await sfQueryForSharedPrefData(
//                 fieldName: 'email', type: PreferencesDataType.STRING);
//             if (emailResult['found']) {
//               _emailController.text = emailResult['email'];
//             }
//             // Phone number
//             Map<String, dynamic> phoneNumberResult = await sfQueryForSharedPrefData(
//                 fieldName: 'phone-number', type: PreferencesDataType.STRING);
//             if (emailResult['found']) {
//               _phoneController.text = phoneNumberResult['phone-number'];
//             }
//           }
//         }
//         return result['found'];
//       }
//     else
//       {
//         Map<String, dynamic> result = await sfQueryForSharedPrefData(
//             fieldName: 'customer-id', type: PreferencesDataType.INT);
//
//         if (result['found']) {
//           http.Response responseString = await sfAPIGetShippingAddressFromCustomerID(customerId: result['customer-id']);
//           var responseObject = json.decode(responseString.body);
//           print(responseObject);
//           if (responseObject.runtimeType == (Map<String, dynamic>()).runtimeType) {
//             // Name
//             _nameController.text =
//             '${responseObject['firstname']} ${responseObject['lastname']}';
//             // Street
//             String street = '';
//             responseObject['street'].forEach((streetInput) {
//               street = '$street $streetInput,';
//             });
//             street = street.replaceAll(RegExp(r',$'), '');
//             // _streetController.text = '$street';
//             _streetController.text = '';
//             // Zip
//             _zipController.text = " ";
//             // _zipController.text = responseObject['postcode'];
//             // City
//             _cityController.text = " ";
//             // _cityController.text = responseObject['city'];
//             // Email
//             Map<String, dynamic> emailResult = await sfQueryForSharedPrefData(
//                 fieldName: 'email', type: PreferencesDataType.STRING);
//             if (emailResult['found']) {
//               _emailController.text = emailResult['email'];
//             }
//             // Phone number
//             Map<String, dynamic> phoneNumberResult = await sfQueryForSharedPrefData(
//                 fieldName: 'phone-number', type: PreferencesDataType.STRING);
//             if (emailResult['found']) {
//               _phoneController.text = "";
//               // _phoneController.text = phoneNumberResult['phone-number'];
//             }
//           }
//         }
//         return result['found'];
//       }
//     //  _nameController =
//     //  _streetController =
//     //  _zipController =
//     //  _cityController =
//     //  _phoneController =
//     //  _emailController =
//
//
//   }
//
//   Future<void> _storeShippingAddress() async {
//     _nameController.text = _nameController.value.text.trim();
//     print('${_nameController.value.text.split(' ').length}');
//     if (_nameController.value.text.split(' ').length == 1) {
//       print('throwing error');
//       throw 'Enter last name';
//     }
//     if (_streetController.value.text.isEmpty) {
//       throw 'Enter street information';
//     }
//     if (_cityController.value.text.isEmpty) {
//       throw 'Enter city information';
//     }
//     if (_zipController.value.text.isEmpty) {
//       throw 'Enter zip information';
//     }
//     if (_phoneController.value.text.isEmpty) {
//       throw 'Enter phone information';
//     }
//     if (_emailController.value.text.isEmpty) {
//       throw 'Enter email';
//     }
//     if (_countryCodeController.value.text.isEmpty) {
//       throw 'Enter Country';
//     }
//
//     Map<String, dynamic> address = {
//       'country': '${_countryCodeController.value.text}',
//       'region': '${_regionCodeController.value.text}',
//       'street': ['${_streetController.value.text}'],
//       'postcode': '${_zipController.value.text}',
//       'city': '${_cityController.value.text}',
//       'firstname': '${_nameController.value.text.split(' ')[0]}',
//       'lastname':
//           '${_nameController.text.split(' ').length > 1 ? _nameController.text.split(' ')[1] : " "}',
//       'email': '${_emailController.value.text}',
//       'phone_number': '${_phoneController.value.text}',
//       'country_name': '${_countryNameController.value.text}',
//     };
//
//     Map<String, dynamic> addressInfo = {
//       "addressInformation": {
//         "shippingAddress": {
//           "region": '${_regionCodeController.value.text}',
//           "region_id": 0,
//           "country_id": '${_countryCodeController.value.text}',
//           "street": ['${_streetController.value.text}'],
//           "company": "Revered-Tech",
//           "telephone": _phoneController.text,
//           "postcode": "${_zipController.value.text}",
//           "city": _cityController.text,
//           "firstname": _nameController.text.split(' ')[0],
//           "lastname": _nameController.text.split(' ').length > 1
//               ? _nameController.text.split(' ')[1]
//               : " ",
//           "email": _emailController.text,
//           "prefix": "",
//           "region_code": '${_regionCodeController.value.text}',
//           "sameAsBilling": 1
//         },
//         "billingAddress": {
//           "region": '${_regionCodeController.value.text}',
//           "region_id": 0,
//           "country_id": '${_countryCodeController.value.text}',
//           "street": ['${_streetController.value.text}'],
//           "company": "Revered-Tech",
//           "telephone": _phoneController.text,
//           "postcode": "${_zipController.value.text}",
//           "city": _cityController.text,
//           "firstname": _nameController.text.split(' ')[0],
//           "lastname": _nameController.text.split(' ').length > 1
//               ? _nameController.text.split(' ')[1]
//               : " ",
//           "email": _emailController.text,
//           "prefix": "",
//           "region_code": '${_regionCodeController.value.text}'
//         },
//         "shipping_method_code": "flatrate",
//         "shipping_carrier_code": "flatrate"
//       }
//     };
//
//     try {
//       await sfStoreAddressInformation(address);
//       await sfAPIAddShippingAddressForGuest(addressInfo, isLoggedIn, cartId);
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     isLoggedIn = Provider.of<CartProvider>(context).isLoggedIn;
//     cartId = Provider.of<CartProvider>(context).cartDetails!['id'];
//
//     return Container(
//       color: Color(0xFFF4F2F0),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(height: 12),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
//               child: CustomFormField(
//                 label: 'NAME',
//                 controller: _nameController,
//                 width: MediaQuery.of(context).size.width,
//               ),
//             ),
//             SizedBox(height: 24),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
//               child: FutureBuilder(
//                 future: sfAPIFetchCountryDetails(),
//                 builder: (BuildContext _, snapshot) {
//                   if (!snapshot.hasData) {
//                     return Column(
//                       children: [
//                         Padding(
//                           padding:
//                               EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//                           child: CustomFormField(
//                             label: 'COUNTRY',
//                             controller: TextEditingController(),
//                             width: MediaQuery.of(context).size.width,
//                           ),
//                         ),
//                         SizedBox(height: 24),
//                         Padding(
//                           padding:
//                               EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//                           child: CustomFormField(
//                             label: 'REGION',
//                             controller: TextEditingController(),
//                             width: MediaQuery.of(context).size.width,
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                   return CountryField(
//                     onSelect: (country, region) async{
//                       _countryCodeController.text =
//                            await country['two_letter_abbreviation'];
//                       _countryNameController.text =
//                           country['full_name_english'];
//                       if (region != null) {
//                         _regionCodeController.text = region['code'];
//                       } else {
//                         _regionCodeController.text = '';
//                       }
//                     },
//                     countryList: snapshot.data as List,
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 24),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
//               child: CustomFormField(
//                 label: 'STREET',
//                 controller: _streetController,
//                 width: MediaQuery.of(context).size.width,
//               ),
//             ),
//             SizedBox(height: 24),
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     flex: 1,
//                     child: CustomFormField(
//                       label: 'ZIP',
//                       controller: _zipController,
//                     ),
//                   ),
//                   Flexible(
//                     flex: 2,
//                     child: CustomFormField(
//                       label: 'CITY',
//                       controller: _cityController,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 24),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
//               child: CustomFormField(
//                 prefix: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 0),
//                   decoration: BoxDecoration(
//                     border: Border(
//                       right: BorderSide(color: Color(0xFFF4F2F0)),
//                     ),
//                   ),
//                   child: CountryCodeDropDown(
//                     callback: (CountryCode code) {
//                       _phoneCodeController.text = code.diaFclCode as String;
//                       print(code);
//                     },
//                     init: (CountryCode? code) {
//                       _phoneCodeController.text = code!.dialCode as String;
//                     },
//                   ),
//                 ),
//                 label: 'PHONE',
//                 controller: _phoneController,
//                 width: MediaQuery.of(context).size.width,
//               ),
//             ),
//             SizedBox(height: 24),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
//               child: CustomFormField(
//                 label: 'EMAIL',
//                 controller: _emailController,
//                 width: MediaQuery.of(context).size.width,
//               ),
//             ),
//             SizedBox(height: 24),
//         Container(
//           width: MediaQuery.of(context).size.width,
//           padding: EdgeInsets.symmetric(vertical: 23, horizontal: 30),
//           decoration: BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Container(
//             child: Column(
//               children: [
//                 CapsuleButton(
//                   onPress: () async {
//                     // await checkoutController. shippingMethod(_nameController.text,_streetController.text,_zipController.text,_cityController.text,
//                     //   _phoneCodeController.text,_phoneController.text,_emailController.text,_regionCodeController.text,_countryNameController.text);
//                     // await sfAPIAddShippingAddressForGuest(store(), isLoggedin, cartId);
//                     if(paymentCode.contains("CHANGE"))
//                       {
//                         Navigator.pop(context);
//                       }
//                     else
//                       {
//                         try {
//                           _storeShippingAddress();
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (BuildContext _) {
//                                 return PaymentDetailsScreen(
//                                   callback: (Map<String, String> cardDetails) async {
//                                     try {
//                                       print("DD  == ");
//
//                                       // api mathi data null ave 6
//                                       String orderId = await sfApiPlaceOrder(Provider.of<CartProvider>(context,listen: false).isLoggedIn,paymentCode);
//
//                                       print("DD == = =  =$orderId");
//
//                                       if(orderId == null)
//                                       {
//                                         orderId = '1';
//                                         print("ORDER  ID == 1");
//                                       }
//
//                                       await Provider.of<CartProvider>(context,
//                                           listen: false)
//                                           .deleteCart();
//                                       Provider.of<CartProvider>(context, listen: false)
//                                           .initializeCart();
//                                       // await Navigator.push(
//                                       //   context,
//                                       //   MaterialPageRoute(builder: (BuildContext _) {
//                                       //     return OrderConfirmationScreen(
//                                       //       orderId: orderId,
//                                       //     );
//                                       //   }),
//                                       // );
//                                       await Navigator.push(
//                                         context,
//                                         MaterialPageRoute(builder: (BuildContext _) {
//                                           return GiftCardScreen(
//                                             orderId: orderId,
//                                           );
//                                         }),
//                                       );
//                                     } catch (e) {
//                                       print(
//                                           'Error setting payment information _NextButton: $e');
//                                       Get.showSnackbar(
//                                         GetSnackBar(
//                                           message:
//                                           'An error occurred while saving the payment details',
//                                           duration: Duration(seconds: 2),
//                                         ),
//                                       );
//                                     }
//                                   },
//                                 );
//                               },
//                             ),
//                           );
//                         } catch (e) {
//                           print('Error setting shipping address _NextButton: $e');
//                           Get.showSnackbar(
//                             GetSnackBar(
//                               message: 'An error occurred saving the shipping address',
//                               duration: Duration(seconds: 2),
//                             ),
//                           );
//                         }
//                       }
//                   },
//                   child: Text(
//                     'NEXT',
//                     style: Theme.of(context).textTheme.headline2!.copyWith(
//                       color: Colors.white,
//                       fontSize: 16,
//                       letterSpacing: 0.7,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 Text(
//                   'Next Step: Payment Details',
//                   style: Theme.of(context).textTheme.headline2!.copyWith(
//                     color: Colors.black,
//                     fontSize: 10,
//                     letterSpacing: 0.4,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // class _NextButton extends StatelessWidget {
// //   final Function store;
// //   final String paymentCode;
// //    _NextButton({Key? key, required this.store,required this.paymentCode}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: MediaQuery.of(context).size.width,
// //       padding: EdgeInsets.symmetric(vertical: 23, horizontal: 30),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //       ),
// //       child: Container(
// //         child: Column(
// //           children: [
// //             CapsuleButton(
// //               onPress: () async {
// //
// //                 // await checkoutController. shippingMethod(_nameController.text,_streetController.text,_zipController.text,_cityController.text,
// //                 //   _phoneCodeController.text,_phoneController.text,_emailController.text,_regionCodeController.text,_countryNameController.text);
// //                 // await sfAPIAddShippingAddressForGuest(store(), isLoggedin, cartId);
// //
// //                 if()
// //                   {
// //
// //                   }
// //                     try {
// //                       store();
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (BuildContext _) {
// //                             return PaymentDetailsScreen(
// //                               callback: (Map<String, String> cardDetails) async {
// //                                 try {
// //                                   print("DD  == ");
// //
// //                                   // api mathi data null ave 6
// //                                   String orderId = await sfApiPlaceOrder(Provider.of<CartProvider>(context,listen: false).isLoggedIn);
// //                                   print("DD == = =  =$orderId");
// //
// //                                   if(orderId == null)
// //                                   {
// //                                     orderId = '1';
// //                                     print("ORDER  ID == 1");
// //                                   }
// //
// //                                   await Provider.of<CartProvider>(context,
// //                                       listen: false)
// //                                       .deleteCart();
// //                                   Provider.of<CartProvider>(context, listen: false)
// //                                       .initializeCart();
// //                                   // await Navigator.push(
// //                                   //   context,
// //                                   //   MaterialPageRoute(builder: (BuildContext _) {
// //                                   //     return OrderConfirmationScreen(
// //                                   //       orderId: orderId,
// //                                   //     );
// //                                   //   }),
// //                                   // );
// //                                   await Navigator.push(
// //                                     context,
// //                                     MaterialPageRoute(builder: (BuildContext _) {
// //                                       return GiftCardScreen(
// //                                         orderId: orderId,
// //                                       );
// //                                     }),
// //                                   );
// //                                 } catch (e) {
// //                                   print(
// //                                       'Error setting payment information _NextButton: $e');
// //                                   Get.showSnackbar(
// //                                     GetSnackBar(
// //                                       message:
// //                                       'An error occurred while saving the payment details',
// //                                       duration: Duration(seconds: 2),
// //                                     ),
// //                                   );
// //                                 }
// //                               },
// //                             );
// //                           },
// //                         ),
// //                       );
// //                     } catch (e) {
// //                       print('Error setting shipping address _NextButton: $e');
// //                       Get.showSnackbar(
// //                         GetSnackBar(
// //                           message: 'An error occurred saving the shipping address',
// //                           duration: Duration(seconds: 2),
// //                         ),
// //                       );
// //                     }
// //               },
// //               child: Text(
// //                 'NEXT',
// //                 style: Theme.of(context).textTheme.headline2!.copyWith(
// //                       color: Colors.white,
// //                       fontSize: 16,
// //                       letterSpacing: 0.7,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //               ),
// //             ),
// //             SizedBox(height: 15),
// //             Text(
// //               'Next Step: Payment Details',
// //               style: Theme.of(context).textTheme.headline2!.copyWith(
// //                     color: Colors.black,
// //                     fontSize: 10,
// //                     letterSpacing: 0.4,
// //                   ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
