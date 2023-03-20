import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailPageShimmerView extends StatelessWidget {
  const ProductDetailPageShimmerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Container(
                              margin: EdgeInsets.only(right: 6),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ))),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 20,
                width: 180,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 20,
                width: 220,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        5,
                        (index) => Container(
                              margin: EdgeInsets.only(right: 6),
                              height: 20,
                              width: 20,
                              child: Icon(Icons.star),
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 20,
                    width: 50,
                    decoration: const BoxDecoration(color: Colors.grey),
                  ),
                  Container(
                    height: 20,
                    width: 120,
                    decoration: const BoxDecoration(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 16, width: 200, color: Colors.grey),
                      SizedBox(
                        height: 10,
                      ),
                      Container(height: 21, width: 200, color: Colors.grey),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(height: 21, width: 90, color: Colors.grey),
                          SizedBox(
                            width: 20,
                          ),
                          Container(height: 21, width: 90, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 18,
                width: double.infinity,
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 18,
                width: double.infinity,
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 18,
                width: double.infinity,
                color: Colors.grey,
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              SizedBox(height: 28),
            ],
          ),
        ));
  }
}
