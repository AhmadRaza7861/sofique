import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/currencyController.dart';
import 'package:sofiqe/controller/ms8Controller.dart';
import 'package:sofiqe/controller/selectedProductController.dart';
import 'package:sofiqe/model/ms8Model.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/utils/api/product_details_api.dart';
import 'package:sofiqe/utils/states/function.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/product_detail/order_notification.dart';
import 'package:sofiqe/widgets/product_image.dart';

import '../model/new_product_model.dart';
import '../screens/product_detail_1_screen.dart';

class TryOnLookProduct extends StatelessWidget {
  final Function? scrll;
  final ItemData? product;
  final int index;
  final int index1;
  TryOnLookProduct({
    Key? key,
    this.product,
    this.index = 0,
    this.index1 = 0,
    this.scrll,
  }) : super(key: key);
  final TryItOnProvider tiop = Get.find();
  final SelectedProductController selectedcontroller = Get.find();
  final Ms8Controller lookcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    if (product!.sku!.isEmpty) {
      return Container();
    }
    return Obx(() {
      bool selected = tiop.currentSelectedArea.value == index && tiop.selectedProduct.value == true;
      print("tiop.selectedProduct.value ${tiop.selectedProduct.value}");

      return GestureDetector(
          onTap: () {
            // print("IDEX INDEX ${index1}");
            // print("LENGTH LENGTH ${selectedcontroller.temp.length}");
            // selectedcontroller.temp.removeAt(index1);
            // print("LENGTH LENGTH ${selectedcontroller.temp.length}");
            // // var data= selectedcontroller.temp[index];
            // // selectedcontroller.temp.insert(data, selectedcontroller.temp.removeAt(index1));
            // print("TAPP");
            // print(tiop.currentSelectedArea.value);
            if (selected) {
              // selectedcontroller.isreplace.value=true;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext c) {
                    return ProductDetail1Screen(sku: product!.sku!);
                  },
                ),
              );
              // print("INDEX PRODUCT ${index1}");
              // print("SELECT PRODUCT DATA  INDEX ${index}");
              // print("${selectedcontroller.temp[index1]==selectedcontroller.selectedProduct?.items![index]}");
            } else {
              tiop.showSelected.value = true;
              tiop.isFirstCalling.value = true;
              // print("INDEX 1 ${index1}");
              // selectedcontroller.index1.value=index1;
              // selectedcontroller.index.value=index;
              tiop.currentSelectedAreaToggle(
                  index,
                  product!.urlPath ?? "",
                  product!.name!,
                  tiop.lookname.value == "myselection" ? product!.faceArea! : product!.keyName!,
                  product!.sku!,
                  product!.faceColor!,
                  product!.image != null ? product!.image! : "");
              if (tiop.lookname.value == "m16") tiop.centralColorToogle(product!.faceArea!);
              if (tiop.lookname.value == 'myselection') {
                tiop.currentSelectedColor.value = selectedcontroller.selectedProduct != null
                    ? selectedcontroller.selectedProduct!.items![index].shadeColour!
                    : '#fff';
              }

              if (selectedcontroller.isreplace.value) {
                print("COME COME  1111 $index1");
                var data = selectedcontroller.value[index1];
                selectedcontroller.value.removeAt(index1);
                selectedcontroller.value.insert(0, data);
                selectedcontroller.temp1 = selectedcontroller.value;
                selectedcontroller.isreplace.value = false;
                selectedcontroller.isreplace_1.value = true;
              } else {
                if (!selectedcontroller.isreplace_1.value) {
                  print("COME COME 222 $index1");
                  var data = selectedcontroller.temp[index1];
                  selectedcontroller.temp.removeAt(index1);
                  selectedcontroller.temp.insert(0, data);
                  selectedcontroller.value = selectedcontroller.temp;
                  selectedcontroller.isreplace.value = true;
                } else {
                  var data = selectedcontroller.temp1[index1];
                  selectedcontroller.temp1.removeAt(index1);
                  selectedcontroller.temp1.insert(0, data);
                  selectedcontroller.value = selectedcontroller.temp1;
                  selectedcontroller.isreplace.value = true;
                }
              }

              // on Select product it scroll up to the primary position
              // scrll!(index1);
              scrll!(0);
              print("INDEX 1 ${index1}");
              // Scrollable.ensureVisible(context);

//       else if(tiop.Lookname.value=="m16"){
// try{
// product!.recommended_color!.toColor();
// tiop.currentSelectedColor.value = product!.recommended_color!;
// }catch(err){
// tiop.currentSelectedColor.value="#ffff";
// }

//         // tempcolor = color[0]=="#"?color:"#ffffff";
//       }else{
// tiop.currentSelectedColor.value= lookcontroller.ms8model!.itemData![index!].recommended_color!;
//       }
            }
          },
          child: Container(
            height: 97,
            decoration: BoxDecoration(
              color: selected ? Color.fromRGBO(242, 202, 138, 1) : Colors.transparent,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300] as Color),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ItemImage(
                  image: product!.image != null ? product!.image! : "",
                ),
                ItemInformation(
                  areaName: tiop.lookname.value == "myselection" ? product!.faceArea! : product!.keyName!,
                  productName: product!.name!,
                  price: num.parse(product!.price!),
                  // reward: product!.o.toString(),
                  reward: product!.extensionAttributes!.rewardPoints!,
                ),
                // Container(
                //   width: 100,
                //   height: 100,
                //   color:
                //   //Color(0xFF39084),
                //   product?.recommendedColor?.toColor(),
                //   child: Text("${product?.recommendedColor}"),
                // ),
                ColorSelector(
                  color:
                      //product!.shadeColor!,
                      product!.recommendedColor!,
                  // color: tiop.currentSelectedColor.toString(),
                  sku: product!.sku!,
                  index: index,
                ),
                AddToBagButton(
                  product: product!,
                  index: index,
                  tiop: tiop,
                  sku: product!.sku.toString(),
                ),
              ],
            ),
          ));
    });
  }
}

class ItemImage extends StatelessWidget {
  final String image;

  ItemImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.height * 0.08,
      child: ProductImage(
        imageShortPath: image,
      ),
    );
  }
}

class ItemInformation extends StatelessWidget {
  final String areaName;
  final String productName;
  final String reward;
  final num price;

  ItemInformation(
      {Key? key, required this.areaName, required this.productName, required this.reward, required this.price})
      : super(key: key);
  final CurrencyController currencycntrl = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.09,
      width: size.width * 0.28,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${areaName.toUpperCase()}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: 8,
                  letterSpacing: 0,
                ),
          ),
          Container(
            child: Text(
              '$productName',
              // 'L\'Oreal Socket',
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: 10,
                    letterSpacing: 0,
                  ),
            ),
          ),
          Text(
            currencycntrl.defaultCurrency.toString() + ' ' + price.toStringAsFixed(2),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: 10,
                  letterSpacing: 0,
                ),
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Earn ' +
                            // reward,
                            price.round().toString(),
                        style: TextStyle(color: Colors.green, fontSize: 10)),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: PngIcon(
                          height: 12,
                          width: 12,
                          image: 'assets/images/goldencoin.png',
                        ),
                      ),
                    ),
                    TextSpan(text: 'VIP points', style: TextStyle(color: Colors.green, fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ColorSelector extends StatelessWidget {
  // final int code;
  final TryItOnProvider tiop = Get.find();
  final Ms8Controller lookcontroller = Get.find();
  final SelectedProductController selectedcontroller = Get.find();

  final String color;
  final String sku;
  final int index;

  ColorSelector({Key? key, required this.color, required this.sku, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () {
        String tempcolor;
        if (tiop.lookname.value == 'myselection') {
          tempcolor = selectedcontroller.selectedProduct != null
              ? selectedcontroller.selectedProduct!.items![index].shadeColour!
              : '';
        } else if (tiop.lookname.value == "m16") {
          try {
            color.toColor();
            tempcolor = color;
          } catch (err) {
            tempcolor = "#ffff";
          }

          // tempcolor = color[0]=="#"?color:"#ffffff";
        } else {
          tempcolor = lookcontroller.ms8model!.itemData![index].recommendedColor!;
        }
        tempcolor = tiop.currentSelectedColor.value != "" && tiop.currentSelectedArea.value == index
            ? tiop.currentSelectedColor.value
            : tempcolor;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                // Container(
                //   height: size.height * 0.08,
                //   child: Icon(Icons.arrow_left),
                // ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: size.height * 0.08,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                      // color: index==tiop.currentSelectedArea?tiop.currentSelectedColor.value.toColor(): color.toColor(),
                      color: tempcolor.toColor(),
                      border: Border.all(
                        color: Color(0xFF707070),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   height: size.height * 0.08,
                //   child: Icon(Icons.arrow_right),
                // ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            tiop.currentSelectedArea.value == index && tiop.selectedProduct.value == true
                ? FutureBuilder(
                    future: tiop.getproductwarning(sku),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> text) {
                      print(text.data);
                      if (text.data == true) {
                        return new Container(
                          child: Text(
                            "Check Ingredients",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          width: 120,
                        );
                      } else {
                        return Container(
                          width: 120,
                        );
                      }
                    })
                : Container(width: 120)
          ],
        );
      },
    );
  }
}

class AddToBagButton extends StatelessWidget {
  final TryItOnProvider tiop;
  final int index;
  final ItemData product;
  final String sku;

  AddToBagButton({Key? key, required this.product, required this.index, this.sku = "", required this.tiop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () async {
          print("ENTERE");
          tiop.sku.value = sku;
          tiop.isChangeButtonColor.value = true;
          tiop.isChangeButtonColor.value = true;
          tiop.playSound();
          Future.delayed(Duration(milliseconds: 10)).then((value) async {
            // catp.isChangeButtonColor.value=false;
            tiop.isChangeButtonColor.value = false;
            tiop.sku.value = "";

            /* show loader */
            tiop.showLoaderDialog(context);
            bool selected = tiop.currentSelectedArea.value == index && tiop.selectedProduct.value == true;

            print("object  ${selected}");
            var res = await sfAPIGetProductDetailsFromSKU(sku: product.sku!);
            Map<String, dynamic> responseBody = json.decode(res.body);
            print("reponse add cart ${responseBody['type_id']}");
            String type = responseBody['type_id'];
            if (type == "configurable") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext c) {
                    return ProductDetail1Screen(sku: product.sku!);
                  },
                ),
              );
            } else {
              CartProvider cartP = Provider.of<CartProvider>(context, listen: false);
              print("CartProvider  -->> SSs ${cartP.cartToken}");
              print("CartProvider  -->> SSs product.name ${product.name}");
              // Add Single product with correct sku
              await cartP.addHomeProductsToCartForOverlay(
                  context,
                  NewProductModel(
                      id: int.parse(product.entityId!),
                      name: product.name,
                      sku: product.sku,
                      price: double.parse(product.price!),
                      image: product.image??"",
                      description: product.description!,
                      faceSubArea: product.faceSubArea!,
                      avgRating: product.extensionAttributes!.avgratings!));

              print("Name  -->> EEE ${product.image}");

              /* hide loader */
              Navigator.canPop(context) ? Navigator.pop(context) : null;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  padding: EdgeInsets.all(0),
                  backgroundColor: Colors.black,
                  duration: Duration(seconds: 2),
                  content: Container(
                    child: CustomSnackBar(
                      sku: product.sku!,
                      image: product.image!.replaceAll(RegExp(
                          // 'https://dev.sofiqe.com/media/catalog/product'),
                          'https://sofiqe.com/media/catalog/product'), ''),
                      name: product.name!,
                    ),
                  ),
                ),
              );
            }
            // hide loader
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          });
        },
        child: Obx(
          () => Container(
            height: AppBar().preferredSize.height * 0.7,
            width: AppBar().preferredSize.height * 0.7,
            decoration: BoxDecoration(
              color: tiop.isChangeButtonColor.isTrue && tiop.sku.value == product.sku.toString()
                  ? tiop.ontapColor
                  : Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(AppBar().preferredSize.height * 0.7)),
            ),
            child: PngIcon(
              height: AppBar().preferredSize.height * 0.3,
              width: AppBar().preferredSize.height * 0.3,
              image: 'assets/icons/add_to_cart_white.png',
            ),
          ),
        ),
      ),
    );
  }
}