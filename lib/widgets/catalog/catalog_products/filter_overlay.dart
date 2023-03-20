import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/catalog_provider.dart';
import 'package:sofiqe/utils/states/function.dart';
import 'package:sofiqe/widgets/capsule_button.dart';

import '../../../model/CategoryResponse.dart';

class FilterOverlay extends StatelessWidget {
  FilterOverlay({Key? key}) : super(key: key);

  final CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Obx(
        () {
          FilterType ftp = catp.filterTypePressed.value;

          switch (ftp) {
            case FilterType.SKINTONE:
              return Column(
                children: [
                  //BrandSelector(),
                  SkinToneSelector(),
                  CloseButton(),
                ],
              );
            case FilterType.PRODUCT:
              return Column(
                children: [
                  ProductSelector(),
                  CloseButton(),
                ],
              );
            case FilterType.PRICE:
              return Column(
                children: [
                  PriceSelector(),
                  CloseButton(),
                ],
              );
            case FilterType.BRAND:
              return Column(
                children: [
                  BrandSelector(),
                  CloseButton(),
                ],
              );
            case FilterType.REVIEW:
              return Column(
                children: [
                  ReviewSelector(),
                  CloseButton(),
                ],
              );
            case FilterType.POPULAR:
              break;
            case FilterType.NONE:
              break;
          }
          return Container();
        },
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  CloseButton({Key? key}) : super(key: key);

  final CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.065,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(size.height * 0.06),
            bottomRight: Radius.circular(size.height * 0.06)),
      ),
      child: GestureDetector(
        onTap: () {
          CatalogProvider catalogProvider = Get.find<CatalogProvider>();
          //added by kruti for validation (user need to select options before clicking find) to check before find button
          // is clicked  from line 93 to 229
          print("TAPED FIND BUTTON");
          Rx<BrandFilter> pf = BrandFilter().obs;
          // BrandFilter stf = BrandFilter();

          if (catp.filterTypePressed.value == FilterType.SKINTONE) {
            if (catp.faceArea.value == FaceArea.ALL) {
              pf = catp.allBrandFilter;
              // stf = catalogProvider.eyesBrandFilter.value;
            } else if (catp.faceArea.value == FaceArea.CHEEKS) {
              pf = catp.cheeksBrandFilter;
              // stf = catalogProvider.eyesBrandFilter.value;
            } else if (catp.faceArea.value == FaceArea.LIPS) {
              pf = catp.lipsBrandFilter;
              // stf = catalogProvider.lipsBrandFilter.value;
            } else if (catp.faceArea.value == FaceArea.EYES) {
              pf = catp.eyesBrandFilter;
              // stf = catalogProvider.eyesBrandFilter.value;
            }
            if (pf.value.subArea == "") {
              Get.showSnackbar(
                GetSnackBar(
                  message: 'Please select face area',
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              if (catp.faceArea.value == FaceArea.EYES) {
                if (catalogProvider.selectHairColor.value == "" ||
                    catalogProvider.selectEyesColor.value == "") {
                  Get.showSnackbar(
                    GetSnackBar(
                      message: 'Please select hair and eye colour',
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  catp.applyFilter();
                }
              } else if (catp.faceArea.value == FaceArea.CHEEKS) {
                print("cheeks : ${catp.faceArea.value}");

                //  print("subArea : ${stf.subAreaGlobal}");
                if (pf.value.subArea == "") {
                  Get.showSnackbar(
                    GetSnackBar(
                      message: 'Please select face area',
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else if (catalogProvider.selectCHeekShadeID.value == "") {
                  Get.showSnackbar(
                    GetSnackBar(
                      message: 'Please select shade colour',
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  catp.applyFilter();
                }
              } else if (catp.faceArea.value == FaceArea.LIPS) {
                print("lips : ${catp.faceArea.value}");
                if (pf.value.subArea == "") {
                  Get.showSnackbar(
                    GetSnackBar(
                      message: 'Please select face area',
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else if (catalogProvider.selectLipsShadeID.value == "") {
                  Get.showSnackbar(
                    GetSnackBar(
                      message: 'Please select shade colour',
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  catp.applyFilter();
                }
              }

              print("pf.value.subArea::: ${pf.value.subArea}");
            }
          } else if (catp.filterTypePressed.value == FilterType.PRODUCT) {
            ProductFilter pf = ProductFilter();
            if (catp.faceArea.value == FaceArea.ALL) {
              pf = catalogProvider.allProductFilter.value;
            } else if (catp.faceArea.value == FaceArea.EYES) {
              pf = catalogProvider.eyesProductFilter.value;
            } else if (catp.faceArea.value == FaceArea.CHEEKS) {
              pf = catalogProvider.cheeksProductFilter.value;
            } else if (catp.faceArea.value == FaceArea.LIPS) {
              pf = catalogProvider.lipsProductFilter.value;
            }
            if (!pf.changed) {
              Get.showSnackbar(
                GetSnackBar(
                  message: 'Please select face area',
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              catp.applyFilter();
            }
          } else if (catp.filterTypePressed.value == FilterType.PRICE) {
            ///------new
            //  if (priceFilter.value.changed) {
            //    catalogItemsList.removeWhere((element) => true);
            //    catalogItemsCurrentPage.value = 0;
            //    this.priceFilter.value.readFilter();
            //    catalogItemsStatus.value = DataReadyStatus.FETCHING;
            //    String selectedFaceArea = "";
            //    if (faceAreaToIdMapping[faceArea.value] == FaceArea.EYES) {
            //      selectedFaceArea = "eyes";
            //    } else if (faceAreaToIdMapping[faceArea.value] == FaceArea.LIPS) {
            //      selectedFaceArea = "lips";
            //    } else if (faceAreaToIdMapping[faceArea.value] == FaceArea.CHEEKS) {
            //      selectedFaceArea = "cheeks";
            //    }
            //    await fetchBetweenPriceItems(selectedFaceArea);
            //  }

            ///---old
            // if (!catalogProvider.) {
            //   Get.showSnackbar(
            //     GetSnackBar(
            //       message: 'Please select review',
            //       duration: Duration(seconds: 2),
            //     ),
            //   );
            // } else {
            catp.setFilter(FilterType.PRICE);
            catp.applyFilter();
            // }
            // }
          } else if (catp.filterTypePressed.value == FilterType.BRAND) {
            BrandFilter pf = BrandFilter();
            if (catp.faceArea.value == FaceArea.ALL) {
              pf = catalogProvider.allBrandFilter.value;
            } else if (catp.faceArea.value == FaceArea.EYES) {
              pf = catalogProvider.eyesBrandFilter.value;
            } else if (catp.faceArea.value == FaceArea.CHEEKS) {
              pf = catalogProvider.cheeksBrandFilter.value;
            } else if (catp.faceArea.value == FaceArea.LIPS) {
              pf = catalogProvider.lipsBrandFilter.value;
            }
            if (pf.subArea == "" || pf.brand == "") {
              Get.showSnackbar(
                GetSnackBar(
                  message: 'Please select face area and brand',
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              catp.applyFilter();
            }
          } else if (catp.filterTypePressed.value == FilterType.REVIEW) {
            if (!catalogProvider.starValueChanges.value) {
              Get.showSnackbar(
                GetSnackBar(
                  message: 'Please select review',
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              catp.applyFilter();
            }
          }
          //  catp.applyFilter();
        },
        child: Center(
          child: Text(
            'FIND',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.white,
                  fontSize: size.height * 0.016,
                ),
          ),
        ),
      ),
    );
  }
}

class PriceSelector extends StatefulWidget {
  PriceSelector({Key? key}) : super(key: key);

  @override
  State<PriceSelector> createState() => _PriceSelectorState();
}

class _PriceSelectorState extends State<PriceSelector> {
  final CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RangeValues currentRangeValues = RangeValues(
        catp.priceFilter.value.currentMinPrice.toDouble(),
        catp.priceFilter.value.currentMaxPrice.toDouble());
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.06),
      color: Colors.black,
      child: Row(
        children: [
          Text(
            // catp.currencySymbol +
            '${catp.priceFilter.value.minPrice.toString().toProperCurrency()}',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.white,
                  fontSize: size.height * 0.014,
                ),
          ),
          Expanded(
            child: RangeSlider(
              activeColor: Color(0xFFF2CA8A),
              inactiveColor: Color(0xFF504D4D),
              values: currentRangeValues,
              min: catp.priceFilter.value.minPrice.toDouble(),
              max: catp.priceFilter.value.maxPrice.toDouble(),
              labels: RangeLabels(
                // catp.currencySymbol +
                ' ${catp.priceFilter.value.currentMinPrice.toString().toProperCurrency()}',
                // catp.currencySymbol +
                ' ${catp.priceFilter.value.currentMaxPrice.toString().toProperCurrency()}',
              ),
              divisions: catp.priceFilter.value.maxPrice,
              onChanged: (RangeValues values) {
                catp.priceFilter.value.currentMinPrice = values.start.toInt();
                catp.priceFilter.value.currentMaxPrice = values.end.toInt();
                setState(() {});
              },
            ),
          ),
          Text(
            // catp.currencySymbol +
            '${catp.priceFilter.value.maxPrice.toString().toProperCurrency()}',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.white,
                  fontSize: size.height * 0.014,
                ),
          ),
        ],
      ),
    );
  }
}

class BrandSelector extends StatelessWidget {
  BrandSelector({Key? key}) : super(key: key);

  final CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.01, vertical: size.height * 0.02),
      width: size.width,
      // height: size.height - 600,
      color: Colors.black,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () {
                Rx<BrandFilter> pf = BrandFilter().obs;
                if (catp.faceArea.value == FaceArea.ALL) {
                  pf = catp.allBrandFilter;
                } else if (catp.faceArea.value == FaceArea.CHEEKS) {
                  pf = catp.cheeksBrandFilter;
                } else if (catp.faceArea.value == FaceArea.LIPS) {
                  pf = catp.lipsBrandFilter;
                } else if (catp.faceArea.value == FaceArea.EYES) {
                  pf = catp.eyesBrandFilter;
                }
                pf.value.brands.sort(
                  (a, b) => a.compareTo(b),
                );
                return Row(
                  children: pf.value.subAreas.map(
                    (sa) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.012),
                        child: CapsuleButton(
                          backgroundColor: pf.value.subArea == sa
                              ? Colors.white
                              : Colors.transparent,
                          borderColor: Colors.white38,
                          height: size.height * 0.05,
                          child: Text(
                            '$sa',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontSize: size.height * 0.014,
                                      color: pf.value.subArea == sa
                                          ? Colors.black
                                          : Color(0xFFF2CA8A),
                                    ),
                          ),
                          onPress: () async {
                            // added by kruti to solve issue of selection for filters ..
                            // clicking search  was not clearing faceArea

                            /* show loader */
                            catp.showLoaderDialog(context);

                            print("sa :: ${sa.toString()}");
                            if (pf.value.subArea == sa) {
                              pf.value.subArea = '';
                            } else {
                              pf.value.subArea = sa;
                              catp.isProfileSearchEyes.value = false;
                              pf.refresh();
                            }
                            String faceArea = "";
                            if (catp.faceArea.value == FaceArea.ALL) {
                              faceArea = faceAreaToStringMapping[FaceArea.EYES]
                                  as String;
                            } else if (catp.faceArea.value == FaceArea.CHEEKS) {
                              faceArea =
                                  faceAreaToStringMapping[FaceArea.CHEEKS]
                                      as String;
                            } else if (catp.faceArea.value == FaceArea.LIPS) {
                              faceArea = faceAreaToStringMapping[FaceArea.LIPS]
                                  as String;
                            } else if (catp.faceArea.value == FaceArea.EYES) {
                              faceArea = faceAreaToStringMapping[FaceArea.EYES]
                                  as String;
                            }
                            //added by kruti need to call api 15c  here after brand changes are done from backend side
                            //to fetch brand items for selected faceArea
                            await catp.fetchFilteredBrandNames(
                                faceArea, pf.value.subArea);
                            //    pf.refresh();

                            /* hide loader */
                            Navigator.canPop(context)
                                ? Navigator.pop(context)
                                : null;
                          },
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Obx(
            () {
              Rx<BrandFilter> pf = BrandFilter().obs;
              if (catp.faceArea.value == FaceArea.ALL) {
                pf = catp.allBrandFilter;
              } else if (catp.faceArea.value == FaceArea.CHEEKS) {
                pf = catp.cheeksBrandFilter;
              } else if (catp.faceArea.value == FaceArea.LIPS) {
                pf = catp.lipsBrandFilter;
              } else if (catp.faceArea.value == FaceArea.EYES) {
                pf = catp.eyesBrandFilter;
              }
              pf.value.brands.sort(
                (a, b) => a.compareTo(b),
              );
              return Container(
                constraints: BoxConstraints(
                  minWidth: size.width,
                  maxHeight: size.height * 0.3,
                ),
                // height: size.height * 0.2,
                child: SingleChildScrollView(
                  child: Wrap(
                    runSpacing: size.height * 0.014,
                    children: [
                      ...pf.value.brands.map(
                        (b) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.01),
                            child: CapsuleButton(
                              horizontalPadding: 0,
                              borderColor: Colors.white38,
                              backgroundColor: pf.value.brand == b
                                  ? Colors.white
                                  : Colors.black,
                              width: size.width * 0.3,
                              height: size.height * 0.05,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  '$b',
                                  // overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                        fontSize: size.height * 0.012,
                                        color: pf.value.brand == b
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                ),
                              ),
                              // child: Container(
                              //   padding: EdgeInsets.all(1),
                              //   child: AutoSizeText(
                              //     '$b',
                              //     minFontSize: 4,
                              //     textAlign: TextAlign.center,
                              //     style: Theme.of(context).textTheme.headline2!.copyWith(
                              //           fontSize: size.height * 0.014,
                              //           color: pf.value.brand == b ? Colors.black : Colors.white,
                              //         ),
                              //     maxLines: 1,
                              // ),
                              // ),
                              onPress: () {
                                if (pf.value.brand == b) {
                                  pf.value.brand = '';
                                } else {
                                  pf.value.brand = b;
                                }
                                pf.refresh();
                              },
                            ),
                          );
                        },
                      ).toList(),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
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
}

class ReviewSelector extends StatelessWidget {
  ReviewSelector({Key? key}) : super(key: key);

  final CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.01, vertical: size.height * 0.02),
      width: size.width,
      color: Colors.black,
      child: Column(
        children: [
          Obx(
            () {
              return Container(
                constraints: BoxConstraints(
                  minWidth: size.width,
                  maxHeight: size.height * 0.4,
                ),
                // height: size.height * 0.2,
                child: SingleChildScrollView(
                  child: Wrap(
                    runSpacing: size.height * 0.014,
                    children: [
                      ...catp.availableStar.map(
                        (b) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.01),
                            child: CapsuleButton(
                              horizontalPadding: 0,
                              borderColor: Colors.white38,
                              backgroundColor: catp.selectedStar.value == 5 &&
                                      b == "5 Star"
                                  ? Colors.white
                                  : catp.selectedStar.value == 4 &&
                                          b == "4 Star"
                                      ? Colors.white
                                      : catp.selectedStar.value == 3 &&
                                              b == "3 Star"
                                          ? Colors.white
                                          : catp.selectedStar.value == 2 &&
                                                  b == "2+ Star"
                                              ? Colors.white
                                              : catp.selectedStar.value == 1 &&
                                                      b == "1+ Star"
                                                  ? Colors.white
                                                  : Colors.black,
                              width: size.width * 0.3,
                              height: size.height * 0.05,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  '$b',
                                  // overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                        fontSize: size.height * 0.012,
                                        color: catp.selectedStar.value == 5 &&
                                                b == "5 Star"
                                            ? Colors.black
                                            : catp.selectedStar.value == 4 &&
                                                    b == "4 Star"
                                                ? Colors.black
                                                : catp.selectedStar.value ==
                                                            3 &&
                                                        b == "3 Star"
                                                    ? Colors.black
                                                    : catp.selectedStar.value ==
                                                                2 &&
                                                            b == "2+ Star"
                                                        ? Colors.black
                                                        : catp.selectedStar
                                                                        .value ==
                                                                    1 &&
                                                                b == "1+ Star"
                                                            ? Colors.black
                                                            : Colors.white,
                                      ),
                                ),
                              ),
                              onPress: () {
                                /// update the logic as por new review list
                                if (catp.selectedStar.value == 0 &&
                                    b == "5 Star") {
                                  catp.selectedStar.value = 10;
                                  catp.starValueChanges.value = true;
                                } else if (catp.selectedStar.value != 0 &&
                                    b == "5 Star") {
                                  catp.selectedStar.value = 5; // 4 star
                                  catp.starValueChanges.value = true;
                                } else if (catp.selectedStar.value == 1 &&
                                    b == "4 Star") {
                                  catp.selectedStar.value = 10;
                                  catp.starValueChanges.value = true;
                                } else if (catp.selectedStar.value != 1 &&
                                    b == "4 Star") {
                                  catp.selectedStar.value = 4;
                                  catp.starValueChanges.value = true;
                                } else if (catp.selectedStar.value == 2 &&
                                    b == "3 Star") {
                                  catp.selectedStar.value = 10;
                                  catp.starValueChanges.value = true;
                                } else if (catp.selectedStar.value != 2 &&
                                    b == "3 Star") {
                                  catp.selectedStar.value = 3;
                                  catp.starValueChanges.value = true;
                                }
                              },
                            ),
                          );
                        },
                      ).toList(),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class ProductSelector extends StatelessWidget {
  ProductSelector({Key? key}) : super(key: key);

  final CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.02),
      width: size.width,
      color: Colors.black,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(
          () {
            Rx<ProductFilter> pf = ProductFilter().obs;
            if (catp.faceArea.value == FaceArea.ALL) {
              pf = catp.allProductFilter;
            } else if (catp.faceArea.value == FaceArea.CHEEKS) {
              pf = catp.cheeksProductFilter;
            } else if (catp.faceArea.value == FaceArea.LIPS) {
              pf = catp.lipsProductFilter;
            } else if (catp.faceArea.value == FaceArea.EYES) {
              pf = catp.eyesProductFilter;
            }
            return Row(
              children: pf.value.subAreas.map(
                (sa) {
                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: size.width * 0.012),
                    child: CapsuleButton(
                      backgroundColor: pf.value.subArea == sa
                          ? Colors.white
                          : Colors.transparent,
                      borderColor: Colors.white38,
                      height: size.height * 0.05,
                      child: Text(
                        '${sa.name!}',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: size.height * 0.014,
                              color: pf.value.subArea == sa
                                  ? Colors.black
                                  : Color(0xFFF2CA8A),
                            ),
                      ),
                      onPress: () {
                        if (pf.value.subArea == sa) {
                          pf.value.subArea = ChildrenData();
                        } else {
                          pf.value.subArea = sa;
                        }
                        pf.refresh();
                      },
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}

class SkinToneSelector extends StatelessWidget {
  SkinToneSelector({Key? key}) : super(key: key);

  final CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.01, vertical: size.height * 0.02),
        width: size.width,
        height: size.height - 440,
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () {
                    Rx<BrandFilter> pf = BrandFilter().obs;
                    if (catp.faceArea.value == FaceArea.ALL) {
                      pf = catp.allBrandFilter;
                    } else if (catp.faceArea.value == FaceArea.CHEEKS) {
                      pf = catp.cheeksBrandFilter;
                    } else if (catp.faceArea.value == FaceArea.LIPS) {
                      pf = catp.lipsBrandFilter;
                    } else if (catp.faceArea.value == FaceArea.EYES) {
                      pf = catp.eyesBrandFilter;
                    }
                    return Row(
                      children: pf.value.subAreas.map(
                        (sa) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.012),
                            child: CapsuleButton(
                              backgroundColor: pf.value.subArea == sa
                                  ? Colors.white
                                  : Colors.transparent,
                              borderColor: Colors.white38,
                              height: size.height * 0.05,
                              child: Text(
                                '$sa',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      fontSize: size.height * 0.014,
                                      color: pf.value.subArea == sa
                                          ? Colors.black
                                          : Color(0xFFF2CA8A),
                                    ),
                              ),
                              onPress: () {
                                // if (pf.value.subArea == sa) {
                                //   print(sa);
                                //   print(pf.value.subArea);
                                //   pf.value.subArea = '';
                                // } else {
                                //   pf.value.subArea = sa;
                                // }
                                // added by kruti to resolve error of selection of faceArea when  search is clicked
                                // above code is commented too.

                                showLoaderDialog(context);
                                print(
                                    "SUBAREA IF MATCH : ${pf.value.subArea.toString()}");
                                if (pf.value.subArea == sa) {
                                  print("SA IF MATCH : $sa");

                                  print(pf.value.subArea);
                                  pf.value.subArea = '';
                                } else {
                                  print("SA ELSE DONOT MATCH : $sa");
                                  pf.value.subArea = sa;
                                  catp.isProfileSearchEyes.value = false;
                                  catp.isProfileSearchLips.value = false;
                                  catp.isProfileSearchCheek.value = false;
                                }

                                // if (pf.value.subArea == sa) {
                                //   print("SA if $catp.isProfileSearchEyes.value");
                                //   catp.selectEyesColor.value = '';
                                //   if (catp.isProfileSearchEyes.value = false) {
                                //     catp.isProfileSearchEyes.value = true;
                                //   } else if (catp.isProfileSearchEyes.value =
                                //       true) {
                                //     catp.isProfileSearchEyes.value = false;
                                //   }
                                //   pf.value.subArea = '';
                                // } else {
                                //   catp.selectEyesColor.value = sa;
                                //   print(
                                //       "SA else ${catp.isProfileSearchEyes.value.toString()}");
                                //   if (catp.isProfileSearchEyes.value = false) {
                                //     catp.isProfileSearchEyes.value = true;
                                //   } else if (catp.isProfileSearchEyes.value =
                                //       true) {
                                //     catp.isProfileSearchEyes.value = false;
                                //   }
                                //   pf.value.subArea = sa;
                                // }
                                pf.refresh();
                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : null;
                              },
                            ),
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Obx(() {
                return CapsuleButton(
                  backgroundColor: getSearchBGColor(),
                  horizontalPadding: 0,
                  borderColor: Colors.white38,
                  height: size.height * 0.05,
                  width: size.width * 0.75,
                  child: Text(
                    'SEARCH BASED ON YOUR ANALYSIS',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: size.height * 0.013,
                          color: getSearchColor(),
                        ),
                  ),
                  onPress: () {
                    // added by kruti some changes are made in existing code to solve erorr for  selection
                    Rx<BrandFilter> pf = BrandFilter().obs;
                    if (catp.faceArea.value == FaceArea.ALL) {
                      pf = catp.allBrandFilter;
                    } else if (catp.faceArea.value == FaceArea.CHEEKS) {
                      pf = catp.cheeksBrandFilter;
                    } else if (catp.faceArea.value == FaceArea.LIPS) {
                      pf = catp.lipsBrandFilter;
                    } else if (catp.faceArea.value == FaceArea.EYES) {
                      pf = catp.eyesBrandFilter;
                    }
                    if (catp.faceArea.value == FaceArea.ALL) {
                    } else if (catp.faceArea.value == FaceArea.EYES) {
                      if (catp.isProfileSearchEyes.value) {
                        catp.isProfileSearchEyes.value = false;
                        pf.value.subArea = '';
                      } else {
                        catp.isProfileSearchEyes.value = true;
                        catp.selectEyesColor.value = "";
                        catp.selectHairColor.value = "";
                        pf.value.subArea = '';
                      }
                    } else if (catp.faceArea.value == FaceArea.LIPS) {
                      if (catp.isProfileSearchLips.value) {
                        catp.isProfileSearchLips.value = false;
                        pf.value.subArea = '';
                      } else {
                        catp.isProfileSearchLips.value = true;
                        catp.selectLipsShadeID.value = "";
                        pf.value.subArea = '';
                      }
                    } else if (catp.faceArea.value == FaceArea.CHEEKS) {
                      if (catp.isProfileSearchCheek.value) {
                        catp.isProfileSearchCheek.value = false;
                        pf.value.subArea = '';
                      } else {
                        catp.isProfileSearchCheek.value = true;
                        catp.selectCHeekShadeID.value = "";
                        pf.value.subArea = '';
                      }
                    }
                    pf.refresh();
                  },
                );
              }),
              SizedBox(height: size.height * 0.02),
              Obx(
                () {
                  Rx<BrandFilter> pf = BrandFilter().obs;
                  if (catp.faceArea.value == FaceArea.ALL) {
                    pf = catp.allBrandFilter;
                  } else if (catp.faceArea.value == FaceArea.CHEEKS) {
                    pf = catp.cheeksBrandFilter;

                    return Container(
                      constraints: BoxConstraints(
                        minWidth: size.width,
                        maxHeight: size.height * 0.35,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...catp.availableCheeksColor.map(
                            (b) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  height: 30.0,
                                  child: InkWell(
                                    onTap: () {
                                      catp.selectCHeekShadeID.value =
                                          b.toString();
                                      catp.isProfileSearchCheek.value = false;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(int.parse(
                                                        b
                                                            .toString()
                                                            .substring(1, 7),
                                                        radix: 16) +
                                                    0xFF000000),
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            width: 30.0,
                                            height: 30.0,
                                          ),
                                          catp.selectCHeekShadeID.value == b
                                              ? Container(
                                                  child: Image.asset(
                                                      "assets/images/checked.png",
                                                      height: 10.0),
                                                  margin: EdgeInsets.only(
                                                      left: 16.0),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList()
                        ],
                      ),
                    );
                  } else if (catp.faceArea.value == FaceArea.LIPS) {
                    pf = catp.lipsBrandFilter;

                    return Container(
                      constraints: BoxConstraints(
                        minWidth: size.width,
                        maxHeight: size.height * 0.35,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...catp.availableLipsColor.map(
                            (b) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  height: 30.0,
                                  child: InkWell(
                                    onTap: () {
                                      catp.selectLipsShadeID.value =
                                          b.toString();
                                      catp.isProfileSearchLips.value = false;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(int.parse(
                                                        b
                                                            .toString()
                                                            .substring(1, 7),
                                                        radix: 16) +
                                                    0xFF000000),
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            width: 30.0,
                                            height: 30.0,
                                          ),
                                          catp.selectLipsShadeID.value == b
                                              ? Container(
                                                  child: Image.asset(
                                                      "assets/images/checked.png",
                                                      height: 10.0),
                                                  margin: EdgeInsets.only(
                                                      left: 16.0),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList()
                        ],
                      ),
                    );
                  } else if (catp.faceArea.value == FaceArea.EYES) {
                    pf = catp.eyesBrandFilter;
                    return Container(
                      constraints: BoxConstraints(
                        minWidth: size.width,
                        maxHeight: size.height * 0.52,
                      ),
                      // height: size.height * 0.2,
                      child: Column(
                        children: [
                          Text("Eye Colour",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                    fontSize: size.height * 0.012,
                                    color: Colors.white,
                                  )),
                          SizedBox(height: size.height * 0.02),
                          SingleChildScrollView(
                            child: Wrap(
                              runSpacing: size.height * 0.014,
                              children: [
                                ...catp.availableEyeColor.map(
                                  (b) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.01),
                                      child: CapsuleButton(
                                        horizontalPadding: 0,
                                        borderColor: Colors.white38,
                                        backgroundColor:
                                            catp.selectEyesColor.value == b
                                                ? Colors.white
                                                : Colors.black,
                                        width: size.width * 0.3,
                                        height: size.height * 0.05,
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          child: Text(
                                            '$b',
                                            // overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                  fontSize: size.height * 0.012,
                                                  color: catp.selectEyesColor
                                                              .value ==
                                                          b
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                          ),
                                        ),
                                        onPress: () {
                                          if (catp.selectEyesColor.value == b) {
                                            catp.selectEyesColor.value = '';
                                          } else {
                                            catp.selectEyesColor.value = b;
                                            catp.isProfileSearchEyes.value =
                                                false;
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ).toList(),
                              ],
                            ),
                          ),
                          Text("Hair Colour",
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                    fontSize: size.height * 0.012,
                                    color: Colors.white,
                                  )),
                          SizedBox(height: size.height * 0.02),
                          SingleChildScrollView(
                            child: Wrap(
                              runSpacing: size.height * 0.014,
                              children: [
                                ...catp.availableHairColor.map(
                                  (b) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.01),
                                      child: CapsuleButton(
                                        horizontalPadding: 0,
                                        borderColor: Colors.white38,
                                        backgroundColor:
                                            catp.selectHairColor.value == b
                                                ? Colors.white
                                                : Colors.black,
                                        width: size.width * 0.3,
                                        height: size.height * 0.05,
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          child: Text(
                                            '$b',
                                            // overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                  fontSize: size.height * 0.012,
                                                  color: catp.selectHairColor
                                                              .value ==
                                                          b
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                          ),
                                        ),
                                        onPress: () {
                                          if (catp.selectHairColor.value == b) {
                                            catp.selectHairColor.value = '';
                                          } else {
                                            catp.selectHairColor.value = b;
                                            catp.isProfileSearchEyes.value =
                                                false;
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container(
                    constraints: BoxConstraints(
                      minWidth: size.width,
                      maxHeight: size.height * 0.52,
                    ),
                    // height: size.height * 0.2,
                    child: Column(
                      children: [
                        Text("Eye Colour",
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontSize: size.height * 0.012,
                                      color: Colors.white,
                                    )),
                        SizedBox(height: size.height * 0.02),
                        SingleChildScrollView(
                          child: Wrap(
                            runSpacing: size.height * 0.014,
                            children: [
                              ...catp.availableEyeColor.map(
                                (b) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.01),
                                    child: CapsuleButton(
                                      horizontalPadding: 0,
                                      borderColor: Colors.white38,
                                      backgroundColor: pf.value.brand == b
                                          ? Colors.white
                                          : Colors.black,
                                      width: size.width * 0.3,
                                      height: size.height * 0.05,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          '$b',
                                          // overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                fontSize: size.height * 0.012,
                                                color: pf.value.brand == b
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                        ),
                                      ),
                                      onPress: () {
                                        if (pf.value.brand == b) {
                                          pf.value.brand = '';
                                        } else {
                                          pf.value.brand = b;
                                        }
                                        pf.refresh();
                                      },
                                    ),
                                  );
                                },
                              ).toList(),
                            ],
                          ),
                        ),
                        Text("Hair Colour",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontSize: size.height * 0.012,
                                      color: Colors.white,
                                    )),
                        SizedBox(height: size.height * 0.02),
                        SingleChildScrollView(
                          child: Wrap(
                            runSpacing: size.height * 0.014,
                            children: [
                              ...catp.availableHairColor.map(
                                (b) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.01),
                                    child: CapsuleButton(
                                      horizontalPadding: 0,
                                      borderColor: Colors.white38,
                                      backgroundColor: pf.value.brand == b
                                          ? Colors.white
                                          : Colors.black,
                                      width: size.width * 0.3,
                                      height: size.height * 0.05,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          '$b',
                                          // overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                fontSize: size.height * 0.012,
                                                color: pf.value.brand == b
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                        ),
                                      ),
                                      onPress: () {
                                        if (pf.value.brand == b) {
                                          pf.value.brand = '';
                                        } else {
                                          pf.value.brand = b;
                                        }
                                        pf.refresh();
                                      },
                                    ),
                                  );
                                },
                              ).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getSearchColor() {
    if (catp.faceArea.value == FaceArea.EYES) {
      if (catp.isProfileSearchEyes.value) {
        return Colors.black;
      } else {
        return Colors.white;
      }
    } else if (catp.faceArea.value == FaceArea.LIPS) {
      if (catp.isProfileSearchLips.value) {
        return Colors.black;
      } else {
        return Colors.white;
      }
    } else if (catp.faceArea.value == FaceArea.CHEEKS) {
      if (catp.isProfileSearchCheek.value) {
        return Colors.black;
      } else {
        return Colors.white;
      }
    } else {
      return Colors.white;
    }
  }

  Color getSearchBGColor() {
    if (catp.faceArea.value == FaceArea.EYES) {
      if (catp.isProfileSearchEyes.value) {
        return Colors.white;
      } else {
        return Colors.transparent;
      }
    } else if (catp.faceArea.value == FaceArea.LIPS) {
      if (catp.isProfileSearchLips.value) {
        return Colors.white;
      } else {
        return Colors.transparent;
      }
    } else if (catp.faceArea.value == FaceArea.CHEEKS) {
      if (catp.isProfileSearchCheek.value) {
        return Colors.white;
      } else {
        return Colors.transparent;
      }
    } else {
      return Colors.transparent;
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
}
