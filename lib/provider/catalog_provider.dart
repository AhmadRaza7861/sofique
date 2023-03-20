// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofiqe/model/data_ready_status_enum.dart';
import 'package:sofiqe/model/product_model.dart';
import 'package:sofiqe/utils/api/catalog_filters.dart';
import 'package:sofiqe/utils/api/product_list_api.dart';
import 'package:sofiqe/utils/states/user_account_data.dart';

import '../controller/controllers.dart';
import '../controller/questionController.dart';
import '../model/CategoryResponse.dart';
import '../model/make_over_question_model.dart';
import '../model/question_model.dart';

class CatalogProvider extends GetxController {
  RxBool showSearchBar = false.obs;
  var isplaying = true.obs;
  var sku = "".obs;
  var isChangeButtonColor = false.obs;
  Color ontapColor = Colors.grey;
  RxList<Product> catalogItemsList = <Product>[].obs;
  RxInt catalogItemsCurrentPage = 0.obs;

  Rx<FilterType> filterType = FilterType.NONE.obs;
  Rx<FilterType> filterTypePressed = FilterType.NONE.obs;
  Rx<FaceArea> faceArea = FaceArea.ALL.obs;

  Rx<DataReadyStatus> catalogItemsStatus = DataReadyStatus.FETCHING.obs;

  Rx<PriceFilter> priceFilter = PriceFilter().obs;

  Rx<BrandFilter> allBrandFilter = BrandFilter().obs;
  Rx<BrandFilter> eyesBrandFilter = BrandFilter().obs;
  Rx<BrandFilter> lipsBrandFilter = BrandFilter().obs;
  Rx<BrandFilter> cheeksBrandFilter = BrandFilter().obs;

  Rx<ProductFilter> allProductFilter = ProductFilter().obs;
  Rx<ChildrenData> categoryFilter = ChildrenData().obs;
  Rx<ProductFilter> eyesProductFilter = ProductFilter().obs;
  Rx<ProductFilter> lipsProductFilter = ProductFilter().obs;
  Rx<ProductFilter> cheeksProductFilter = ProductFilter().obs;

  Rx<SkinToneFilter> eyesSkinToneFilter = SkinToneFilter().obs;
  Rx<SkinToneFilter> lipsSkinToneFilter = SkinToneFilter().obs;
  Rx<SkinToneFilter> cheeksSkinToneFilter = SkinToneFilter().obs;

  Rx<bool> showSubFilters = false.obs;

  Rx<String> inputText = ''.obs;

  List<Result>? question;
  List<MakeOverQuestion> makeover = [];

  var selectedStar = 10.obs;

  var starValueChanges = false.obs;
  var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
  String currencySymbol = "";

  var availableStar = [
    "5 Star",
    "4 Star",
    "3 Star"
  ]; // update rate list as per mention. now user can filter only 5,4,3 star products
  var availableCheeksColor = [
    "#8d5524",
    "#c68642",
    "#e0ac69",
    "#f1c27d",
    "#ffdbac"
  ];
  var availableLipsColor = [
    "#ae5654",
    "#bd6460",
    "#c2726b",
    "#d2827b",
    "#dc8d88",
    "#e1a6a2"
  ];

  final QuestionsController qc = Get.put(QuestionsController());
  var availableSkinTOnes = [];
  var availableEyeColor = [];
  var availableHairColor = [];

  var isProfileSearchEyes = false.obs;
  var isProfileSearchLips = false.obs;
  var isProfileSearchCheek = false.obs;
  var selectedSkinTone = 10.obs;
  var slinTOneValueChanges = false.obs;

  var selectCHeekShadeID = "".obs;
  var selectLipsShadeID = "".obs;

  var selectEyesColor = "".obs;
  var selectHairColor = "".obs;

  Map<FaceArea, int> faceAreaToIdMapping = {
    FaceArea.EYES: 279,
    FaceArea.LIPS: 280,
    FaceArea.CHEEKS: 278,
    FaceArea.ALL: -1,
  };

  // late Map brandFaceArea;

  // Constructor
  CatalogProvider() {
    _initializedData();
    currencySymbol = format.currencySymbol;
  }
  setShowSubFilters(bool value) => showSubFilters.value = value;
  callOtherMethods() async {}

  _initializedData() async {
    this.defaults();
    await this.fetchUnfilteredItems(false);
    await this.fetchCategory();
    await this
        .fetchBrandNames(faceAreaToStringMapping[FaceArea.EYES] as String);
    await this
        .fetchBrandNames(faceAreaToStringMapping[FaceArea.LIPS] as String);
    await this
        .fetchBrandNames(faceAreaToStringMapping[FaceArea.CHEEKS] as String);

    print("Inside Question Cntroller");

    print(questionsController.skinToneQuestion?.questions.toString());
    var naswers = questionsController.skinToneQuestion?.answers;
    (naswers as Map<String, dynamic>).forEach((key2, value2) {
      // print(key2);
      // print(value2);
      availableSkinTOnes.add(value2);
    });

    var eyeColor = questionsController.eyeQuestion?.answers;
    (eyeColor as Map<String, dynamic>).forEach((key2, value2) {
      // print(key2);
      // print(value2);
      availableEyeColor.add(value2);
    });

    var hairColor = questionsController.hairQuestion?.answers;
    (hairColor as Map<String, dynamic>).forEach((key2, value2) {
      // print(key2);
      // print(value2);
      availableHairColor.add(value2);
    });

    print(availableSkinTOnes.length);

    //await this.getAnaliticalQuestions();
  }

  void playSound() {
    if (isplaying.isTrue) {
      AudioPlayer().play(AssetSource('audio/onclick_sound.mp3'));
    }
  }

  Future<void> fetchCategory() async {
    try {
      CategoryResponse responseList = await sfAPIFetchFaceCategory();
      log('=== response from catFilter :: ${responseList.childrenData!.length} ===');
      if (responseList.childrenData != null &&
          responseList.childrenData!.isNotEmpty &&
          responseList.childrenData!.firstWhere(
                  (element) =>
                      element.name != null &&
                      element.name!.toLowerCase() == "shop", orElse: () {
                return ChildrenData();
              }).name ==
              null) {
        throw 'Proper key not found in response';
      }
      List<ChildrenData> faceSubAreaAndParameter = responseList.childrenData!
          .firstWhere(
              (element) =>
                  element.name != null &&
                  element.name!.toLowerCase() == "shop" &&
                  element.childrenData != null,
              orElse: () => ChildrenData())
          .childrenData!;
      categoryFilter.value = responseList.childrenData!.firstWhere(
          (element) =>
              element.name != null &&
              element.name!.toLowerCase() == "shop" &&
              element.childrenData != null,
          orElse: () => ChildrenData());
      faceSubAreaAndParameter.forEach((element) {
        if (element.name != null &&
            element.name!.toLowerCase() == "complexion") {
          allProductFilter.value.subAreas.addAll(element.childrenData!);
          cheeksProductFilter.value.subAreas.addAll(element.childrenData!);
        } else if (element.name != null &&
            element.name!.toLowerCase() == "eyes") {
          allProductFilter.value.subAreas.addAll(element.childrenData!);
          eyesProductFilter.value.subAreas.addAll(element.childrenData!);
        } else if (element.name != null &&
            element.name!.toLowerCase() == "lips") {
          allProductFilter.value.subAreas.addAll(element.childrenData!);
          lipsProductFilter.value.subAreas.addAll(element.childrenData!);
        }
      });
    } catch (err) {
      print('Could not get face areas and parameters: $err');
    }
  }

  // Methods

  void unhideSeachBar() {
    this.showSearchBar.value = true;
  }

  void hideSearchBar() {
    this.showSearchBar.value = false;
  }

  void setFaceArea(FaceArea fa) {
    faceArea.value = fa;
    filterTypePressed.value = FilterType.NONE;
    catalogItemsCurrentPage.value = 0;
    selectedStar.value = 10;
    starValueChanges.value = false;
    setFilter(FilterType.NONE, newFilter: true);
  }

  void setFilter(FilterType ft, {bool newFilter = false}) async {
    if (!newFilter) {
      if (filterTypePressed.value != ft) {
        filterTypePressed.value = ft;
        print("filter type is === ${filterTypePressed.value} ====");
        print("object;;;;;;;;");
      } else {
        filterTypePressed.value = FilterType.NONE;
      }
      // added by kruti to remove unwanted faceAreas statically
      print("filter type pressed ::${filterTypePressed.value}");
      if (filterTypePressed.value == FilterType.SKINTONE) {
        if (faceArea.value == FaceArea.EYES) {
          BrandFilter stf = BrandFilter();
          stf = eyesBrandFilter.value;
          if (stf.subAreas.length > 0) {
            if (!stf.subAreas.contains("Eyelid")) {
              stf.subAreas.add("Eyelid");
            }
            if (!stf.subAreas.contains("Eyesocket")) {
              stf.subAreas.add("Eyesocket");
            }
            if (!stf.subAreas.contains("Orbitalbone")) {
              stf.subAreas.add("Orbitalbone");
            }
            stf.subAreas =
                stf.subAreas.where((item) => item != "Eyeshadow").toList();
            stf.subAreas =
                stf.subAreas.where((item) => item != "Eye Shadow").toList();
            stf.subAreas =
                stf.subAreas.where((item) => item != "Eyeliners").toList();
            stf.subAreas =
                stf.subAreas.where((item) => item != "Brows").toList();
            eyesBrandFilter.value = stf;
          }
        } else if (faceArea.value == FaceArea.LIPS) {
          BrandFilter stf = BrandFilter();
          stf = lipsBrandFilter.value;
          if (stf.subAreas.length > 0) {
            stf.subAreas =
                stf.subAreas.where((item) => item != "Shop All Lips").toList();
          }
          lipsBrandFilter.value = stf;
        }
      }
      if (filterTypePressed.value == FilterType.BRAND) {
        if (faceArea.value == FaceArea.EYES) {
          try {
            BrandFilter stf = BrandFilter();
            stf = eyesBrandFilter.value;
            if (stf.subAreas.length > 0) {
              stf.subAreas =
                  stf.subAreas.where((item) => item != "Eyelid").toList();
              stf.subAreas =
                  stf.subAreas.where((item) => item != "Eyesocket").toList();
              stf.subAreas =
                  stf.subAreas.where((item) => item != "Orbitalbone").toList();
              stf.subAreas =
                  stf.subAreas.where((item) => item != "Orbitalbone").toList();
              stf.subAreas =
                  stf.subAreas.where((item) => item != "Eyeliners").toList();
              if (!stf.subAreas.contains("Eye Shadow")) {
                stf.subAreas.add("Eye Shadow");
              }
              eyesBrandFilter.value = stf;
            }
          } catch (e) {
            print(e.toString());
          }
        }
      }
      if (filterTypePressed.value == FilterType.PRODUCT) {
        if (faceArea.value == FaceArea.EYES) {
          try {
            ProductFilter stf = ProductFilter();
            stf = eyesProductFilter.value;
            if (stf.subAreas.length > 0) {
              stf.subAreas = stf.subAreas
                  .where((item) => item.name != "Eyeshadow")
                  .toList();
            }
            eyesProductFilter.value = stf;
          } catch (e) {
            print(e.toString());
          }
        }
      }
      eyesBrandFilter.refresh();
    }
    if ((ft == filterType.value) && !newFilter) {
      return;
    }
    if (ft != filterType.value) {
      filterType.value = ft;
    }
    // bool isChanged = false;
    switch (ft) {
      /*case FilterType.SKINTONE:
        SkinToneFilter stf = SkinToneFilter();
        if (faceArea.value == FaceArea.EYES) {
          stf = eyesSkinToneFilter.value;
        } else if (faceArea.value == FaceArea.CHEEKS) {
          stf = cheeksSkinToneFilter.value;
        } else if (faceArea.value == FaceArea.LIPS) {
          stf = lipsSkinToneFilter.value;
        }
        if (stf.changed) {
          catalogItemsList.removeWhere((element) => true);
          catalogItemsCurrentPage.value = 0;
          stf.readFilter();
          catalogItemsStatus.value = DataReadyStatus.FETCHING;
          await fetchCentralColorProducts(stf);
        }
        break;*/

      case FilterType.SKINTONE:
        BrandFilter stf = BrandFilter();
        if (faceArea.value == FaceArea.EYES) {
          stf = eyesBrandFilter.value;
          if (stf._subArea.toString() != "") {
            if (isProfileSearchEyes.value == true) {
              await fetchSKinToneProfileFilter(
                  stf._subArea, isProfileSearchEyes.value);
            } else if (selectHairColor.value != "" &&
                selectEyesColor.value != "") {
              catalogItemsList.removeWhere((element) => true);
              catalogItemsCurrentPage.value = 0;
              catalogItemsStatus.value = DataReadyStatus.FETCHING;
              String lipColor = "#000000";
              String cheekColor = "#ffccaa";
              await fetchSKinToneFilter(stf._subArea, selectEyesColor.value,
                  selectHairColor.value, lipColor, cheekColor);
            } else {
              if (newFilter) {
                Get.showSnackbar(
                  GetSnackBar(
                    message: 'Please select hair and eye colour',
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          } else {
            if (newFilter) {
              Get.showSnackbar(
                GetSnackBar(
                  message: 'Please select face area',
                  duration: Duration(seconds: 2),
                ),
              );
            }
          }
        } else if (faceArea.value == FaceArea.CHEEKS) {
          stf = cheeksBrandFilter.value;

          if (stf._subArea.toString() != "") {
            if (isProfileSearchCheek.value == true) {
              await fetchSKinToneProfileFilter(
                  stf._subArea, isProfileSearchCheek.value);
            } else if (selectCHeekShadeID.value != "") {
              catalogItemsList.removeWhere((element) => true);
              catalogItemsCurrentPage.value = 0;
              if (stf._subArea.toString() == 'Concealer' ||
                  stf._subArea.toString() == "Foundation") {
                catalogItemsStatus.value = DataReadyStatus.FETCHING;
                await fetchCentralColorProductsFunction(
                    selectCHeekShadeID.value, stf._subArea.toString());
              } else {
                catalogItemsList.removeWhere((element) => true);
                catalogItemsCurrentPage.value = 0;
                catalogItemsStatus.value = DataReadyStatus.FETCHING;
                String eyeColor = "";
                String hairColor = "";
                String lipColor = "";
                String cheekColor = selectCHeekShadeID.value;
                String faceSelectedAreaForCheek = stf._subArea.toString();
                await fetchSKinToneFilter(faceSelectedAreaForCheek, eyeColor,
                    hairColor, lipColor, cheekColor);
              }
            } else {
              if (newFilter) {
                Get.showSnackbar(
                  GetSnackBar(
                    message: 'Please select shade colour',
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          } else {
            if (newFilter) {
              Get.showSnackbar(
                GetSnackBar(
                  message: 'Please select face area',
                  duration: Duration(seconds: 2),
                ),
              );
            }
          }
        } else if (faceArea.value == FaceArea.LIPS) {
          stf = lipsBrandFilter.value;
          if (stf._subArea.toString() != "") {
            if (isProfileSearchLips.value == true) {
              await fetchSKinToneProfileFilter(
                  stf._subArea, isProfileSearchLips.value);
            } else if (selectLipsShadeID.value != "") {
              catalogItemsList.removeWhere((element) => true);
              catalogItemsCurrentPage.value = 0;
              catalogItemsStatus.value = DataReadyStatus.FETCHING;
              String eyeColor = "pink";
              String hairColor = "brown";

              String cheekColor = "#ffccaa";
              await fetchSKinToneFilter(stf._subArea, eyeColor, hairColor,
                  selectLipsShadeID.value, cheekColor);
            } else {
              if (newFilter) {
                Get.showSnackbar(
                  GetSnackBar(
                    message: 'Please select shade colour',
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          } else {
            if (newFilter) {
              Get.showSnackbar(
                GetSnackBar(
                  message: 'Please select face area',
                  duration: Duration(seconds: 2),
                ),
              );
            }
          }
        }

        break;

      case FilterType.PRODUCT:
        ProductFilter pf = ProductFilter();
        if (faceArea.value == FaceArea.ALL) {
          pf = allProductFilter.value;
        } else if (faceArea.value == FaceArea.EYES) {
          pf = eyesProductFilter.value;
        } else if (faceArea.value == FaceArea.CHEEKS) {
          pf = cheeksProductFilter.value;
        } else if (faceArea.value == FaceArea.LIPS) {
          pf = lipsProductFilter.value;
        }
        if (pf.changed) {
          catalogItemsList.removeWhere((element) => true);
          catalogItemsCurrentPage.value = 0;
          pf.readFilter();
          catalogItemsStatus.value = DataReadyStatus.FETCHING;
          await fetchProductItems(pf);
        } else {
          if (newFilter) {
            Get.showSnackbar(
              GetSnackBar(
                message: 'Please select face area',
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
        break;
      case FilterType.PRICE:
        if (true) {
          print('==== running with 1 ===');
          // if (priceFilter.value.changed) {
          catalogItemsList.removeWhere((element) => true);
          catalogItemsCurrentPage.value = 0;
          this.priceFilter.value.readFilter();
          print('==== running with 2 ===');
          catalogItemsStatus.value = DataReadyStatus.FETCHING;
          String selectedFaceArea = "";
          print('==== running with 3 ===');
          if (faceArea.value == FaceArea.EYES) {
            selectedFaceArea = "eyes";
          } else if (faceArea.value == FaceArea.LIPS) {
            selectedFaceArea = "lips";
          } else if (faceArea.value == FaceArea.CHEEKS) {
            selectedFaceArea = "cheeks";
          }
          print(
              '==== running 4 with selected face area :: ${selectedFaceArea} ===');
          await fetchBetweenPriceItems(selectedFaceArea);
        }
        break;
      case FilterType.BRAND:
        BrandFilter pf = BrandFilter();
        if (faceArea.value == FaceArea.ALL) {
          pf = allBrandFilter.value;
        } else if (faceArea.value == FaceArea.EYES) {
          pf = eyesBrandFilter.value;
        } else if (faceArea.value == FaceArea.CHEEKS) {
          pf = cheeksBrandFilter.value;
        } else if (faceArea.value == FaceArea.LIPS) {
          pf = lipsBrandFilter.value;
        }

        if (pf._subArea != "" && pf._brand != "") {
          if (pf.changed) {
            catalogItemsList.removeWhere((element) => true);
            catalogItemsCurrentPage.value = 0;
            pf.readFilter();
            catalogItemsStatus.value = DataReadyStatus.FETCHING;
            await fetchBrandItems(pf);
          }
        } else {
          if (newFilter) {
            Get.showSnackbar(
              GetSnackBar(
                message: 'Please select face area and brand',
                duration: Duration(seconds: 2),
              ),
            );
          }
        }

        break;
      case FilterType.REVIEW:
        if (starValueChanges.value) {
          print('aaaaaaaaaaa');
          catalogItemsList.removeWhere((element) => true);
          print('bbbbbbb');
          catalogItemsCurrentPage.value = 0;
          print("cccccc");
          catalogItemsStatus.value = DataReadyStatus.FETCHING;
          print("dddddddddd");
          await fetchRatedItems();
          print("fffffffffff");
        } else {
          if (newFilter) {
            Get.showSnackbar(
              GetSnackBar(
                message: 'Please select review',
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
        break;
      case FilterType.POPULAR:
        catalogItemsList.removeWhere((element) => true);
        catalogItemsCurrentPage.value = 0;
        catalogItemsStatus.value = DataReadyStatus.FETCHING;
        await fetchPopularItems();
        break;
      case FilterType.NONE:
        catalogItemsList.removeWhere((element) => true);
        catalogItemsStatus.value = DataReadyStatus.FETCHING;
        if (faceArea.value == FaceArea.ALL) {
          await fetchUnfilteredItems(false);
        } else {
          await fetchUnfilteredFaceArea(
              faceAreaToIdMapping[faceArea.value] as int, false);
        }
        break;
    }
  }

  Future<bool> fetchMoreItems() async {
    bool success = false;

    switch (filterType.value) {
      case FilterType.SKINTONE:
        // SkinToneFilter stf = SkinToneFilter();
        // if (faceArea.value == FaceArea.EYES) {
        //   stf = eyesSkinToneFilter.value;
        // } else if (faceArea.value == FaceArea.CHEEKS) {
        //   stf = cheeksSkinToneFilter.value;
        // } else if (faceArea.value == FaceArea.LIPS) {
        //   stf = lipsSkinToneFilter.value;
        // }
        // success = await fetchCentralColorProducts(stf);
        ///
        ///
        /// All products are fetched in continious succession so no need to call this API again
        ///
        ///
        success = true;
        break;
      case FilterType.PRODUCT:
        ProductFilter pf = ProductFilter();
        if (faceArea.value == FaceArea.ALL) {
          pf = allProductFilter.value;
        } else if (faceArea.value == FaceArea.EYES) {
          pf = eyesProductFilter.value;
        } else if (faceArea.value == FaceArea.CHEEKS) {
          pf = cheeksProductFilter.value;
        } else if (faceArea.value == FaceArea.LIPS) {
          pf = lipsProductFilter.value;
        }
        success = await fetchProductItems(pf);
        break;
      case FilterType.PRICE:
        success = await fetchBetweenPriceItems("");
        break;
      case FilterType.BRAND:
        BrandFilter pf = BrandFilter();
        if (faceArea.value == FaceArea.ALL) {
          pf = allBrandFilter.value;
        } else if (faceArea.value == FaceArea.EYES) {
          pf = eyesBrandFilter.value;
        } else if (faceArea.value == FaceArea.CHEEKS) {
          pf = cheeksBrandFilter.value;
        } else if (faceArea.value == FaceArea.LIPS) {
          pf = lipsBrandFilter.value;
        }
        success = await fetchBrandItems(pf);
        break;
      case FilterType.REVIEW:
        success = true;
        break;
      case FilterType.POPULAR:
        success = await fetchPopularItems();
        break;
      case FilterType.NONE:
        switch (faceArea.value) {
          case FaceArea.ALL:
            success = await fetchUnfilteredItems(false);
            break;
          case FaceArea.EYES:
          case FaceArea.LIPS:
          case FaceArea.CHEEKS:
            success = await fetchUnfilteredFaceArea(
                faceAreaToIdMapping[faceArea.value] as int, false);
            break;
        }
        break;
    }
    return success;
  }

  void applyFilter() {
    filterTypePressed.value = FilterType.NONE;
    setFilter(this.filterType.value, newFilter: true);
  }

  void search() {
    this.filterType.value = FilterType.NONE;
    this.filterTypePressed.value = FilterType.NONE;
    selectedStar.value = 10;
    starValueChanges.value = false;
    this.hideSearchBar();
    this.fetchSearchedItems();
  }

  // SkinTone API

  Future<bool> fetchSKinToneFilter(String faceArea, String eyeColor,
      String hairColor, String lipcolor, String cheekColor) async {
    print("CALLED CALLED");
    String token = await getUserToken();
    print(token);
    try {
      catalogItemsCurrentPage.value++;

      Map result = await sfAPIGetSkinToneItems(
          faceArea, eyeColor, hairColor, lipcolor, cheekColor, token);
      print("result retunrnrnrn");
      print(result);
      if (!result.containsKey('items')) {
        throw 'Key not found: items';
      }
      List itemsList = result['items'];
      print("${itemsList.length} djj");

      List<Product> tempProductList = <Product>[];
      itemsList.forEach(
        (item) {
          tempProductList.add(Product.fromDefaultMap(item));
        },
      );

      catalogItemsList.addAll(tempProductList);

      print("Kamlesh");
      print(catalogItemsList.length);
      print(selectedStar.value);
      catalogItemsStatus.value = DataReadyStatus.COMPLETED;
      return true;
    } catch (err) {
      print("Kamlesh----");
      print(err);
      catalogItemsCurrentPage.value--;
      catalogItemsStatus.value = DataReadyStatus.ERROR;
      print(err);
      try {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Could not load more products',
            duration: Duration(seconds: 2),
          ),
        );
      } catch (ee) {}
      return false;
    }
  }

  Future<bool> fetchSKinToneProfileFilter(
      String faceArea, bool isProfileSearch) async {
    try {
      this.catalogItemsStatus.value = DataReadyStatus.FETCHING;
      this.catalogItemsList.removeWhere((element) => true);

      catalogItemsCurrentPage.value++;

      Map result =
          await sfAPIGetSkinToneProfileItems(faceArea, isProfileSearch);

      if (!result.containsKey('items')) {
        throw 'Key not found: items';
      }
      List itemsList = result['items'];
      print(itemsList.length);

      List<Product> tempProductList = <Product>[];
      itemsList.forEach(
        (item) {
          tempProductList.add(Product.fromDefaultMap(item));
        },
      );

      catalogItemsList.addAll(tempProductList);

      print("Kamlesh");
      print(catalogItemsList.length);
      print(selectedStar.value);
      catalogItemsStatus.value = DataReadyStatus.COMPLETED;
      return true;
    } catch (err) {
      print("Kamlesh");
      print(err);
      catalogItemsCurrentPage.value--;
      catalogItemsStatus.value = DataReadyStatus.ERROR;
      print(err);
      try {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Could not load more products',
            duration: Duration(seconds: 2),
          ),
        );
      } catch (ee) {}
      return false;
    }
  }

  // API calls
  Future<bool> fetchUnfilteredFaceArea(int faceArea, bool isForReview) async {
    try {
      catalogItemsCurrentPage.value++;
      Map result = await sfAPIGetUnfilteredFaceAreaItems(
          catalogItemsCurrentPage.value, faceArea);
      if (!result.containsKey('items')) {
        throw 'Key not found: items';
      }
      List itemsList = result['items'];
      List<Product> tempProductList = <Product>[];
      itemsList.forEach(
        (item) {
          tempProductList.add(Product.fromDefaultMap(item));
        },
      );

      catalogItemsList.addAll(tempProductList);

      if (isForReview) {
        if (selectedStar.value == 10) {
          // All
          catalogItemsList.sort((a, b) =>
              double.parse(a.avgRating).compareTo(double.parse(b.avgRating)));
        } else if (selectedStar.value == 0) {
          // 4+ rating
          try {
            catalogItemsList
                .removeWhere((element) => (element.avgRating).startsWith('3'));
            catalogItemsList
                .removeWhere((element) => (element.avgRating).startsWith('2'));
            catalogItemsList
                .removeWhere((element) => (element.avgRating).startsWith('1'));
            catalogItemsList
                .removeWhere((element) => (element.avgRating).startsWith('0'));
          } catch (ex) {
            print(ex);
          }
        } else if (selectedStar.value == 1) {
          // 3+ rating
          catalogItemsList
              .removeWhere((element) => (element.avgRating).startsWith('2'));
          catalogItemsList
              .removeWhere((element) => (element.avgRating).startsWith('1'));
          catalogItemsList
              .removeWhere((element) => (element.avgRating).startsWith('0'));
        } else {
          // 2+ Rating
          catalogItemsList
              .removeWhere((element) => (element.avgRating).startsWith('1'));
          catalogItemsList
              .removeWhere((element) => (element.avgRating).startsWith('0'));
        }
      }

      print("catalogItemsList---" + catalogItemsList.length.toString());

      catalogItemsStatus.value = DataReadyStatus.COMPLETED;
      return true;
    } catch (err) {
      print("Kamlesh");
      print(err);
      catalogItemsCurrentPage.value--;
      catalogItemsStatus.value = DataReadyStatus.ERROR;
      print(err);
      try {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Could not load more products',
            duration: Duration(seconds: 2),
          ),
        );
      } catch (ee) {}
      return false;
    }
  }

  Future<bool> fetchUnfilteredItems(bool sortReviewBased) async {
    try {
      catalogItemsCurrentPage.value++;
      Map catalogUnfilteredItemsMap =
          await sfAPIGetCatalogUnfilteredItems(catalogItemsCurrentPage.value);
      if (!catalogUnfilteredItemsMap.containsKey('items')) {
        throw 'Server failed to send catalog list';
      }
      List catalogUnfilteredItemsTempList = catalogUnfilteredItemsMap['items'];
      // Added by kruti for sorting list of catalogItems

      catalogUnfilteredItemsTempList
          .sort((a, b) => a["name"].compareTo(b["name"]));
      List<Product> catalogUnfilteredItemsTempListOfProducts =
          catalogUnfilteredItemsTempList.map<Product>(
        (m) {
          return Product.fromDefaultMap(m);
        },
      ).toList();
      catalogItemsList.addAll(catalogUnfilteredItemsTempListOfProducts);
      if (sortReviewBased) {
        if (selectedStar.value == 10) {
          catalogItemsList.sort((a, b) =>
              double.parse(a.avgRating).compareTo(double.parse(b.avgRating)));
        } else if (selectedStar.value == 0) {
          // 4+ rating
          try {
            var temp = catalogItemsList;
            temp.removeWhere(
                (element) => getReviewList(element.avgRating, '4'));
            /*temp.removeWhere((element) => element.avgRating.startsWith("3"));
            temp.removeWhere((element) => element.avgRating.startsWith("2"));
            temp.removeWhere((element) => element.avgRating.startsWith("1"));
            temp.removeWhere((element) => element.avgRating.startsWith("0"));*/
            catalogItemsList.removeWhere((element) => true);
            catalogItemsList.addAll(temp);
          } catch (ex) {
            print(ex);
          }
        } else if (selectedStar.value == 1) {
          // 3+ rating
          var temp = catalogItemsList;
          temp.removeWhere((element) => getReviewList(element.avgRating, '3'));
          /*temp.removeWhere((element) => element.avgRating.startsWith("2"));
          temp.removeWhere((element) => element.avgRating.startsWith("1"));
          temp.removeWhere((element) => element.avgRating.startsWith("0"));*/
          catalogItemsList.removeWhere((element) => true);
          catalogItemsList.addAll(temp);
        } else {
          // 2+ Rating
          var temp = catalogItemsList;
          temp.removeWhere((element) => getReviewList(element.avgRating, '2'));
          /*temp.removeWhere((element) => element.avgRating.startsWith("1"));
          temp.removeWhere((element) => element.avgRating.startsWith("0"));*/
          catalogItemsList.removeWhere((element) => true);
          catalogItemsList.addAll(temp);
        }
      }

      print("TZS--Raing--" + catalogItemsList.length.toString());
      catalogItemsStatus.value = DataReadyStatus.COMPLETED;
      return true;
    } catch (err) {
      catalogItemsCurrentPage.value--;
      catalogItemsStatus.value = DataReadyStatus.ERROR;
      print(err);
      try {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Could not load more products',
            duration: Duration(seconds: 2),
          ),
        );
      } catch (ee) {
        return false;
      }
      return false;
    }
  }

  /*
  * Function : fetchRatedItems
  * return : product list
  * description : this function will return products as per selected rate(star) filter
  * */

  Future<bool> fetchRatedItems() async {
    try {
      catalogItemsCurrentPage.value++;
      List catalogUnfilteredItemsTempList =
          await fetchItemsByReview(selectedStar.value);
      List<Product> catalogUnfilteredItemsTempListOfProducts =
          catalogUnfilteredItemsTempList.map<Product>(
        (m) {
          return Product(
            id: int.parse(m['product_id']),
            name: m['name'],
            sku: m['sku'],
            price: double.parse(m['original_price']),
            image: m['image'],
            description: m['description'],
            faceSubArea: -1,
            avgRating: m['extension_attributes']['avgrating'].toString(),
            reviewCount: m['extension_attributes']['review_count'].toString(),
            rewardsPoint: m['extension_attributes']['reward_points'].toString(),
            discountedPrice: m['discounted_price'] != null
                ? double.parse(m['discounted_price'].toString())
                : 0,
          );
        },
      ).toList();
      catalogItemsList.addAll(catalogUnfilteredItemsTempListOfProducts);

      print("TZS--Raing--" + catalogItemsList.length.toString());
      catalogItemsStatus.value = DataReadyStatus.COMPLETED;
      return true;
    } catch (err) {
      catalogItemsCurrentPage.value--;
      catalogItemsStatus.value = DataReadyStatus.ERROR;
      print(err);
      try {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Could not load more products',
            duration: Duration(seconds: 2),
          ),
        );
      } catch (ee) {
        return false;
      }
      return false;
    }
  }

  bool getReviewList(String rating, String minRating) {
    print("Average---" + rating.toString());
    double doubleRating = double.parse(rating);
    double doubleMinRating = double.parse(minRating);
    if (doubleRating <= doubleMinRating) {
      return true;
    }
    return false;
  }

  Future<bool> fetchFaceAreasAndParameters(int faceArea) async {
    try {
      List responseList = await sfAPIFetchFaceAreasAndParameters(faceArea);
      Map responseMap = responseList[0];
      if (!responseMap.containsKey('face_sub_area')) {
        throw 'Proper key not found in response';
      }
      List faceSubAreaAndParameter = responseMap['face_sub_area'];

      if (faceArea == faceAreaToIdMapping[FaceArea.CHEEKS]) {
        cheeksSkinToneFilter.value.storeSubAreaOptions(faceSubAreaAndParameter);
      } else if (faceArea == faceAreaToIdMapping[FaceArea.LIPS]) {
        lipsSkinToneFilter.value.storeSubAreaOptions(faceSubAreaAndParameter);
      } else if (faceArea == faceAreaToIdMapping[FaceArea.EYES]) {
        eyesSkinToneFilter.value.storeSubAreaOptions(faceSubAreaAndParameter);
      }
      return true;
    } catch (err) {
      print('Could not get face areas and parameters: $err');
      return false;
    }
  }

  Future<bool> fetchCentralColorProductsFunction(
      String color, String faceSubArea) async {
    try {
      this.catalogItemsCurrentPage.value++;

      /// Find the user token
      String token = await getUserToken();
      // int customer_id = await getCustomerId();

      /// Fetch products for each recommended colors
      /// Add product to catalogListItems List
      List result = await sfAPIFetchCentralColorProductsForFoundation(
        token,
        color,
        faceSubArea,
      );
      dynamic resultMap = result[0];

      if (!resultMap.containsKey('product')) {
        throw 'Key not found: product';
      }

      dynamic tempProductMap = resultMap['product'];
      List<Product> tempProductList = <Product>[];
      tempProductMap.forEach(
        (key, p) {
          tempProductList.add(Product.fromMap(p));
        },
      );
      this.catalogItemsList.addAll(tempProductList);
      this.catalogItemsStatus.value = DataReadyStatus.COMPLETED;
      // this.catalogItemsStatus.value = DataReadyStatus.COMPLETED;
      return true;
    } catch (err) {
      this.catalogItemsStatus.value = DataReadyStatus.ERROR;
      this.catalogItemsCurrentPage.value--;
      print('Error fetching parameterizedFaceSubAreaProducts: $err');
      try {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Could not load more products',
            duration: Duration(seconds: 2),
          ),
        );
      } catch (ee) {}
      return false;
    }
  }

  Future<bool> fetchBrandNames(String faceArea) async {
    print("Fetch Brand Names  --fetchBrandNames :: $faceArea");
    try {
      List result = await sfAPIGetBrandNames(faceArea);
      Map resultMap = result[0];
      if (!resultMap.containsKey('brand') ||
          !resultMap.containsKey('face_sub_area')) {
        throw 'Key not found: brand OR face_sub_area';
      }
      Map resultFaceSubArea = resultMap['face_sub_area'];
      Map resultBrand = resultMap['brand'];
      // brandFaceArea = resultMap['face_sub_area'];
      //  print("brandFaceArea  fetchBrandNames:: ${brandFaceArea}");

      BrandFilter brandFilter = BrandFilter();

      resultFaceSubArea.forEach(
        (index, b) {
          if (b == "Highligther") {
          } else {
            brandFilter.subAreas.add(b);
            //print("subAreas ::${b}");
          }
        },
      );
      resultBrand.forEach(
        (index, b) {
          brandFilter.brands.add(b);
        },
      );

      if (faceArea == faceAreaToStringMapping[FaceArea.ALL]) {
        allBrandFilter.value = brandFilter;
      } else if (faceArea == faceAreaToStringMapping[FaceArea.EYES]) {
        eyesBrandFilter.value = brandFilter;
      }
      else if (faceArea == faceAreaToStringMapping[FaceArea.CHEEKS]) {
        cheeksBrandFilter.value = brandFilter;
      }
      else if (faceArea == faceAreaToStringMapping[FaceArea.LIPS]) {
        lipsBrandFilter.value = brandFilter;
      }
      return true;
    } catch (err) {
      print('Error fetching brand names: $err');
      // This method called again and again...changed on 13-04-2022 by Ashwani
      //fetchBrandNames(faceArea);
      return false;
    }
  }

  Future<bool> fetchFilteredBrandNames(
      String faceArea, String faceSubArea) async {
    print("Fetch Filtered Brand Names  --fetchBrandNames");
    try {
      List result = await sfAPIGetFilteredBrandNames(faceArea, faceSubArea);
      Map resultMap = result[0];
      if (!resultMap.containsKey('brand') ||
          !resultMap.containsKey('face_sub_area')) {
        throw 'Key not found: brand OR face_sub_area';
      }
      //  Map resultFaceSubArea = resultMap['face_sub_area'];
      Map resultBrand = resultMap['brand'];
      //  Map resultFaceSubArea = brandFaceArea;
      //   print("brandFaceArea  fetchFilteredBrandNames:: ${brandFaceArea}");
      BrandFilter brandFilter = BrandFilter();
      if (faceArea == faceAreaToStringMapping[FaceArea.ALL]) {
        List brandFaceArea = allBrandFilter.value.subAreas;
        brandFaceArea.forEach(
          (b) {
            if (b == "Highligther") {
            } else {
              brandFilter.subAreas.add(b);
              if (faceSubArea == b) {
                brandFilter.subArea = b;
              }
            }
          },
        );
      } else if (faceArea == faceAreaToStringMapping[FaceArea.EYES]) {
        List brandFaceArea = eyesBrandFilter.value.subAreas;
        brandFaceArea.forEach(
          (b) {
            if (b == "Highligther") {
            } else {
              brandFilter.subAreas.add(b);
              if (faceSubArea == b) {
                brandFilter.subArea = b;
              }
            }
          },
        );
      } else if (faceArea == faceAreaToStringMapping[FaceArea.CHEEKS]) {
        List brandFaceArea = cheeksBrandFilter.value.subAreas;
        brandFaceArea.forEach(
          (b) {
            if (b == "Highligther") {
            } else {
              brandFilter.subAreas.add(b);
              if (faceSubArea == b) {
                brandFilter.subArea = b;
              }
            }
          },
        );
      } else if (faceArea == faceAreaToStringMapping[FaceArea.LIPS]) {
        List brandFaceArea = lipsBrandFilter.value.subAreas;
        brandFaceArea.forEach(
          (b) {
            if (b == "Highligther") {
            } else {
              brandFilter.subAreas.add(b);
              if (faceSubArea == b) {
                brandFilter.subArea = b;
              }
            }
          },
        );
      }

      resultBrand.forEach(
        (index, b) {
          brandFilter.brands.add(b);
        },
      );

      if (faceArea == faceAreaToStringMapping[FaceArea.ALL]) {
        allBrandFilter.value = brandFilter;
      } else if (faceArea == faceAreaToStringMapping[FaceArea.EYES]) {
        eyesBrandFilter.value = brandFilter;
      } else if (faceArea == faceAreaToStringMapping[FaceArea.CHEEKS]) {
        cheeksBrandFilter.value = brandFilter;
      } else if (faceArea == faceAreaToStringMapping[FaceArea.LIPS]) {
        lipsBrandFilter.value = brandFilter;
      }

      return true;
    } catch (err) {
      print('Error fetching brand names: $err');
      // This method called again and again...changed on 13-04-2022 by Ashwani
      //fetchBrandNames(faceArea);
      return false;
    }
  }

  Future<bool> fetchBrandItems(BrandFilter bf) async {
    try {
      this.catalogItemsCurrentPage.value++;

      List result = await sfAPIFetchBrandFilteredItems(
          this.catalogItemsCurrentPage.value, bf.brand, bf.subArea);
      dynamic resultMap = result[0];
      if (!resultMap.containsKey('products')) {
        throw 'Key not found: products';
      }

      if (resultMap['products'] is List) {
        List<dynamic> tempProductsMap = resultMap['products'];
        List<Product> tempProductList = <Product>[];

        tempProductsMap.forEach(
          (p) {
            tempProductList.add(Product.fromMap(p));
          },
        );
        this.catalogItemsList.addAll(tempProductList);
      } else {
        Map tempProductsMap = resultMap['products'];
        List<Product> tempProductList = <Product>[];

        tempProductsMap.forEach(
          (k, p) {
            tempProductList.add(Product.fromMap(p));
          },
        );
        this.catalogItemsList.addAll(tempProductList);
      }

      this.catalogItemsStatus.value = DataReadyStatus.COMPLETED;
      return true;
    } catch (err) {
      this.catalogItemsCurrentPage.value--;
      this.catalogItemsStatus.value = DataReadyStatus.ERROR;
      print('Error fetching brand filtered items: $err');
      Get.showSnackbar(
        GetSnackBar(
          message: 'Could not fetch products',
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }

  Future<bool> fetchProductItems(ProductFilter pf) async {
    try {
      this.catalogItemsCurrentPage.value++;
      Map result = await sfAPIFetchProductItems(
          this.catalogItemsCurrentPage.value, pf.subArea.id!);
      if (!result.containsKey('items')) {
        throw 'Key not found: items';
      }
      List resultList = result['items'];
      List<Product> tempProductList = <Product>[];

      resultList.forEach(
        (p) {
          tempProductList.add(Product.fromDefaultMap(p));
        },
      );

      this.catalogItemsList.addAll(tempProductList);
      this.catalogItemsStatus.value = DataReadyStatus.COMPLETED;
      return true;
    } catch (err) {
      this.catalogItemsCurrentPage.value--;
      this.catalogItemsStatus.value = DataReadyStatus.ERROR;
      print('Error fetching product filtered items: $err');
      Get.showSnackbar(
        GetSnackBar(
          message: 'Could not fetch products for this filter',
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }

  Future<bool> fetchPopularItems() async {
    try {
      catalogItemsCurrentPage.value++;

      if (faceArea.value == FaceArea.ALL) {
        Map<String, dynamic> bestSellerResponse = await sfAPIGetBestSellers();
        print("Reture result .........");

        var responseList = bestSellerResponse["bestseller_product"];

        List<Product> tempProductList = <Product>[];

        //added by kruti to sort popular items
        // responseList.sort((a, b) => a["name"].compareTo(b["name"]));
        //---facing issue here

        print("Best Seller Items -->> ${responseList[0]["name"]}");
        responseList.forEach((p) {
          // product was not added to the list that's why it was not showing to list of popular products
          tempProductList.add(Product(
              id: int.parse(p['product_id']),
              name: p['name'],
              sku: p['sku'],
              price: double.parse(p['price']),
              image: p['image'],
              faceSubArea: -1,
              description: "",
              hasOption: true,
              avgRating: p['extension_attributes'] != null &&
                      p['extension_attributes']['avgrating'] != null
                  ? p['extension_attributes']['avgrating']
                  : "0.0"));
        });

        catalogItemsList.addAll(tempProductList);
      } else {
        print(' === this one is being run ===');
        List responseList =
            await sfAPIGetCatalogPopularItems(catalogItemsCurrentPage.value);
        dynamic responseMap = responseList[0];
        if (!responseMap.containsKey('products')) {
          throw 'Products not found in response';
        }

        if (responseMap['products'] is List) {
          List<dynamic> tempProductsMap = responseMap['products'];
          List<Product> tempProductList = <Product>[];
          print(' === running 2 ===');
          tempProductsMap.forEach(
            (value) {
              if (value['face_area'] == null ||
                  faceArea.value == FaceArea.ALL) {
                print(' === running 3 ===');
                tempProductList.add(
                  Product(
                      id: int.parse(value['entity_id']),
                      sku: value['sku'],
                      image: value['image'] ??
                          value['small_image'] ??
                          value['thumbnail'] ??
                          "",
                      description:
                          value['short_description'] ?? value['description'],
                      faceSubArea: int.parse(value['face_sub_area']),
                      name: value['name'],
                      price: double.parse(value['price']),
                      options: [],
                      avgRating: value['extension_attributes'] != null &&
                              value['extension_attributes']['avgrating'] != null
                          ? value['extension_attributes']['avgrating']
                          : "0.0",
                      hasOption:
                          value['required_options'] == "1" ? true : false),
                );
              } else {
                print(' === running 4 ===');
                var id = faceAreaToIdMapping[faceArea.value] as int;
                if (value['face_area'].toString() == id.toString()) {
                  tempProductList.add(
                    Product(
                        id: int.parse(value['entity_id']),
                        sku: value['sku'],
                        avgRating: value['extension_attributes'] != null &&
                                value['extension_attributes']['avgrating'] !=
                                    null
                            ? value['extension_attributes']['avgrating']
                            : "0.0",
                        image: value['image'] ??
                            value['small_image'] ??
                            value['thumbnail'] ??
                            "",
                        description:
                            value['short_description'] ?? value['description'],
                        faceSubArea: int.parse(value['face_sub_area']),
                        name: value['name'],
                        price: double.parse(value['price']),
                        options: [],
                        hasOption:
                            value['required_options'] == "1" ? true : false),
                  );
                }
              }
            },
          );
          this.catalogItemsList.addAll(tempProductList);
          print(' === running 5 ===');
        } else {
          Map tempProductsMap = responseMap['products'];
          List<Product> tempProductList = <Product>[];
          tempProductsMap.forEach(
            (key, value) {
              if (value['face_area'] == null ||
                  faceArea.value == FaceArea.ALL) {
                tempProductList.add(
                  Product(
                      id: int.parse(value['entity_id']),
                      sku: value['sku'],
                      image: value['image'] ??
                          value['small_image'] ??
                          value['thumbnail'] ??
                          "",
                      description:
                          value['short_description'] ?? value['description'],
                      faceSubArea: int.parse(value['face_sub_area']),
                      name: value['name'],
                      price: double.parse(value['price']),
                      options: [],
                      avgRating: value['extension_attributes'] != null &&
                              value['extension_attributes']['avgrating'] != null
                          ? value['extension_attributes']['avgrating']
                          : "0.0",
                      hasOption:
                          value['required_options'] == "1" ? true : false),
                );
                print(' === running 8 ===');
              } else {
                var id = faceAreaToIdMapping[faceArea.value] as int;
                // print(
                //     '=====  matching >  ${value['face_area']} :: with :: ${id.toString()} :: where actual is ${faceArea.value} =====');
                if (value['face_area'].toString() == id.toString()) {
                  tempProductList.add(
                    Product(
                        id: int.parse(value['entity_id']),
                        sku: value['sku'],
                        image: value['image'] ??
                            value['small_image'] ??
                            value['thumbnail'] ??
                            "",
                        description:
                            value['short_description'] ?? value['description'],
                        faceSubArea: int.parse(value['face_sub_area']),
                        name: value['name'],
                        avgRating: value['extension_attributes'] != null &&
                                value['extension_attributes']['avgrating'] !=
                                    null
                            ? value['extension_attributes']['avgrating']
                            : "0.0",
                        price: double.parse(value['price']),
                        options: [],
                        hasOption:
                            value['required_options'] == "1" ? true : false),
                  );
                }
              }
            },
          );
          this.catalogItemsList.addAll(tempProductList);
          print(' === items length is ${this.catalogItemsList.length} ===');
        }
      }
      catalogItemsStatus.value = DataReadyStatus.COMPLETED;
      return true;
    } catch (err) {
      catalogItemsCurrentPage.value--;
      catalogItemsStatus.value = DataReadyStatus.ERROR;
      print(err);
      try {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Could not load more products',
            duration: Duration(seconds: 2),
          ),
        );
      } catch (ee) {
        return false;
      }
      return false;
    }
  }

  Future<bool> fetchBetweenPriceItems(String selectedFaceArea) async {
    try {
      catalogItemsCurrentPage.value++;
      List response = await sfAPIGetCatalogBetweenPriceItems(
          catalogItemsCurrentPage.value,
          this.priceFilter.value.currentMinPrice,
          this.priceFilter.value.currentMaxPrice,
          selectedFaceArea);
      print('==== running with 5 :: ${response} ===');
      Map responseMap = response[0];
      if (!responseMap.containsKey('products')) {
        throw 'Products not found in response';
      }
      print('==== running with 6 ===');

      Map productMap = responseMap['products'];

      //faceAreaToIdMapping[faceArea.value] as int
      List<Product> tempProductList = <Product>[];

      productMap.forEach(
        (key, value) {
          // if (value['face_area'] == null || faceArea.value == FaceArea.ALL) {
          tempProductList.add(
            Product(
              id: int.parse(value['entity_id']),
              sku: value['sku'] ?? '',
              image: value['image'] ?? '',
              description: value['description'] ?? '',
              faceSubArea: value['face_area'] == 'Cheeks'
                  ? faceAreaToIdMapping[FaceArea.CHEEKS]!
                  : value['face_area'] == 'Lips'
                      ? faceAreaToIdMapping[FaceArea.LIPS]!
                      : faceAreaToIdMapping[FaceArea.EYES]!,
              // faceSubArea: 280,
              // faceSubArea: int.parse(value['face_area']),
              name: value['name'] ?? '',
              avgRating: value['extension_attributes'] != null &&
                      value['extension_attributes']['avgrating'] != null
                  ? value['extension_attributes']['avgrating']
                  : "0.0",
              price: double.parse(value['price']),
              options: [],
              hasOption: value['required_options'] == "1" ? true : false,
            ),
          );

          ///-----old one - already commented
          //     /*} else {
          //         tempProductList.add(
          //           Product(
          //               id: int.parse(value['entity_id']),
          //               sku: value['sku'],
          //               image: value['image'],
          //               avgRating: value['extension_attributes'] != null &&
          //                       value['extension_attributes']['avgrating'] != null
          //                   ? value['extension_attributes']['avgrating']
          //                   : "0.0",
          //               description: value['description'] ?? '',
          //               faceSubArea: int.parse(value['face_sub_area']),
          //               name: value['name'],
          //               price: double.parse(value['price']),
          //               options: [],
          //               hasOption: value['required_options'] == "1" ? true : false),
          //         );
          //
          //     }*/
        },
      );

      print('==== running with 8 ===');

      this.catalogItemsList.addAll(tempProductList);
      print(
          '==== running with 9 :: length of itemList ${this.catalogItemsList.length} ===');
      catalogItemsStatus.value = DataReadyStatus.COMPLETED;
      return true;
    } catch (err) {
      print('==== running error 1 ===');

      catalogItemsCurrentPage.value--;
      catalogItemsStatus.value = DataReadyStatus.ERROR;
      print('Could not load items between price range $err');
      print('==== running error 2 ===');

      try {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Could not load more products',
            duration: Duration(seconds: 2),
          ),
        );
      } catch (ee) {
        print('==== running sub error 1 :: $ee ===');
      }
      return false;
    }
  }

  Future<bool> fetchSearchedItems() async {
    try {
      this.catalogItemsStatus.value = DataReadyStatus.FETCHING;
      this.catalogItemsList.removeWhere((element) => true);
      Map response = await sfAPIGetSearchedItems(this.inputText.value);
      print("SEARCH RESPONSE ${response}");
      List responseList = response['items'] ?? [];
      if (responseList.isEmpty) {
        this.catalogItemsStatus.value = DataReadyStatus.COMPLETED;
        return false;
      }
      List<Product> tempProductList = <Product>[];
      responseList.forEach(
        (m) {
          tempProductList.add(
            Product.fromDefaultMap(m),
          );
        },
      );

      this.catalogItemsList.addAll(tempProductList);
      catalogItemsStatus.value = DataReadyStatus.COMPLETED;
      return true;
    } catch (err) {
      catalogItemsStatus.value = DataReadyStatus.ERROR;
      print('Could not find user searched items: $err');
      Get.showSnackbar(
        GetSnackBar(
          message: 'No results found!',
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }

  // Defaults
  void defaults() {
    showSearchBar = false.obs;
    catalogItemsList = <Product>[].obs;
    catalogItemsCurrentPage = 0.obs;
    catalogItemsStatus = DataReadyStatus.INACTIVE.obs;
    filterType = FilterType.NONE.obs;
    filterTypePressed = FilterType.NONE.obs;
    faceArea = FaceArea.ALL.obs;
  }

  void softDefaults() {
    showSearchBar = false.obs;
    catalogItemsCurrentPage = 0.obs;
    catalogItemsStatus = DataReadyStatus.INACTIVE.obs;
    filterType = FilterType.NONE.obs;
    filterTypePressed = FilterType.NONE.obs;
    faceArea = FaceArea.ALL.obs;
  }

  /****************************************************************
      FUNCTION: Loader dialog
      ARGUMENTS: set loader with color and barrier
      RETURNS: Alert dialog with loader
      NOTES: show loader dialog
   ****************************************************************/
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

Map<FaceArea, String> faceAreaToStringMapping = {
  FaceArea.EYES: 'Eyes',
  FaceArea.LIPS: 'Lips',
  FaceArea.CHEEKS: 'Complexion',
  FaceArea.ALL: '',
};

Map<String, int> faceAreaToStandardId = {
  'foundation': 1,
  'bronzer': 2,
  'highligther': 3,
  'blusher': 4,
  'consealer': 12,
  'eyelid': 5,
  'eyesocket': 6,
  'orbital-bone': 7,
  'eyeliner': 8,
  'eyebrow': 9,
  'lipliner': 10,
  'lipstick': 11,
};

enum FilterType {
  SKINTONE,
  PRODUCT,
  PRICE,
  BRAND,
  REVIEW,
  POPULAR,
  NONE,
}

enum FaceArea {
  ALL,
  EYES,
  LIPS,
  CHEEKS,
}

class PriceFilter {
  int minPrice;
  int maxPrice;
  int _currentMinPrice = 0;
  int _currentMaxPrice = 200;
  bool changed = false;

  PriceFilter({
    this.minPrice = 0,
    this.maxPrice = 200,
  });

  void readFilter() {
    changed = false;
  }

  int get currentMinPrice {
    return _currentMinPrice;
  }

  int get currentMaxPrice {
    return _currentMaxPrice;
  }

  set currentMinPrice(int cmp) {
    _currentMinPrice = cmp;
    changed = true;
  }

  set currentMaxPrice(int cmp) {
    _currentMaxPrice = cmp;
    changed = true;
  }
}

class BrandFilter {
  List<String> brands = <String>[];
  List<String> subAreas = <String>[];

  bool changed = false;

  late String _brand = '';
  late String _subArea = '';

  BrandFilter();

  set brand(String b) {
    _brand = b;
    changed = true;
  }

  set subArea(String s) {
    _subArea = s;
    changed = true;
  }

  String get brand {
    return _brand;
  }

  String get subArea {
    return _subArea;
  }

  void readFilter() {
    changed = false;
  }
}

class ProductFilter {
  List<ChildrenData> subAreas = <ChildrenData>[];

  bool changed = false;

  ChildrenData _subArea = ChildrenData();

  ProductFilter();

  set subArea(ChildrenData sa) {
    _subArea = sa;
    changed = true;
  }

  ChildrenData get subArea {
    return _subArea;
  }

  void readFilter() {
    changed = false;
  }
}

class SkinToneFilter {
  List<String> faceSubAreas = <String>[];
  Map<String, List<SkinToneFilterParameters>> options =
      <String, List<SkinToneFilterParameters>>{};

  String _selectedFaceSubArea = '';

  bool changed = false;

  SkinToneFilter();

  String get selectedFaceSubArea {
    return _selectedFaceSubArea;
  }

  void toggleFaceSubArea(String fsa) {
    if (selectedFaceSubArea.contains(fsa)) {
      unselectFaceSubArea(fsa);
    } else {
      selectFaceSubArea(fsa);
    }
  }

  void selectFaceSubArea(String fsa) {
    _selectedFaceSubArea = fsa;
    changed = true;
  }

  void unselectFaceSubArea(String fsa) {
    _selectedFaceSubArea = '';
  }

  void readFilter() {
    changed = false;
  }

  void storeSubAreaOptions(List areaOptionsList) {
    areaOptionsList.forEach(
      (subArea) {
        String subAreaName = subArea['sub_area_name'];
        List parameters = subArea['parameters'];
        options[subAreaName] = [];
        List<String> uniqueParameterNames = <String>[];
        parameters.forEach(
          (p) {
            if (!uniqueParameterNames.contains(p['parameter_name'])) {
              uniqueParameterNames.add(p['parameter_name']);
            }
          },
        );

        uniqueParameterNames.forEach(
          (pN) {
            Map tempOptions = {};
            parameters.forEach(
              (p) {
                if (p['parameter_name'] == pN) {
                  tempOptions[p['value']] = p['parameter_options'];
                }
              },
            );

            options[subAreaName]!.add(SkinToneFilterParameters(
              parameterName: pN,
              parameterOptions: tempOptions,
            ));
          },
        );

        faceSubAreas.add(subAreaName);
      },
    );
  }
}

class SkinToneFilterParameters {
  String parameterName;
  Map parameterOptions = {};
  String selected = '';
  List selectedColors = [];

  SkinToneFilterParameters({
    required this.parameterName,
    required this.parameterOptions,
  });

  void select(String s) {
    selected = s;
  }
}
