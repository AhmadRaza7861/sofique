import 'dart:convert';
import 'package:get/get.dart';
import 'package:sofiqe/model/reviewModel.dart';
import 'package:sofiqe/model/wishListModel.dart';
import 'package:sofiqe/network_service/network_service.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:sofiqe/utils/constants/api_tokens.dart';

import '../model/ReviewProductModel.dart';
import '../model/my_review_by_sku.dart' as mRBS;

class ReviewController extends GetxController {
static ReviewController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    getGloableReviews();
    getMyRiviewsData();
    getWishListData();
  }

  ReviewModel? reviewModel;
  ReviewModel? myReviewModel = ReviewModel();
  mRBS.MyReviewSkuModel? myReviewBySkuModel = mRBS.MyReviewSkuModel();

  RxInt globleReviewCount = 0.obs;
  RxInt myReviewCount = 0.obs;
  RxInt wishList = 0.obs;

  bool isReviewLoading = false;
  bool isReviewBySkuLoading = false;
  bool isGlobaleReviews = false;
  String customerToken = '';
  List<ReviewProductModel> reviewName = <ReviewProductModel>[];
  List<ReviewProductModel> reviewGlobaleName = <ReviewProductModel>[];

  ///
  /// Customize the request body
  /// [body] is the request body
  /// [url] is the url of the request
  /// [method] is the method of the request
  /// [token] is the token of the request
  /// [isAuth] is the authentication of the request
  ///
  ///
  getGloableReviews() async {
    var result;
    try {
      isGlobaleReviews = true;
      update();
      http.Response? response = await NetworkHandler.getMethodCall(
          // url: "https://dev.sofiqe.com/rest/V1/reviews",
          url: "https://sofiqe.com/rest/V1/reviews",
          headers: APIEndPoints.headers(APITokens.bearerToken));
      print("after api  ${response!.statusCode}".toString());
      print("getGloableReviews  ${response.body}");
      if (response.statusCode == 200) {
        reviewModel?.items = [];
        var result = json.decode(response.body);
        reviewModel = ReviewModel.fromJson(result);
        globleReviewCount.value = reviewModel!.items!.length;
        for (int i = 0; i < reviewModel!.items!.length; i++) {
          await getMyRiviewsBySkuData(reviewModel!.items![i].sku.toString()).then((value) {
            if (value != null) {
              reviewGlobaleName.add(new ReviewProductModel(
                  sku: reviewModel!.items![i].sku.toString(),
                  name: value.name.toString(),
                  imagePath: value.mediaGalleryEntries!.isNotEmpty ? value.mediaGalleryEntries![0].file.toString() : '',
                  typeId: value.typeId!));
            } else {
              reviewGlobaleName.add(new ReviewProductModel(
                  sku: reviewModel!.items![i].sku.toString(), name: '', imagePath: '', typeId: ''));
            }
          });
          // await getMyRiviewsBySkuData(reviewModel!.items![i].sku.toString())
          //     .then((value) {
          //   if (value != null) {
          //     reviewGlobaleName.add(value.name.toString());
          //     if (value.mediaGalleryEntries!.isNotEmpty) {
          //       reviewGlobaleImage
          //           .add(value.mediaGalleryEntries![0].file.toString());
          //     }
          //     print('getMyRiviewsBySkuData lllllll ${value.name.toString()}');
          //   } else {
          //     reviewGlobaleName.add('');
          //     reviewGlobaleImage.add('');
          //   }
          // });
        }
        update();
        print(globleReviewCount.value);
      } else {
        result = json.decode(response.body);
        Get.snackbar('Error', '${result["message"]}', isDismissible: true);
      }
      print("Responce of API is ${response.body}");
      isGlobaleReviews = false;
    } catch (e) {
      Get.snackbar('Error', '${result["message"]}', isDismissible: true);
    } finally {
      isGlobaleReviews = false;
      update();
    }
  }

  productAddtoBag(Result result) async {
    update();
    var body = {
      'color': result.product?.shadeColor,
      'quantity': '1',
      'product_id': result.productId,
      'total_price': result.product?.price
    };
    http.Response? response = await NetworkHandler.postMethodCall(
        body: body,
        url: "https://sofiqe.com/api/index.php/api/user/addToCartProduct",
        // url: "https://dev.sofiqe.com/api/index.php/api/user/addToCartProduct",
        headers: APIEndPoints.headers(await APITokens.customerSavedToken));
    print("After api  ${response!.statusCode}");
    if (response.statusCode == 200) {
      Get.snackbar('Successfully', 'product added in to Cart list', isDismissible: true);
    } else {
      Get.snackbar('Error', 'Error add to cart', isDismissible: true);
    }
  }

  getMyRiviewsData() async {
    var result;
    try {
      isReviewLoading = true;
      update();
      var token = await APITokens.customerSavedToken;
      print(token);
      http.Response? response = await NetworkHandler.getMethodCall(
          url: "https://sofiqe.com/rest/default/V1/customer/reviews/",
          // url: "http://dev.sofiqe.com/rest/default/V1/customer/reviews/",
          headers: APIEndPoints.headers(token));
      // print("after api  ${response!.statusCode}");
      // print("getMyRiviewsData  ${response.body}");
      if (response?.statusCode == 200) {
        myReviewModel?.items = [];
        result = json.decode(response!.body);
        myReviewModel = ReviewModel.fromJson(result);
        print('myReviewModel  ---> ${myReviewModel!.items!.length}');
        print('sku_id  ---> ${response.body}');
        myReviewCount.value = myReviewModel!.items!.length;
        print("LENGTH LENGTH ${myReviewModel!.items!.length}");
        for (int i = 0; i < myReviewModel!.items!.length; i++) {
          print("LENGTH LENGTHa ${i} ${myReviewModel!.items![i].sku}");

          // Edited on 14-04-2022 by Ashwani
          await getMyRiviewsBySkuData(myReviewModel!.items![i].sku.toString()).then((value) {
            print("CONTROLL ENTER ${i}  ${value?.name}");

            if (value != null) {
              reviewName.add(new ReviewProductModel(
                  sku: myReviewModel!.items![i].sku.toString(),
                  name: value.name.toString(),
                  imagePath: value.mediaGalleryEntries!.isNotEmpty ? value.mediaGalleryEntries![0].file.toString() : '',
                  typeId: value.typeId.toString()));
            } else {
              reviewName.add(new ReviewProductModel(
                  sku: myReviewModel!.items![i].sku.toString(), name: '', imagePath: '', typeId: ''));
            }
          });
        }
        update();
      } else {
        result = json.decode(response!.body);
        Get.snackbar('Error', '${result["message"]}', isDismissible: true);
      }
      print("Responce of API is  ${response.body}");
    } catch (e) {
      Get.snackbar('Error', '${result["message"]}', isDismissible: true);
    } finally {
      isReviewLoading = false;
      update();
    }
  }

  WishlistModel? wishlistModel;
  bool isWishListLoading = false;

  getWishListData() async {
    var result;
    try {
      isWishListLoading = true;
      update();
      http.Response? response = await NetworkHandler.getMethodCall(
          url: "https://sofiqe.com/rest/V1/wishlist/items",
          // url: "https://dev.sofiqe.com/rest/V1/wishlist/items",
          headers: APIEndPoints.headers(await APITokens.customerSavedToken));
      print("after api  ${response!.statusCode}");
      print("getWishListData  ${response.body}");
      if (response.statusCode == 200) {
        wishlistModel?.result = [];
        result = json.decode(response.body);
        wishlistModel = WishlistModel.fromJson(result);
        wishList.value = wishlistModel!.result!.length;
      } else {
        result = json.decode(response.body);
        Get.snackbar('Error', '${result["message"]}', isDismissible: true);
      }
      print("Responce of API is getWishListData ${response.body}");
    } catch (e) {
      Get.snackbar('Error', '${result["message"]}', isDismissible: true);
    } finally {
      isWishListLoading = false;
      update();
    }
  }

  Future<mRBS.MyReviewSkuModel?> getMyRiviewsBySkuData(String sku) async {
    var result;
    try {
      isReviewBySkuLoading = true;
      //update();
      http.Response? response = await NetworkHandler.getMethodCall(
          url: "https://sofiqe.com/rest/V1/products/$sku",
          // url: "https://dev.sofiqe.com/rest/V1/products/$sku",
          headers: APIEndPoints.headers(APITokens.adminBearerId));
      print("after api  ${response!.statusCode}");
      print("getMyRiviewsBySkuData  ${response.body}");
      if (response.statusCode == 200) {
        result = json.decode(response.body);
        print("YES YES");
        myReviewBySkuModel = mRBS.MyReviewSkuModel.fromJson(result);
        print("NO NO");
        print('myReviewBySkuModel  ---> ${myReviewBySkuModel!}');
        return myReviewBySkuModel;
      } else {
        result = json.decode(response.body);
        //Get.snackbar('Error', '${result["message"]}', isDismissible: true);
        return null;
      }
    } catch (e) {
      //Get.snackbar('Error', '${result["message"]}', isDismissible: true);
      return null;
    } finally {
      isReviewBySkuLoading = false;
      //update();
    }
  }

  Future<void> shareWishlist(String email, String messages) async {
    try {
      // ShareWishListModel model = ShareWishListModel(emails: email, message: messages);
      var resBody = {};
      resBody["emails"] = email;
      resBody["message"] = messages;

      Uri url = Uri.parse('${APIEndPoints.shareWishList}');
      print('share wishlist ${url.toString()}');
      http.Response response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${await APITokens.customerSavedToken}',
          },
          // body: shareWishListModelToJson(model),
          body: jsonEncode({'emails': email, 'message': messages}) //json.encode(resBody),
          );
      print(response.body);
      if (response.statusCode == 200) {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Your wishlist is shared successfully',
            duration: Duration(seconds: 2),
            isDismissible: true,
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Wishlist not shared',
            duration: Duration(seconds: 2),
            isDismissible: true,
          ),
        );
      }
    } catch (e) {
      print('Error sharing wishlist: $e');
    }
  }

  addToCartConfigurableProducts() {}
}
