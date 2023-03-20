import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/controller/currencyController.dart';
import 'package:sofiqe/controller/msProfileController.dart';
import 'package:sofiqe/model/currency.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/Ms1/privacy_policy.dart';
import 'package:sofiqe/screens/Ms2/my_shopping_history.dart';
import 'package:sofiqe/screens/signup_screen.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/states/local_storage.dart';
import 'package:sofiqe/widgets/my_sofiqe/profile_information.dart';

import '../../provider/catalog_provider.dart';
import '../../widgets/makeover/make_over_login_custom_widget.dart';
import '../login_screen.dart';
import '../my_sofiqe.dart';
import '../try_it_on_screen.dart';

class Ms1Profile extends StatefulWidget {
  const Ms1Profile({Key? key}) : super(key: key);

  @override
  _Ms1ProfileState createState() => _Ms1ProfileState();
}

var itemsCurrency = [
  "GBP",
  "CAD",
  "DKK",
  "EUR",
  "ISK",
  "NOK",
  "SEK",
  "CHF",
  "USD"
];

class _Ms1ProfileState extends State<Ms1Profile>
    with SingleTickerProviderStateMixin {
  final TryItOnProvider tiop = Get.find();
  final CatalogProvider cata=Get.find();
  late TabController _controller;
  List<RecentScan> recenScan = [
    RecentScan(
        image: 'assets/images/dior1.png',
        title: 'Rouge Dior Ultra Care - Batom',
        type: 'DIOR'),
    RecentScan(
        image: 'assets/images/dior2.png',
        title: 'Dior Addict Lacquer Plump',
        type: 'DIOR'),
    RecentScan(
        image: 'assets/images/dior3.png',
        title: 'Dior Addict Lips Stellar Shine 3 g',
        type: 'DIOR'),
    RecentScan(
        image: 'assets/images/dior1.png',
        title: 'Rouge Dior Ultra Care - Batom',
        type: 'DIOR'),
  ];

  bool notification = false;
  bool sound=false;
  dynamic selectedCurrencyVal;

  @override
  void initState() {
    super.initState();
    profileController.screen.value = 0;
    profileController.getRecenItems();
    profileController.getUserProfile();
    _controller = new TabController(length: 2, vsync: this);
    setDefaultValue();
  }

  setDefaultValue() {
    setState(() {
      selectedCurrencyVal = CurrencyController.to.currency;
      //  print(selectedCurrencyVal + "hhhhhhhhhhhhhhhhhh");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (profileController.screen.value == 1) {
        return MakeOverCustomWidget();
      } else if (profileController.screen.value == 2) {
        return MakeOvarSingle(
          description:
              'For this section you have to complete your Makeover first',
          title: 'We are sofiqe',
        );
      } else if (profileController.screen.value == 3) {
        return MySofiqe();
      } else if (profileController.screen.value == 4) {
        return MyShoppingHistory();
        //return ShoppingBagScreen();
      } else
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                ProfileInformation(),
                Expanded(
                    child: SingleChildScrollView(
                  child: mySofiqe(context),
                ))
              ],
            ),
          ),
        );
    });
  }

  Container mySofiqe(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AccountProvider account = Provider.of<AccountProvider>(context);

    return Container(
        child: Column(
      children: [
        displayTile(
            leading: "lipstick.png",
            title: "My Shopping History",
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
            handler: () async {
              !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
                  ? profileController.screen.value = 1
                  : profileController.screen.value = 4;
            }),
        Divider(),
        displayTile(
            leading: "user.png",
            title: "Natural Me",
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
            handler: () async {
              !makeOverProvider.tryitOn.value
                  ? profileController.screen.value = 2
                  : profileController.screen.value = 3;
            }),
        // Divider(),
        // displayTile(
        //     leading: "eye.png",
        //     title: "Looks",
        //     trailing: Icon(
        //       Icons.arrow_forward_ios,
        //       size: 15,
        //     ),
        //     handler: () async {
        //       !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
        //           ? profileController.screen.value = 2
        //           : Get.to(() => LooksScreen());
        //     }),
        // Divider(),
        // //here comment
        // displayTile(
        //     leading: "scantry.png",
        //     title: "Scan & Try on",
        //     trailing: Icon(
        //       Icons.arrow_forward_ios,
        //       size: 15,
        //     ),
        //     handler: () async {
        //       // !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
        //       //     ? profileController.screen.value = 1
        //       //     : Get.to(() => TryItOnScreen());
        //
        //       Get.to(() => TryItOnScreen());
        //
        //     }),
        // Divider(),
        // displayTile(
        //     leading: "review.png",
        //     title: "Reviews/Wishlist",
        //     trailing: Icon(
        //       Icons.arrow_forward_ios,
        //       size: 15,
        //     ),
        //     handler: () async {
        //       !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
        //           ? profileController.screen.value = 1
        //           : Get.to(() => ReviewsMS6());
        //     }),
        // Divider(),
        // displayTile(
        //     leading: "eye.png",
        //     title: "Looks",
        //     trailing: Icon(
        //       Icons.arrow_forward_ios,
        //       size: 15,
        //     ),
        //     handler: () async {
        //       !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
        //           ? profileController.screen.value = 2
        //           : Get.to(() => LooksScreen());
        //     }),
        // Divider(),
        // //here comment
        // displayTile(
        //     leading: "scantry.png",
        //     title: "Scan & Try on",
        //     trailing: Icon(
        //       Icons.arrow_forward_ios,
        //       size: 15,
        //     ),
        //     handler: () async {
        //       // !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
        //       //     ? profileController.screen.value = 1
        //       //     : Get.to(() => TryItOnScreen());
        //
        //       Get.to(() => TryItOnScreen());
        //     }),
        // Divider(),
        // displayTile(
        //     leading: "review.png",
        //     title: "Reviews/Wishlist",
        //     trailing: Icon(
        //       Icons.arrow_forward_ios,
        //       size: 15,
        //     ),
        //     handler: () async {
        //       !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
        //           ? profileController.screen.value = 1
        //           : Get.to(() => ReviewsMS6());
        //     }),
        Divider(),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: new TabBar(
            indicatorPadding: EdgeInsets.zero,
            isScrollable: true,
            indicatorColor: Color(0xffF2CA8A),
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 12, color: Colors.black),
            controller: _controller,
            tabs: [
              new Tab(
                text: 'RECENT SCANS',
              ),
              new Tab(
                text: 'RECENT COLOURS',
              ),
            ],
          ),
        ),
        Container(
          height: (profileController.recentItem == null ||
                  profileController.recentItem!.data!.items!.length == 0)
              ? MediaQuery.of(context).size.height * 0.23
              : MediaQuery.of(context).size.height * 0.23,
          child: new TabBarView(
            controller: _controller,
            children: <Widget>[
              GetBuilder<MsProfileController>(builder: (contrl) {
                return (contrl.isRecentLoading)
                    ? Container(
                        child: Center(
                        child: SpinKitDoubleBounce(
                          color: Color(0xffF2CA8A),
                          size: 50.0,
                        ),
                      ))
                    : (contrl.recentItem == null ||
                            contrl.recentItem!.data!.items!.length == 0 ||
                            contrl.recentItem!.data!.items!.first.id == '')
                        ? Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  // !Provider.of<AccountProvider>(context,
                                  //             listen: false)
                                  //         .isLoggedIn
                                  //     ? profileController.screen.value = 1
                                  //     :  Navigator.push(context,MaterialPageRoute(builder: (builder)=>TryItOnScreen()));

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              TryItOnScreen()));
                                },
                                child: Container(
                                  height: 50,
                                  width: Get.width * 0.7,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF2CA8A),
                                      borderRadius: BorderRadius.circular(50)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Scan products or colours",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.23,
                            width: double.infinity,
                            // color: Colors.green,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 20,
                                        //margin: EdgeInsets.only(top: 30),
                                        child: Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 15,
                                        ),
                                      )),
                                  Expanded(
                                      child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        contrl.recentItem!.data!.items!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          //Get.to(() => MyShoppingHistory());
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                width: 96,
                                                child: Container(
                                                  height: 96,
                                                  width: 96,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Image.network(
                                                      APIEndPoints
                                                              .mediaBaseUrl +
                                                          "${contrl.recentItem!.data!.items![index].image}",
                                                      // recenScan[0].image!,
                                                      height: 52,
                                                      width: 33,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              contrl.recentItem!.data!
                                                  .items![index].brand!,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xff938282)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: 90,
                                              child: Text(
                                                contrl.recentItem!.data!
                                                    .items![index].name!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              child: RatingBar.builder(
                                                initialRating: 3,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 12.0,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'REVIEW',
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  )),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 20,
                                      // margin: EdgeInsets.only(top: 30),
                                      // color:Colors.pink,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
              }),
              GetBuilder<MsProfileController>(builder: (contrl) {
                return (contrl.isRecentLoading)
                    ? Container(
                        child: Center(
                        child: SpinKitDoubleBounce(
                          color: Color(0xffF2CA8A),
                          size: 50.0,
                        ),
                      ))
                    : (contrl.recentItem == null ||
                            contrl.recentItem!.data!.items!.length == 0)
                        ? Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  // !Provider.of<AccountProvider>(context,
                                  //             listen: false)
                                  //         .isLoggedIn
                                  //     ? profileController.screen.value = 1
                                  //     : Get.to(() => TryItOnScreen());
                                  Get.to(() => TryItOnScreen());
                                },
                                child: Container(
                                  height: 50,
                                  width: Get.width * 0.7,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF2CA8A),
                                      borderRadius: BorderRadius.circular(50)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Scan products or colours",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 20,
                                        //margin: EdgeInsets.only(top: 30),
                                        child: Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 15,
                                        ),
                                      )),
                                  Expanded(
                                      child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        contrl.recentItem!.data!.items!.length,
                                    itemBuilder: (context, index) {
                                      return Align(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            width: 96,
                                            child: Container(
                                              width: 96,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 96,
                                                    width: 96,
                                                    decoration: BoxDecoration(
                                                        color: HexColor(contrl
                                                            .recentItem!
                                                            .data!
                                                            .items![index]
                                                            .scanColour
                                                            .toString()),
                                                        border: Border.all(
                                                            color: Colors.black,
                                                            width: 1.5)),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Hex' +
                                                          contrl
                                                              .recentItem!
                                                              .data!
                                                              .items![index]
                                                              .scanColour
                                                              .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                          ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 20,
                                      // margin: EdgeInsets.only(top: 30),
                                      // color:Colors.pink,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
              }),
            ],
          ),
        ),
        Container(
          height: 187,
          width: Get.width,
          decoration: BoxDecoration(
              color: Color(0x4D000000),
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/my_sofiqe_upgrade_background.png"),
                  fit: BoxFit.cover)),
          child: account.isLoggedIn
              ? Center(
                  child: Text(
                    'YOU ARE SOFIQE',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.white,
                          fontSize: size.height * 0.028,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Unlock Unlimited Sofiqe",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // Get.to(() => PremiumSubscriptionScreen());
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext c) {
                              return SignupScreen();
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: Get.width * 0.6,
                        decoration: BoxDecoration(
                            color: Color(0xffF2CA8A),
                            borderRadius: BorderRadius.circular(50)),
                        alignment: Alignment.center,
                        child: Text(
                          "Subscribe",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
        ),
        displayTile(
            leading: "",
            title: "Currency Change",
            trailing: Obx(
              () => DropdownButton(
                // Initial Value
                value: CurrencyController.to.defaultCurrencyCode.value,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: (CurrencyController
                            .to.currencyModelNew.value.availableCurrencyCodes ??
                        [])
                    .map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  double? newExchangeRate = 0.0;
                  List list = (CurrencyController
                          .to.currencyModelNew.value.exchangeRates ??
                      []);
                  for (int i = 0; i < list.length; i++) {
                    ExchangeRates ex = list[i];
                    if (ex.currencyTo == newValue) {
                      newExchangeRate = ex.rate;
                    }
                  }

                  setState(() {
                    CurrencyController.to.defaultCurrencyCode.value =
                        newValue ?? "USD";
                    CurrencyController.to.exchangeRateinDouble.value =
                        newExchangeRate ?? 0;
                    sfStoreInSharedPrefData(
                        fieldName: "currency-code",
                        value: newValue ?? "USD",
                        type: PreferencesDataType.STRING);
                    sfStoreInSharedPrefData(
                        fieldName: "exchange-rate",
                        value: newExchangeRate ?? 0,
                        type: PreferencesDataType.DOUBLE);
                    // saveCurrencyLocally(
                    //     CurrencyController.to.defaultCurrencyCode.value);
                    // saveCurrencyLocally(newValue);
                    print(newValue.toString() + "nnnnnnnnnnnn");
                    print(sfQueryForSharedPrefData(
                        fieldName: "currency-code",
                        type: PreferencesDataType.STRING));

                    print(CurrencyController.to.defaultCurrencyCode.value);
                  });
                  print("New Exchange Rate");
                  print(CurrencyController.to.exchangeRateinDouble.value);
                },
              ),
            ),
            handler: () {}
            // handler: () async {
            //   // !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
            //   //     ? profileController.screen.value = 1
            //   //     : Get.to(() => TryItOnScreen());

            //   Get.to(() => CurrencyChange());
            // }),
            ),
        Divider(),
        displayTile(
            leading: "",
            title: "Notifications",
            trailing: Switch(
                value: notification,
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.red,
                onChanged: (val) {
                  notification = val;
                  setState(() {});
                }),
            handler: () {}),
        Divider(),
        displayTile(
            leading: "",
            title: "Sound",
            trailing: Switch(
                value: tiop.isplaying.value,
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.red,
                onChanged: (val) {
                  sound = val;
                  tiop.isplaying.value=val;
                  cata.isplaying.value=val;
                  setState(() {});
                }),
            handler: () {}),

        Divider(),
        displayTile(
            leading: "",
            title: "Privacy policy",
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
            handler: () {
              Get.to(() => PrivacyPolicyScreen(
                    isTerm: false,
                    isReturnPolicy: false,
                  ));
            }),
        Divider(),
        displayTile(
            leading: "",
            title: "Terms and conditions",
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
            handler: () {
              Get.to(() => PrivacyPolicyScreen(
                    isTerm: true,
                    isReturnPolicy: false,
                  ));
            }),
        Divider(),
        displayTile(
            leading: "",
            title: "Return Policy",
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
            handler: () {
              Get.to(() => PrivacyPolicyScreen(
                    isTerm: true,
                    isReturnPolicy: true,
                  ));
            }),

        account.isLoggedIn
            ? Column(
                children: [
                  Divider(),
                  displayTile(
                      leading: "",
                      title: "Log Out",
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                      handler: () {
                        Get.defaultDialog<bool>(
                            title: '',
                            titleStyle: const TextStyle(fontSize: 1),
                            radius: 10,
                            titlePadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.only(
                                top: 17, left: 16, right: 16, bottom: 5),
                            content: Column(
                              children: [
                                Text(
                                  'sofiqe',
                                  style: Theme.of(context).textTheme.headline1!.copyWith(
                                      color: Colors.black,
                                      fontSize: size.height * 0.04,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.6),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  'Are You Sure?',
                                  style: TextStyle(color: Colors.black, fontSize: 13, letterSpacing: 1, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "Would you like to logout from the app?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black, fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        borderRadius: BorderRadius.circular(20),
                                        // splashColor: kCustomLightGreenColor.withOpacity(.3),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Center(
                                            child: Text(
                                              'NO',
                                              style: TextStyle(color: Colors.black, fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          account.logout();
                                          Navigator.pop(context);
                                        },
                                        borderRadius: BorderRadius.circular(20),
                                        // splashColor: kCustomLightGreenColor.withOpacity(.3),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'YES',
                                              style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w400),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ));
                     
                      }),
                ],
              )
            : Column(
                children: [
                  Divider(),
                  displayTile(
                      leading: "",
                      title: "Sign In",
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                      handler: () async {
                        profileController.screen.value = 0;
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext _) {
                              return LoginScreen();
                            },
                          ),
                        );
                      }),
                  Divider(),
                  displayTile(
                      leading: "",
                      title: "Sign Up",
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                      handler: () async {
                        profileController.screen.value = 0;
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext _) {
                              return SignupScreen();
                            },
                          ),
                        );
                      }),
                ],
              ),
      ],
    ));
  }

  Widget displayTile(
      {String? leading,
      String? title,
      Widget? trailing,
      required Function handler}) {
    print("assets/images/$leading");
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: ListTile(
        onTap: () => handler(),
        leading: leading!.isEmpty
            ? SizedBox()
            : Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    // color: Colors.black
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/images/$leading"))),
              ),
        title: Transform.translate(
          offset: Offset(-25, 0),
          child: Text(
            '$title',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.black,
                  fontSize: 13,
                ),
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}

class RecentScan {
  String? image;
  String? title;
  String? type;

  RecentScan({this.image, this.title, this.type});
}