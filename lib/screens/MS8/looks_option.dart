import 'package:flutter/material.dart';
import 'package:sofiqe/model/ms8Model.dart';
import 'package:sofiqe/utils/constants/api_end_points.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/widgets/wishlistwhite.dart';
import 'package:get/get.dart';

class LooksOption extends StatefulWidget {
final  ItemData? data;
   LooksOption({ Key? key,this.data }) : super(key: key);

  @override
  State<LooksOption> createState() => _LooksOptionState();
}

class _LooksOptionState extends State<LooksOption> {

  bool expanded=false;
  @override
  Widget build(BuildContext context) {
    return           Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
            child: Container(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            widget.data!.keyName!.toUpperCase(),
                            style: TextStyle(
                              color: SplashScreenPageColors.textColor,
                              fontFamily: 'Arial, Regular',
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            expanded = !expanded;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(
                            expanded?  Icons.keyboard_arrow_down:Icons.keyboard_arrow_right,
                              color: SplashScreenPageColors.textColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: expanded ? 10 : 0),
                  expanded
                      ?  Container(
      child: Column(
        children: [
            SizedBox(
                                height: Get.height * 0.03,
                              ),
            Container(
                                width: double.infinity,
                                height: 162,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: 
                                        NetworkImage(
                                          APIEndPoints.mediaBaseUrl+widget.data!.image!,)
                                          // AssetImage('assets/images/mysofiqe.png')
                                          //     as ImageProvider

                                          // contrl.ms8model!.lookImage != null
                                          // NetworkImage(APIEndPoints.mediaBaseUrl +
                                          //         "${contrl.ms8model!.lookImage!}"
                                          //'assets/images/mysofiqe.png'
                                        // )
                                        //     : AssetImage('assets/images/mysofiqe.png')
                                        //         as ImageProvider,
                                        //  fit: BoxFit.fill

                                        )),
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                          Stack(
    children: <Widget>[  
                      Container(
                      height: 20,
                      width: 20,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        color: Color(int.parse(
                                                              widget.data!.recommendedColor
                                                                  .toString()
                                                                  .substring(
                                                                      1, 7),
                                                              radix: 16) +
                                                          0xFF000000),
                      ),
                      child: Container(),
                    ),
                    Positioned(
        right: 4,top: 4,
        child:
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.done,
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                    ))
                    
                    ]),
                 
                   SizedBox(
                                height: Get.height * 0.01,
                              ),
                                   Text(
                                                "Recommended colour",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10),
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                               SizedBox(
                                height: 14,
                              ),
                            widget.data!.tryOn=="1"?  Text(
                                                "Check ingredients",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 10),
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ):Container(),
                                                          SizedBox(
                                height:widget.data!.tryOn=="1"? 14:0,
                              ),
                            Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        widget.data!.name! //"BOMBSHELL"
                                        ,textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            ),
                                      ),
                                    ),
                                         Expanded(flex: 1, child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
  Text(
                                      // '€ ${(responseBody['price'] as num).toStringAsFixed(2)}',
                                      ' WISHLIST',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            color: SplashScreenPageColors
                                                .textColor,
                                            fontSize: 7.0,
                                          ),
                                    ),
                                    SizedBox(height: 10,),
                                  WishListNew(
                                                  sku: widget.data!.sku
                                                      .toString(),
                                                  itemId: int.parse(widget.data!.entityId
                                                      .toString()),
                                                )]))
                                  ],
                                ),
                             
                                SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Container(
                                  child: Text(
                                    widget.data!.description!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Arial, Regular',
                                      fontSize: 10.0,),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      )),
                                       SizedBox(
                                height: Get.height * 0.02,
                              ),
                                       Divider(
              height: 0,
              color: AppColors.secondaryColor,
            ),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
                  SizedBox(
                                height: Get.height * 0.01,
                              ),
            Text(
                                                "Ingredients",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10),
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                                   SizedBox(
                                height: Get.height * 0.01,
                              ),
                                               Text(
                                                widget.data!.ingredients!,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 10),
                                                textAlign: TextAlign.left,
                                               
                                              )],)
                                  
        ],
      ),
    )
                      : Container(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical:10.0),
            child: Divider(
              height: 0,
              color: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}