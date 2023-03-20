// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sofiqe/controller/ms8Controller.dart';
import 'package:sofiqe/model/CentralColorLeftmostModel.dart';
import 'package:sofiqe/model/UserDetailModel.dart';
import 'package:sofiqe/model/lookms3model.dart';
import 'package:sofiqe/model/product_model.dart';
import 'package:sofiqe/model/searchAlternativecolorModel.dart';
import 'package:sofiqe/utils/api/product_details_api.dart';
import 'package:sofiqe/utils/api/try_it_on_product_api.dart';
import 'package:sofiqe/utils/states/local_storage.dart';

import '../utils/states/user_account_data.dart';
import 'account_provider.dart';

enum FaceArea {
  LIPS,
  CHEEKS,
  EYES,
}

class SelectedProducts {
  String customerId;
  String faceSubarea;
  String hex;
  String sku;

  SelectedProducts(this.customerId, this.faceSubarea, this.hex, this.sku);
}

class TryItOnProvider extends GetxController {
  var homeT1T2=false;
  var isplaying=true.obs;
  var isFirstCalling=true.obs;
  RxBool showSelected = true.obs;
  var sku="".obs;
  var isChangeButtonColor=false.obs;
  Color ontapColor=Colors.grey;
  RxInt isSelectColorIndex=1000.obs;
  late RxInt page;
  late RxInt scan;
  RxInt timer = 0.obs;
  RxInt visTime = 5.obs;
  // RxInt outerIndex = 10000.obs;
  RxInt outerIndex = 100.obs;
  RxInt matchColorIndex = 200.obs;
  RxBool vis=false.obs;

  Rx<PanelController> pc = new PanelController().obs;
  late RxBool bottomSheetVisible;
  RxBool selectedProduct = false.obs;
  RxBool selectedShades = false.obs;
  Future<void> toggleShadesIconSelection(bool newVal) async {
    selectedShades.value = newVal;
  }
  RxInt colorMenuVisible = 0.obs;
  Rx<FaceArea> faceArea = FaceArea.CHEEKS.obs;
  RxInt currentSelectedArea = 0.obs;
  RxInt count = 0.obs;
  RxInt indexIs = 0.obs;
  RxString currentSelectedColor = "".obs;
  RxString currentSelectedProducturl = "".obs;
  RxString currentSelectedProductname = "".obs;
  RxString currentSelectedProductimage = "".obs;
  RxString currentSelectedProductsku = "".obs;
  RxString currentSelectedfacesubarea = "".obs;
  RxMap currentSelectedCentralColor = {"name": "", "code": ""}.obs;

   RxList alternateColors = RxList();
  RxBool alternateColorsloading = false.obs;

  RxList looklist = RxList();
  RxBool centralColorsloading = true.obs;
  RxBool centralLeftmostloading = true.obs;
  RxList<Colorss> centralcolor = RxList<Colorss>();
  RxList selectedProducts = [].obs;
  RxList<CentralColorLeftmost> centralcolorleftmost =
      RxList<CentralColorLeftmost>();
  RxList<FaceSubareaLeftmostListOfProducts> centralcolorleftmostselected =
      RxList<FaceSubareaLeftmostListOfProducts>();
  RxList<FaceSubareaLeftmostListOfProducts> temp1 =
      RxList<FaceSubareaLeftmostListOfProducts>();
  RxList<GlobalKey> items = RxList<GlobalKey>();

  /* eye color of make over flow */
  String _eye_color = "";

  /* doctor care of make over flow */
  String _doctor_care = "";

  /* lip color of make over flow */
  String _lip_color = "";

  /* hair color of make over flow */
  String _hair_color = "";

  /* skin color of make over flow */
  String _skin_tone = "";

  /* color depth of make over flow */
  String _color_depth = "";

  String get eye => _eye_color;

  String get doctorCare => _doctor_care;

  String get lip => _lip_color;

  String get hair => _hair_color;

  String get skin => _skin_tone;

  String get colorD => _color_depth;

  // All Function is for store choice of color in make over selection for send this color to post api and get relevant data
  seye(String val) {
    this._eye_color = val;
  }

  sDoctorCare(String val) {
    this._doctor_care = val;
  }

  shair(String val) {
    this._hair_color = val;
  }

  sskin(String val) {
    this._skin_tone = val;
  }

  slip(String val) {
    this._lip_color = val;
  }

  scolorD(String val) => _color_depth = val;

  /* eye color of make over flow */
  String _eye_face_area = "";

  /* doctor care of make over flow */
  String _lip_face_area = "";

  /* lip color of make over flow */
  String _cheek_face_area = "";

  String get eyeFaceArea => _eye_face_area;

  String get lipFaceArea => _lip_face_area;

  String get cheekFaceArea => _cheek_face_area;

  // All Function is for store choice of color in make over selection for send this color to post api and get relevant data
  sEyeFaceArea(String val) {
    this._eye_face_area = val;
  }

  sLipFaceArea(String val) {
    this._lip_face_area = val;
  }

  sCheekFaceArea(String val) {
    this._cheek_face_area = val;
  }

  late RxBool faceSubAreaOptionsVisible;
  late RxBool notFound;
  late RxString selectedFaceArea;
  late RxString selectedFaceSubArea;
  late List<String> capturedFileName = [
    'product_label',
    'product_color',
  ];
  late Rx<ScannedResult> scannedResult;
  late Rx<Product> received; // Sent by the API
  late RxList<Product> lookreceived; // Sent by the API
  late Rx<LooksMs3Model> filterlook; // Sent by the API

  late Product? retrieved; // Requested by the APP for full details
  late RxBool exact = true.obs;
  late AnimationController? faceAreaErrorController;

  TextEditingController brandNameController = TextEditingController();
  TextEditingController productLabelController = TextEditingController();
  Ms8Controller controller = Get.put(Ms8Controller());

  var brandName = "".obs;
  var produceLabel = "".obs;
  var dialogShowing = false.obs;
  RxBool directProduct = false.obs;
  RxBool lookProduct = false.obs;
  RxBool lookloading = true.obs;
  RxString lookname = "".obs;
  RxInt lookindex = 0.obs;




  /// CONSTRUCTOR

  TryItOnProvider() {
    // getalternateColors();
    // getCentralColors();
    // getuserfacecolor();
    setDefault();
    // getuserfacecolor();
  }

  /// METHODS
  void playSound()
  {
    if(isplaying.isTrue)
      {
        AudioPlayer().play(AssetSource('audio/onclick_sound.mp3'));
      }
  }
  void toggleColorMenu(int code) {
    if (colorMenuVisible.value == code) {
      colorMenuVisible.value = 0;
    } else {
      colorMenuVisible.value = code;
    }
  }
  timerForVisualizingRecommendations(){
    Timer.periodic(
        Duration(seconds: 1),
            (_) {
          timer++;
          if (timer == visTime) {
            // setState(() {
            vis.value = !vis.value;
            visTime = vis.value ? 5.obs : 10.obs;
            timer = 0.obs;
            print('${DateTime.now()}');
            // });
          }
          });}

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


  void toggleloading(bool load) {
    lookloading.value = load;
  }

  void setPage(int pageNo) {
    page.value = pageNo;
  }

  void changearea(String area) {
    if (selectedFaceArea.value != area) {
      selectedFaceArea.value = area;
      selectedProduct.value = false;
//     var temp;
// if(area=="Eyes"){
// temp = "Eyelid";
// }else {
//   temp=area;
// }
      currentSelectedArea.value = 0;
      // getalternateColors(currentSelectedCentralColor['code'], temp, "5");

    }
  }

  void nextScan() {
    if (scan.value == 0) {
      if (selectedFaceSubArea.isEmpty) {
        // Get.showSnackbar(GetSnackBar(
        //   message: 'Select a area where the makeup is applied on before proceeding',
        //   duration: Duration(seconds: 2),
        // ));
        if (faceAreaErrorController != null) {
          faceAreaErrorController!.forward();
        }
        return;
      }
    }
    scan.value += 1;
    // if (scan.value >= capturedFileName.length) {
    //   page.value += 1;
    //   if (page.value == 2) {
    //     this.getScanResults();
    //   }
    // }
  }

  void toggleBottomSheetVisibility() {
    bottomSheetVisible.value = !bottomSheetVisible.value;
  }

  void nextlook() {
    print(looklist);
    if (lookindex < looklist.length - 1) {
      lookindex++;
      lookname.value = looklist[lookindex.value];
      controller.getLookList(looklist[lookindex.value]);
    }
    print(lookindex);
  }

  void previouslook() {
    print(looklist);
    if (lookindex.value != 0) {
      lookindex--;
      lookname.value = looklist[lookindex.value];
      controller.getLookList(looklist[lookindex.value]);
    }
    print(lookindex);
  }

  void showFaceSubAreaOptions() {
    selectedFaceSubArea.value = '';
    faceSubAreaOptionsVisible.value = true;
  }

  void hideFaceSubAreaOptions() {
    faceSubAreaOptionsVisible.value = false;
  }

  Future<bool> getScanResults(BuildContext context) async {
    try {
      String token = await getUserToken();
      log('======== user token is this  ::  $token =======');
      log('======== brand name is ::  ${brandName.value} =======');
      log('======== product label is  ::  ${produceLabel.value} =======');

      scannedResult.value.label = brandName.value;
      scannedResult.value.ingredients = produceLabel.value;
      // scannedResult.value.color = "#ffe7d5";
      List responseList = await sfAPIScanProduct(
        token,
        // scannedResult.value.mapped(
        Provider.of<AccountProvider>(context, listen: false).customerId,
        brandName.value,
        produceLabel.value,
        // )
      );
      if (responseList.isEmpty) {
        throw 'No response received from server';
      }
      Map responseMap = responseList[0];
      //
      // exact.value = responseMap['exact'];
      Map tempProduct = {};
      if (responseMap['products'].isEmpty) {
        throw 'Product list empty';
      } else {

        responseMap['products'].forEach((p) {
          tempProduct = p;
        });
      }


      received.value = Product.fromMap(tempProduct['product']);
      print("New recieve Value: ${received.value}");
      return true;
    } catch (err) {
      notFound.value = true;
      print('Error finding scanned product: $err');
      Get.showSnackbar(
        GetSnackBar(
          message:
              'Looks like we could not find results for your scan. Please try a new scan.',
          duration: Duration(seconds: 2),
        ),
      );
    }
    return false;
  }

  Future<bool> getFullProductDetails() async {
    try {
      http.Response response =
          await sfAPIGetProductDetailsFromSKU(sku: received.value.sku!);
      Map responseBody = json.decode(response.body);
      retrieved = Product(
        id: responseBody['id'],
        sku: responseBody['sku'],
        name: responseBody['name'],
        description: '',
        avgRating: responseBody['extension_attributes'] != null &&
                responseBody['extension_attributes']['avgrating'] != null
            ? responseBody['extension_attributes']['avgrating']
            : "0.0",
        price: responseBody['price'],
        faceSubArea: received.value.faceSubArea,
        image: received.value.image,
        options: responseBody['options'],
      );
      return true;
    } catch (err) {
      print('Error fetching full product details: $err');
    }
    return false;
  }

  void currentSelectedAreaToggle(int code, String url, String name,
      String facesubarea, String sku, String colr, String img) {
    if (currentSelectedArea.value == code && selectedProduct.isTrue) {
      currentSelectedArea.value = code;
    } else {
      currentSelectedArea.value =  lookname.value == "myselection"?code:0;
      currentSelectedColor.value = '';
      selectedProduct.value = true;
      currentSelectedProductname.value = name;
      currentSelectedProductimage.value = img;
      currentSelectedProductsku.value = sku;
      currentSelectedProducturl.value = url;
      currentSelectedfacesubarea.value = facesubarea;
      if (lookname.value == "myselection") centralColorToogle(facesubarea);
      if (lookname.value != "m16") getAlternateColors(colr, facesubarea, "5");
    }
  }

  void centralColorToogle(String facearea) {
    var indx = centralcolorleftmost
        .indexWhere((element) => element.faceSubArea == facearea);
    List<Colorss> temp = [];
    if (centralcolorleftmost[indx].centralColours != null)
      centralcolorleftmost[indx].centralColours!.forEach((element) {
        temp.add(Colorss(
            colourAltHEX: element.colourAltHEX,
            colourAltName: element.colourAltName));
      });
    centralcolor.value = temp;
    currentSelectedcentralColorToggle(
        centralcolor[0].colourAltHEX!, centralcolor[0].colourAltName!);
  }

  void currentSelectedColorToggle(String colorcode) {
    if (currentSelectedColor.value != colorcode) {
      currentSelectedColor.value = colorcode;
    }
  }

  void currentSelectedcentralColorToggle(String colorcode, String name) {
    if (currentSelectedCentralColor['name'] != name ||
        currentSelectedCentralColor['code'] != colorcode) {
      currentSelectedCentralColor.value = {"name": name, "code": colorcode}.obs;
      getAlternateColors(colorcode, currentSelectedfacesubarea.value, "5");
    }
  }

  Future<bool> getAlternateColors(
      String color, String facearea, String depth) async {
    print("CONTROLL ENTER alternateColors");
    try {
      var data;
      alternateColorsloading.value = true;
      Map<String, dynamic> tokenMap = await sfQueryForSharedPrefData(
          fieldName: 'user-token', type: PreferencesDataType.STRING);
      String token =
          tokenMap['user-token'] == null ? '' : tokenMap['user-token'];
      data = await sfAPIGetSearchAlternatecolor(color, facearea, depth, token);
      if (data != null) {
        alternateColors.value = data;
        // var indx = alternateColors.length / 2;
// currentSelectedColorToggle(alternateColors[indx.toInt()]);
      } else {
        alternateColors.value = [];
      }

      alternateColorsloading.value = false;
      print("alternateColors ${alternateColors}");
      return true;
    } catch (err) {
      print("error fetching alternate color :-$err");
    }
    return false;
  }

  Future<bool> getCentralColors() async {
    print("CONTROLL ENTER getCentralColors");
    centralColorsloading.value = true;
    try {
      Map<String, dynamic> tokenMap = await sfQueryForSharedPrefData(
          fieldName: 'user-token', type: PreferencesDataType.STRING);
      String token =
          tokenMap['user-token'] == null ? '' : tokenMap['user-token'];
      var facecolor = await sfApiGetUserfaceColor(token);
      var eye = facecolor!.customAttributes!
          .firstWhere(
              (element) => element.attributeCode == "customer_eyecolour")
          .value;
      var lip = facecolor.customAttributes!
          .firstWhere(
              (element) => element.attributeCode == "customer_haircolour")
          .value;
      var hair = facecolor.customAttributes!
          .firstWhere(
              (element) => element.attributeCode == "customer_lipcolour")
          .value;
      var skincolor = facecolor.customAttributes!
          .firstWhere(
              (element) => element.attributeCode == "customer_skincolour")
          .value;

      var result = await sfAPIGetSearchCentralcolor(
          eye!,
          currentSelectedfacesubarea.value,
          lip!,
          hair!,
          skincolor!,
          "dark",
          160,
          token);
      centralcolor.value =
          SearchCentralColorModel.fromJson(result[0]).values!.colors!;
//  currentSelectedCentralColor.value = {
//         "name":centralcolor[0].colourAltName!,
//         "code":centralcolor[0].colourAltHEX!
//       }.obs;
      print("centralcolor.value");
      print(centralcolor);
      if (centralcolor.isNotEmpty) {
        currentSelectedcentralColorToggle(
            centralcolor[0].colourAltHEX!, centralcolor[0].colourAltName!);
      } else {
        alternateColors.value = [];
      }

      centralColorsloading.value = false;
      return true;
    } catch (err) {
      print("error fetching central color :-$err");
    }
    return false;
  }

  Future<bool> getuserfacecolor() async {
    centralLeftmostloading.value = true;
    try {
      Map<String, dynamic> tokenMap = await sfQueryForSharedPrefData(
          fieldName: 'user-token', type: PreferencesDataType.STRING);
      String token =
          tokenMap['user-token'] == null ? '' : tokenMap['user-token'];
      Map uidMap = await sfQueryForSharedPrefData(
          fieldName: 'uid', type: PreferencesDataType.INT);
      int uid = uidMap['uid'] as int;
      var result = await sfApiGetUserfaceColor(token);
      // centralcolor.value =
      //     SearchCentralColorModel.fromJson(result as Map<String, dynamic>)
      //         .values!
      //         .colors!;
      // currentSelectedcentralColorToggle(
      //     centralcolor[0].colourAltHEX!, centralcolor[0].colourAltName!);
      print(result);
      var res = await getCentralColorandLeftmost(result!, uid);
      centralLeftmostloading.value = false;

      print("Data: $res");
      return res;
    } catch (err) {
      centralLeftmostloading.value = false;
      print("error fetching central color :-$err");
      return false;
    }

  }


  Future<bool> getCentralColorandLeftmost(UserDetailModel data, int id) async {
    print("inFunction $id");
    try {
      centralcolorleftmostselected =
          RxList<FaceSubareaLeftmostListOfProducts>();
      // Map<String, dynamic> tokenMap = await sfQueryForSharedPrefData(
      //     fieldName: 'user-token', type: PreferencesDataType.STRING);
      // String token =
      //     tokenMap['user-token'] == null ? '' : tokenMap['user-token'];
      // var facecolor = await sfApiGetUserfaceColor(token);
      // var eye = facecolor?.customAttributes!
      //     .firstWhere(
      //         (element) => element.attributeCode == "customer_questionaire")
      //     .value![10];
      // print(
      //     "what value we get check nil :: ${data.customAttributes!.firstWhere((element) => element.attributeCode == "customer_eyecolour").value}");
      // var lip = facecolor?.customAttributes!
      //     .firstWhere(
      //         (element) => element.attributeCode == "customer_questionaire")
      //     .value![8];
      // var hair = facecolor?.customAttributes!
      //     .firstWhere(
      //         (element) => element.attributeCode == "customer_questionaire")
      //     .value![11];
      // var skincolor = facecolor?.customAttributes!
      //     .firstWhere(
      //         (element) => element.attributeCode == "customer_questionaire")
      //     .value![9];

      // eye, lip, hair and skin color given to post api as per selection

      String? eye = _eye_color;
      String? lip = _lip_color;
      String? hair = _hair_color;
      String? skincolor = _skin_tone;
      print("Check color finally::: ${_eye_color}");
      print("Check color finally::: ${_lip_color}");
      print("Check color finally::: ${_hair_color}");
      print("Check color finally::: ${_skin_tone}");


      Map<String, dynamic> tokenMap = await sfQueryForSharedPrefData(
          fieldName: 'user-token', type: PreferencesDataType.STRING);
      String token =
          tokenMap['user-token'] == null ? '' : tokenMap['user-token'];
      print("Token: $token");
      var result = await sfApiGetCentralColorAndLeftmost(
          eye, "5", lip, hair, skincolor, id, token);
      centralLeftmostloading.value = false;

      print("Main Data: $result");
      List<CentralColorLeftmost> centraldata = [];
      result!.forEach(
          (element) => centraldata.add(CentralColorLeftmost.fromJson(element)));
      print("CentraData: ${centraldata}");
      centralcolorleftmost.value = centraldata;
      centralcolorleftmost.forEach((element) {
        if (element.faceSubareaLeftmostListOfProducts!.length > 0)
          selectedProducts.add({
            "customer_id": id,
            "face_subarea":
                element.faceSubareaLeftmostListOfProducts![0].faceSubAreaName,
            "hex": element.faceSubareaLeftmostListOfProducts![0].shadeColor,
            "sku": element.faceSubareaLeftmostListOfProducts![0].sku
          });
        if (element.faceSubareaLeftmostListOfProducts!.length > 0 && !element.faceSubArea!.contains('Undershadow'))
          {
           // centralcolorleftmostselected.addIf(!centralcolorleftmostselected.map((item) => item.entityId).contains(element.faceSubareaLeftmostListOfProducts![0].entityId),element.faceSubareaLeftmostListOfProducts![0]);
            centralcolorleftmostselected
                .add(element.faceSubareaLeftmostListOfProducts![0]);
          }
      });
      // Add Product if product face area and selected face area same
      centralcolorleftmostselected.forEach((element) {
        print("ENTER DATA TEMP1 ${element.entityId}");
        if (element.faceArea == selectedFaceArea.value) {
          temp1.add(element);
        }
      });
      // add Item data
      temp1.forEach((element) {
        print("ENTER LENGTH ${temp1.length}");
        final name = GlobalKey();
        items.add(name);
      });

      // change count as per fetched product data
      count.value = centralcolorleftmostselected.length;

      centralLeftmostloading.value = false;
      print(centraldata[0]);
      print("Nilesh Result: $result");
      return true;
    } catch (err) {
      print("error fetching central color :-$err");
      centralLeftmostloading.value = false;
      return false;
    }
  }

  Future<bool?> saveSelectedProducts() async {
    try {
      Map<String, dynamic> tokenMap = await sfQueryForSharedPrefData(
          fieldName: 'user-token', type: PreferencesDataType.STRING);
      String token =
          tokenMap['user-token'] == null ? '' : tokenMap['user-token'];
      bool? res = await sfAPIStoreMySelectedProducts(token, selectedProducts);
      return res;
    } catch (err) {
      print("SaveselectedProducts error warning :-$err");
    }
    return false;
  }

  Future<bool> getproductwarning(String sku) async {
    try {
      Map<String, dynamic> tokenMap = await sfQueryForSharedPrefData(
          fieldName: 'user-token', type: PreferencesDataType.STRING);
      String token =
          tokenMap['user-token'] == null ? '' : tokenMap['user-token'];
      print("::::::: $sku");
      bool res = await sfAPIGetProductWarning(sku, token);
      return res;
    } catch (err) {
      print("error warning :-$err");
    }
    return false;
  }

  /// DEFAULTS

  setDefault() {
    page = 0.obs;
    scan = 0.obs;
    count = 0.obs;
    bottomSheetVisible = false.obs;
    faceSubAreaOptionsVisible = false.obs;
    notFound = false.obs;
    selectedFaceArea = 'Eyes'.obs;
    selectedFaceSubArea = ''.obs;
    scannedResult = ScannedResult().obs;
    lookname = ''.obs;
    selectedProduct = false.obs;
    alternateColors = RxList();
    centralcolor = RxList<Colorss>();
    currentSelectedArea = 0.obs;
    currentSelectedColor = ''.obs;
    exact = false.obs;
    received = Product(
      name: '',
      description: '',
      faceSubArea: -1,
      price: 0.0,
      image: '',
      sku: '',
      id: -1,
      avgRating: "0.0",
    ).obs;
    retrieved = null;
    lookreceived = [
      Product(
          id: 0,
          name: "",
          sku: "",
          price: 0,
          image: "",
          description: "",
          faceSubArea: 0,
          avgRating: "")
    ].obs;
  }
}

class ScannedResult {
  late String label;
  late String ingredients;
  late String color;

  ScannedResult({
    this.label = '',
    this.ingredients = '',
    this.color = '',
  });

  bool success() {
    if (this.label.isEmpty || this.ingredients.isEmpty || this.color.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Map<String, String> mapped(dynamic customerID) {
    return {
      "customer_id": "$customerID",
      "name_string": "$label",
      "ingredient_string": "$ingredients",
      "detected_color": "$color",
    };
  }
}