// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofiqe/controller/orderDetailController.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/states/function.dart';

import '../../controller/shoppinglistHistory.dart';

class ProductDetail extends StatefulWidget {
  Map<String, dynamic> data;
  String orderId;

  ProductDetail({required this.data, required this.orderId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
//   @override
  ShoppingHistory shoppingHistory = Get.put(ShoppingHistory());
  ShoppingHistory sHistory = Get.put(ShoppingHistory());
  OrderDetailController controller = Get.put(OrderDetailController());

  @override
  void initState() {
    super.initState();
    controller.getOrderDetails(widget.orderId);
  }

//   @override
  @override
  Widget build(BuildContext context) {
    print('orderId  ${widget.orderId}');
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.08),
          child: AppBar(
              //toolbarHeight: size.height * 0.15,
              backgroundColor: Colors.black,
              elevation: 0.0,
              leading: InkWell(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back,
                  )),
              centerTitle: true,
              title: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'sofiqe',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.white,
                        fontSize: size.height * 0.035,
                        letterSpacing: 0.6),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Text(
                    'ORDER DETAILS',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                ],
              )),
        ),
        body: Column(
          children: [
            // Container(
            //   width: Get.width,
            //   color: Colors.black,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Center(
            //       child: Text(
            //         'ORDER DETAILS',
            //         style: TextStyle(color: Colors.white, fontSize: 15, letterSpacing: 1),
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GetBuilder<OrderDetailController>(builder: (contrl) {
                  controller = contrl;
                  String paymentMethod = '';
                  if (contrl.orderModel != null) {
                    if (contrl.orderModel!.data!.paymentMethod!.method ==
                        'mpstripe') {
                      paymentMethod = "Card Payment";
                    } else if (contrl.orderModel!.data!.paymentMethod!.method ==
                        'paypal') {
                      paymentMethod = "Paypal";
                    } else if (contrl.orderModel!.data!.paymentMethod!.method ==
                        'clearpay') {
                      paymentMethod = "Clearpay";
                    } else {
                      paymentMethod =
                          contrl.orderModel!.data!.paymentMethod!.method!;
                    }
                  }
                  return (contrl.isOrderLoading)
                      ? Container(
                          height: Get.height,
                          width: Get.width,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : (contrl.orderModel == null)
                          ? Container(
                              height: Get.height,
                              width: Get.width,
                              child: Center(child: Text("No Data Found")),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PRODUCTS (${contrl.orderModel!.data!.items!.length})',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        contrl.orderModel!.data!.items!.length,
                                    itemBuilder: (context, i) {
                                      return InkWell(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: Get.width * 0.25,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Image.network(
                                                    APIEndPoints.mediaBaseUrl +
                                                        "${contrl.orderModel!.data!.items![i].image}",
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "${contrl.orderModel!.data!.items![i].name}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'REFERANCE: ${contrl.orderModel!.data!.items![i].orderQty}',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                            "SIZE: ${contrl.orderModel!.data!.items![i].customAttributes!.volume}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                                "COLOUR: ${widget.data["colour"]}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                            SizedBox(
                                                              width: 100,
                                                            ),
                                                            Text(
                                                              '${(double.parse(contrl.orderModel!.data!.items![i].price!)).toString().toProperCurrency()}',
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),

                                                  /* Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [

                                                        //  Container(

                                                        //   child: Column(
                                                        //      crossAxisAlignment: CrossAxisAlignment.end,
                                                        //     mainAxisAlignment: MainAxisAlignment.end,
                                                        //     children: [
                                                        //       Text("€ ${ data["price"]}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal),),
                                                        //     SizedBox(height: 10,),
                                                        //       // Container(
                                                        //       //   height: 20,
                                                        //       //   alignment: Alignment.center,
                                                        //       //   width: Get.width*0.2,
                                                        //       //   decoration: BoxDecoration(
                                                        //       //     color: Colors.black,
                                                        //       //     borderRadius: BorderRadius.circular(20)
                                                        //       //   ),
                                                        //       //   child: Text('BUY AGAIN',style: TextStyle(color: Colors.white,fontSize: 10),),
                                                        //       // ),
                                                        //     ],
                                                        //   ),
                                                        // )
                                                      ],
                                                    ),*/
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                Divider(),
                                SizedBox(height: 10),
                                Text(
                                  'DELIVERY',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "${contrl.orderModel!.data!.shippingAddress!.street}\n${contrl.orderModel!.data!.shippingAddress!.city}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal)),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("DELIVERY DATE",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                    Text(
                                        DateFormat('E, dd MMM yyyy')
                                            .format(DateTime.parse(contrl
                                                .orderModel!.data!.date
                                                .toString()))
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("PAYMENT METHOD",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                    Row(
                                      children: [
                                        Text(paymentMethod,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal)),
                                        Text(
                                            contrl
                                                        .orderModel!
                                                        .data!
                                                        .paymentMethod!
                                                        .ccLast4 ==
                                                    null
                                                ? ''
                                                : "${contrl.orderModel!.data!.paymentMethod!.ccLast4}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text(
                                    'STATUS',
                                    style: TextStyle(
                                      fontSize: 10,
                                      letterSpacing: 1.30,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    "${contrl.orderModel!.data!.status}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 1.40,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 25,
                                // ),
                                // GestureDetector(
                                //   onTap: () async{
                                //      await sHistory.orderAgain(contrl.orderModel!.data!.orderId!);
                                //   },
                                //   child: Center(
                                //     child: Container(
                                //       height: 50,
                                //       alignment: Alignment.center,
                                //       width: Get.width * 0.6,
                                //       decoration: BoxDecoration(
                                //           color: Colors.black,
                                //           borderRadius:
                                //               BorderRadius.circular(30)),
                                //       child: Text(
                                //         'BUY AGAIN',
                                //         style: TextStyle(
                                //             color: Colors.white,
                                //             fontSize: 14),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            );
                }),
              ),
            ),
            Container(
              height: 70,
              child: GestureDetector(
                onTap: () async {
                  await sHistory.orderAgain(
                      context, controller.orderModel!.data!.orderId!);
                },
                child: Center(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    width: Get.width * 0.6,
                    decoration: BoxDecoration(
                        color: Color(0xffF2CA8A),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      'BUY AGAIN',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
