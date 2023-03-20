// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sofiqe/model/product_model.dart';
// import 'package:sofiqe/provider/total_make_over_provider.dart';
// import 'package:sofiqe/widgets/makeover/total_make_over/item_for_application_area.dart';

// class BottomSheetBody extends StatelessWidget {
//   const BottomSheetBody({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           BottomSheetTabs(),
//           Expanded(child: BottomSheetItemList()),
//         ],
//       ),
//     );
//   }
// }

// class BottomSheetTabs extends StatelessWidget {
//   const BottomSheetTabs({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * 0.06,
//       width: size.width,
//       decoration: BoxDecoration(
//         border: Border(
//           top: BorderSide(
//             color: Colors.grey[300] as Color,
//             // color: Colors.black,
//           ),
//           bottom: BorderSide(
//             color: Colors.grey[300] as Color,
//             // color: Colors.black,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           BrandSelect(),
//           Expanded(child: TryOnColorSelector()),
//         ],
//       ),
//     );
//   }
// }

// class BrandSelect extends StatelessWidget {
//   BrandSelect({Key? key}) : super(key: key);

//   final TotalMakeOverProvider tmo = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       width: size.width * 0.2,
//       padding: EdgeInsets.symmetric(vertical: 0, horizontal: size.width * 0.01),
//       child: Obx(
//         () {
//           int code = tmo.currentSelectedArea.value;
//           if (code == 0) {
//             return Container(
//               padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(
//                     color: Color(0xFFF2CA8A),
//                     width: 1.5,
//                   ),
//                 ),
//               ),
//               child: Text(
//                 'all'.toUpperCase(),
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.headline2!.copyWith(
//                       color: Colors.black,
//                       fontSize: size.height * 0.014,
//                       letterSpacing: 0,
//                     ),
//               ),
//             );
//           }
//           List<String> brands = [];
//           brands.add('ALL');
//           String selected = 'ALL';
//           tmo.applicationAreaList.forEach(
//             (aa) {
//               if (aa.code == code) {
//                 selected = aa.selectedBrand;
//                 aa.products[tmo.centralColorMap[code]['ColourAltHEX']].forEach(
//                   (p) {
//                     brands.addIf(!brands.contains(p.brand), p.brand);
//                   },
//                 );
//               }
//             },
//           );

//           return DropdownButton(
//             isExpanded: true,
//             menuMaxHeight: size.height * 0.6,
//             icon: Container(),
//             onChanged: (String? newBrand) {
//               tmo.applicationAreaList.forEach(
//                 (aa) {
//                   if (aa.code == code) {
//                     aa.selectedBrand = newBrand as String;
//                     List<Product> productList = aa
//                         .products[tmo.centralColorMap[aa.code]['ColourAltHEX']];
//                     List<Product> filteredProductList = <Product>[];
//                     productList.forEach(
//                       (p) {
//                         if (aa.selectedBrand.compareTo(p.brand) == 0 ||
//                             aa.selectedBrand.compareTo('ALL') == 0) {
//                           filteredProductList.add(p);
//                         }
//                       },
//                     );
//                     aa.selectedShade = filteredProductList[0].color;
//                     tmo.currentSelectedArea.refresh();
//                   }
//                 },
//               );
//             },
//             underline: Container(),
//             value: selected,
//             items: brands.map(
//               (b) {
//                 Color underline = Colors.white;
//                 if (selected.compareTo(b) == 0) {
//                   underline = Color(0xFFF2CA8A);
//                 }
//                 return DropdownMenuItem(
//                   value: b,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           color: underline,
//                           width: 1.5,
//                         ),
//                       ),
//                     ),
//                     child: Text(
//                       '$b',
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.headline2!.copyWith(
//                             color: Colors.black,
//                             fontSize: size.height * 0.014,
//                             letterSpacing: 0,
//                           ),
//                     ),
//                   ),
//                 );
//               },
//             ).toList(),
//           );
//         },
//       ),
//     );
//   }
// }

// class TryOnColorSelector extends StatelessWidget {
//   TryOnColorSelector({Key? key}) : super(key: key);

//   final TotalMakeOverProvider tmo = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Container(
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Obx(
//           () {
//             int code = tmo.currentSelectedArea.value;
//             if (code == 0) {
//               return Text(
//                 'select an item to view additional colours!'.toUpperCase(),
//                 style: Theme.of(context).textTheme.headline2!.copyWith(
//                       color: Colors.black,
//                       fontSize: size.height * 0.014,
//                       letterSpacing: 0,
//                     ),
//               );
//             }
//             List recommendedColors = [];
//             // tmo.faceApplicationMap[tmo.faceArea.value].forEach((ApplicationArea a) {
//             tmo.applicationAreaList.forEach((ApplicationArea a) {
//               if (a.code == code) {
//                 recommendedColors = a.recommendedColors;
//               }
//             });
//             return Row(
//               children: [
//                 ...recommendedColors.map(
//                   (color) {
//                     return TryOnColorChoice(
//                       hex: color['ColourAltHEX'],
//                       name: color['ColourAltName'],
//                       code: code,
//                     );
//                   },
//                 ).toList(),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class TryOnColorChoice extends StatelessWidget {
//   final String hex;
//   final String? name;
//   final int code;
//   TryOnColorChoice(
//       {Key? key, required this.hex, this.name = '', required this.code})
//       : super(key: key);

//   final TotalMakeOverProvider tmo = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () {
//         tmo.changeCentralColorFor(
//             code, {'ColourAltName': name, 'ColourAltHEX': hex});
//         tmo.colorMenuVisible.value = 0;
//         tmo.currentSelectedArea.refresh();
//       },
//       child: Obx(
//         () {
//           Color color = Colors.transparent;

//           // if (tmo.centralColorMap.value[code] == [hex, name]) {
//           if (mapEquals(
//               tmo.centralColorMap.value[code] as Map<dynamic, dynamic>,
//               {'ColourAltName': name, 'ColourAltHEX': hex})) {
//             color = Color(0xFFF2CA8A);
//           }

//           return Container(
//             padding: EdgeInsets.symmetric(
//                 vertical: size.height * 0.01, horizontal: size.width * 0.01),
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: color,
//                   width: 1.5,
//                 ),
//               ),
//             ),
//             child: Text(
//               '$name'.toUpperCase(),
//               style: Theme.of(context).textTheme.headline2!.copyWith(
//                     color: Colors.black,
//                     fontSize: size.height * 0.014,
//                     letterSpacing: 0,
//                   ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class BottomSheetItemList extends StatelessWidget {
//   BottomSheetItemList({Key? key}) : super(key: key);

//   final TotalMakeOverProvider tmo = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         child: Obx(
//           () {
//             return Column(
//               children: [
//                 ...tmo.applicationAreaList.map(
//                   (aa) {
//                     var colorMap = tmo.centralColorMap[aa.code];
//                     if (aa.products.isEmpty) {
//                       return Container();
//                     }

//                     // return TryOnProduct(product: aa.products[colorMap['ColourAltHEX']][0]);
//                     return ItemForApplicationArea(applicationArea: aa);
//                   },
//                 ).toList(),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/total_make_over_provider.dart';
import 'package:sofiqe/widgets/makeover/total_make_over/item_for_application_area.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BottomSheetTabs(),
          Expanded(child: BottomSheetItemList()),
        ],
      ),
    );
  }
}

class BottomSheetTabs extends StatelessWidget {
  const BottomSheetTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.06,
      width: size.width,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[300] as Color,
            // color: Colors.black,
          ),
          bottom: BorderSide(
            color: Colors.grey[300] as Color,
            // color: Colors.black,
          ),
        ),
      ),
      child: Row(
        children: [
          BrandSelect(),
          Expanded(child: TryOnColorSelector()),
        ],
      ),
    );
  }
}

class BrandSelect extends StatelessWidget {
  BrandSelect({Key? key}) : super(key: key);

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.2,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: size.width * 0.01),
      child: Obx(
        () {
          int code = tmo.currentSelectedArea.value;
          if (code == 0) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFF2CA8A),
                    width: 1.5,
                  ),
                ),
              ),
              child: Text(
                'all'.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: size.height * 0.014,
                      letterSpacing: 0,
                    ),
              ),
            );
          }
          // List brands = [];
          tmo.faceApplicationMap[tmo.faceArea.value].forEach((ApplicationArea a) {
            if (a.code == code) {
              // brands = a.brands;
            }
          });
          return DropdownButton<String>(
            onChanged: (value) => print("change"),
            isExpanded: true,
            icon: Container(),
            underline: Container(),
            items: [
              DropdownMenuItem(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFF2CA8A),
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Text(
                    'all'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.black,
                          fontSize: size.height * 0.014,
                          letterSpacing: 0,
                        ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class TryOnColorSelector extends StatelessWidget {
  TryOnColorSelector({Key? key}) : super(key: key);

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(
          () {
            int code = tmo.currentSelectedArea.value;
            if (code == 0) {
              return Text(
                'select an item to view additional colours!'.toUpperCase(),
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: size.height * 0.014,
                      letterSpacing: 0,
                    ),
              );
            }
            List recommendedColors = [];
            tmo.faceApplicationMap[tmo.faceArea.value].forEach((ApplicationArea a) {
              if (a.code == code) {
                recommendedColors = a.recommendedColors;
              }
            });
            return Row(
              children: [
                ...recommendedColors.map(
                  (color) {
                    return TryOnColorChoice(
                      hex: color[0],
                      name: color[1],
                      code: code,
                    );
                  },
                ).toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TryOnColorChoice extends StatelessWidget {
  final String hex;
  final String name;
  final int code;
  TryOnColorChoice({Key? key, required this.hex, required this.name, required this.code}) : super(key: key);

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        tmo.changeCentralColorFor(code, [hex, name]);
      },
      child: Obx(
        () {
          Color color = Colors.transparent;

          // if (tmo.centralColorMap.value[code] == [hex, name]) {
          if (listEquals([...tmo.centralColorMap[code]], [hex, name])) {
            color = Color(0xFFF2CA8A);
          }
          return Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.01),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: color,
                  width: 1.5,
                ),
              ),
            ),
            child: Text(
              '$name'.toUpperCase(),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.014,
                    letterSpacing: 0,
                  ),
            ),
          );
        },
      ),
    );
  }
}

class BottomSheetItemList extends StatelessWidget {
  BottomSheetItemList({Key? key}) : super(key: key);

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Obx(
          () {
            return Column(
              children: [
                ...tmo.applicationAreaList.map(
                  (aa) {
                    return ItemForApplicationArea(applicationArea: aa);
                  },
                ).toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
