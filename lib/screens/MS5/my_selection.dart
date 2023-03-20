// ignore_for_file: must_be_immutable, unused_element

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/selectedProductController.dart';
import 'package:sofiqe/model/selectedProductModel.dart';
import 'package:sofiqe/provider/catalog_provider.dart' as cat;
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/MS5/product_item_card.dart';
import 'package:sofiqe/screens/shopping_bag_screen.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/round_button.dart';
import 'package:sofiqe/widgets/translucent_background.dart';

import '../../model/product_model.dart';
import '../../provider/cart_provider.dart';
import '../../widgets/product_error_image.dart';

class MySelectionMS5 extends StatelessWidget {
  MySelectionMS5({Key? key}) : super(key: key);

  final cat.CatalogProvider catp = Get.find();
  final TryItOnProvider tmo = Get.find();

  final SelectedProductController selectedProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    tmo.getuserfacecolor();
    selectedProductController.getSelectedProduct();
    Size size = MediaQuery.of(context).size;
    double padding = size.height * 0.04;
    return Scaffold(
      body: Container(
        height: size.height,
        // height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _TopBanner(
                count: selectedProductController.isSelectedProductLoading
                    ? ""
                    : selectedProductController.selectedProduct!.items!.length.toString()),
            Obx(
              () {
                cat.FaceArea fa = catp.faceArea.value;
                return _MainFilter(faceArea: fa);
              },
            ),
            _SubFilter(selectedProductController: selectedProductController),
            GetBuilder<SelectedProductController>(builder: (contrl) {
              return (contrl.isSelectedProductLoading && tmo.centralLeftmostloading.isTrue)
                  ? Expanded(
                      child: Container(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    )
                  : Obx(() {
                      List<Items> temp = [];
                      cat.FaceArea face = catp.faceArea.value;
                      String area = "All";
// print(widget.tmo.centralcolorleftmostselected[0]);
                      if (face == cat.FaceArea.ALL) {
                        area = "All";
                      } else if (face == cat.FaceArea.CHEEKS) {
                        area = "Cheeks";
                      } else if (face == cat.FaceArea.EYES) {
                        area = "Eyes";
                      } else if (face == cat.FaceArea.LIPS) {
                        area = "Lips";
                      }


                List<Items> temp3 = [];
                List<Items> temp1 = [];
                List<Items> temp2 = [];

                contrl.selectedProduct!.items!
                    .forEach((ele) {
                  tmo.centralcolorleftmostselected
                      .forEach((element) {
                    if (element.sku == ele.product!.sku) {
                      if (element.faceArea == "Eyes") {
                        temp1.addIf(!temp1.map((item) => item.product!.entityId).contains(ele.product!.entityId), ele);
                      } else if (element.faceArea == "Lips") {
                        temp2.addIf(!temp2.map((item) => item.product!.entityId).contains(ele.product!.entityId), ele);
                      } else if (element.faceArea == "Cheeks") {
                        temp3.addIf(!temp3.map((item) => item.product!.entityId).contains(ele.product!.entityId), ele);
                      }
                    }
                  });
                });

                if (area == "Eyes") {
                  temp=temp1;
                } else if (area == "Lips") {
                  temp = temp2;
                } else if (area =="Cheeks")
                {
                  temp = temp3;
                }
                else
                  {
                    temp=[...temp1,...temp2,...temp3];
                  }
                contrl.tryMySelectionList.value=[...temp1,...temp2,...temp3];
                      return Expanded(
                          child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: (temp.length < 1)
                            ? Center(
                                child: Text("No Data Found"),
                              )
                            : GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: padding / 2,
                                  mainAxisSpacing: padding / 2,
                                  childAspectRatio: ((size.width - padding) / 2) / (size.height * 0.4),
                                ),
                                padding: EdgeInsets.all(padding / 2),
                                itemCount: temp.length,
                                itemBuilder: (ctx, i) {
                                  // bool isDiscounted = false;
                                  // int discount = 0;
                                  // try {
                                  //   isDiscounted = contrl
                                  //       .selectedProduct!
                                  //       .items![i]
                                  //       .product!
                                  //       .specialPrice!
                                  //       .isNotEmpty;
                                  //   if (isDiscounted) {
                                  //     discount = (double.parse(contrl
                                  //                 .selectedProduct!
                                  //                 .items![i]
                                  //                 .product!
                                  //                 .specialPrice!) /
                                  //             double.parse(contrl.selectedProduct!
                                  //                 .items![i].product!.price!) *
                                  //             100)
                                  //         .toInt();
                                  //   }
                                  // } catch (e) {
                                  //   isDiscounted = false;
                                  // }
                                  return SelectedProductItemCard(
                                    product: temp[i].product!,
                                    shadecolor: temp[i].shadeColour!,
                                  );
                                },
                              ),
                      ));
                    });
            }),
          ],
        ),
      ),
    );
  }
}

class _TopBanner extends StatelessWidget {
  final String count;
  _TopBanner({required this.count});

  final PageProvider pp = Get.find();
  final cat.CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cartItems =
        Provider.of<CartProvider>(context).cart != null ? Provider.of<CartProvider>(context).cart!.length : 0;
    return Stack(
      children: [
        Container(
          height: size.height * 0.15,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/mySelection.png'),
            ),
          ),
        ),
        Container(height: size.height * 0.15, width: size.width, child: TranslucentBackground(opacity: 0.2)),
        Container(
          height: size.height * 0.15,
          width: size.width,
          child: Row(
            children: [
              Container(
                width: size.width * 0.18,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset('assets/svg/arrow.svg'),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: size.width,
          height: size.height * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sofiqe',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.white,
                      fontSize: size.height * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'My Selection',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.white,
                      fontSize: size.height * 0.018,
                    ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                count + ' Products',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.white,
                      fontSize: size.height * 0.015,
                    ),
              ),
            ],
          ),
        ),
        Container(
          width: size.width,
          height: size.height * 0.15,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.014),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundButton(
                backgroundColor: Colors.black,
                size: size.height * 0.05,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext c) {
                        return ShoppingBagScreen();
                      },
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    PngIcon(image: 'assets/icons/add_to_cart_white.png'),
                    cartItems == 0
                        ? SizedBox()
                        : Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                            padding: EdgeInsets.all(5),
                            child: Text(cartItems.toString()))
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final cat.CatalogProvider catp = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(storeInput);
  }

  void storeInput() {
    catp.inputText.value = controller.value.text;
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {});
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.012, vertical: size.height * 0.008),
      alignment: Alignment.center,
      width: size.width * 0.6,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(size.height * 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: size.width * 0.5,
            child: CupertinoTextField(
              padding: EdgeInsets.symmetric(horizontal: 4),
              controller: controller,
              autofocus: true,
              decoration: BoxDecoration(
                  // border: InputBorder.none,
                  ),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.0225,
                    decoration: TextDecoration.none,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              catp.search();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: SvgPicture.asset(
                'assets/svg/search.svg',
                color: Colors.black,
                height: size.height * 0.018,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MainFilter extends StatelessWidget {
  final cat.FaceArea faceArea;
  _MainFilter({
    Key? key,
    required this.faceArea,
  }) : super(key: key);

  final cat.CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.055,
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            bottom: BorderSide(
              color: Color(0xFF645F5F),
              width: 0.5,
            ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              catp.setFaceArea(cat.FaceArea.ALL);
            },
            child: Text(
              'ALL',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: faceArea == cat.FaceArea.ALL ? Color(0xFFF2CA8A) : Colors.white,
                    fontSize: size.height * 0.018,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              catp.setFaceArea(cat.FaceArea.EYES);
            },
            child: Text(
              'EYES',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: faceArea == cat.FaceArea.EYES ? Color(0xFFF2CA8A) : Colors.white,
                    fontSize: size.height * 0.018,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              catp.setFaceArea(cat.FaceArea.LIPS);
            },
            child: Text(
              'LIPS',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: faceArea == cat.FaceArea.LIPS ? Color(0xFFF2CA8A) : Colors.white,
                    fontSize: size.height * 0.018,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              catp.setFaceArea(cat.FaceArea.CHEEKS);
            },
            child: Text(
              'CHEEKS',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: faceArea == cat.FaceArea.CHEEKS ? Color(0xFFF2CA8A) : Colors.white,
                    fontSize: size.height * 0.018,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubFilter extends StatelessWidget {
  SelectedProductController selectedProductController;

  _SubFilter({required this.selectedProductController});
  final TryItOnProvider tmo = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.075,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: GestureDetector(
        onTap: ()
        {
          tmo.showLoaderDialog(context);
          AddToCardMySelection(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Path_6.png',
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "ADD ALL TO BAG",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  AddToCardMySelection(BuildContext context) {
    int length=0;
    // selectedcontroller
    //     .selectedProduct!.items?.forEach((element) async{
    selectedProductController
        .tryMySelectionList.forEach((element) async{
      print("ENTER 11 $length");
      CartProvider cartP =
      Provider.of<CartProvider>(context,
          listen: false);
      print("ENTER 33 $length");
      print(
          "CartProvider  -->> SSs ${cartP.cartToken}");
      await cartP.addHomeProductsToCart(
          context,
          Product(
              id: int.parse(element
                  .product!.entityId!),
              name: element.product!.name,
              sku: element.product!.sku,
              price: double.parse(
                  element.product!.price!),
              image: element.product.image??"",
              description: element
                  .product!.description!,
              // faceSubArea: int.parse(element
              //     .product!.faceSubArea!),
              //Add 2 because it reseves int but come string to solve exception error pass 2
              faceSubArea: 2,
              avgRating: element
                  .product!.avgrating!
          )
      );
      length++;
      if(length==selectedProductController.tryMySelectionList.length)
      {
        Navigator.pop(context);
        // product snack bar
        Get.showSnackbar(
          GetSnackBar(
            message: 'Added all products $length',
            duration: Duration(seconds: 2),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: "https://sofiqe.com/media/catalog/product/cache/983707a945d60f44d700277fbf98de57\$image",
                // fit: BoxFit.cover,
                placeholder: (context, _) => Image.asset(
                  'assets/images/sofiqe-font-logo-2.png',
                ),
                errorWidget: (context, url, error) {
                  return ProductErrorImage(
                    width: 400,
                    height: 400,
                  );
                },
              ),
            ),
          ),
        );
      }
    });
  }
}

class _SubFilterButton extends StatelessWidget {
  final String filterName;
  final String svgPath;
  final Color color;
  final bool premium;
  final void Function() onTap;
  const _SubFilterButton({
    Key? key,
    required this.filterName,
    required this.svgPath,
    required this.color,
    required this.onTap,
    this.premium = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.01),
            SvgPicture.asset(
              '$svgPath',
              color: color,
              width: size.height * 0.02,
              height: size.height * 0.02,
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              '$filterName',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: color,
                    fontSize: size.height * 0.015,
                  ),
            ),
            Text(
              '${premium ? 'PREMIUM' : ''}',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Color(0xFFF2CA8A),
                    fontSize: size.height * 0.01,
                    letterSpacing: 0,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
