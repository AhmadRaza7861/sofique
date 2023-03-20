import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CatalogBufferingShimmer extends StatelessWidget {
  const CatalogBufferingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double padding = size.height * 0.04;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Color(0xFFF4F2F0),
      ),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        // controller: gridScrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: padding / 2,
          mainAxisSpacing: padding / 2,
          childAspectRatio: ((size.width - padding) / 2) / (size.height * 0.4),
        ),
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.04, horizontal: padding / 2),
        // padding: EdgeInsets.all(padding / 2),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.white,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 8, bottom: 2),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: double.infinity,
                      height: 15,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: double.infinity,
                      height: 15,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                            5,
                            (index) => Container(
                                  // margin: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 30,
                      height: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: double.infinity,
                      height: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
