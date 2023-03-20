import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 3rd party packages
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/utils/states/function.dart';

// Custom packages
import 'package:sofiqe/widgets/horizontal_bar.dart';

class CheckoutItems extends StatelessWidget {
  const CheckoutItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<dynamic> _productList =
        Provider.of<CartProvider>(context, listen: false).cart!;
    return Container(
      constraints: BoxConstraints(maxHeight: size.height * 0.2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ..._productList.map<_CheckoutItemTemplate>(
              (dynamic p) {
                return _CheckoutItemTemplate(product: p);
              },
            ).toList(),
            SizedBox(height: 5.5),
            HorizontalBar(
                height: 0.5,
                width: MediaQuery.of(context).size.width,
                color: Color(0xFFD3D3D3)),
          ],
        ),
      ),
    );
  }
}

class _CheckoutItemTemplate extends StatefulWidget {
  final Map<String, dynamic> product;

  _CheckoutItemTemplate({Key? key, required this.product}) : super(key: key);

  @override
  State<_CheckoutItemTemplate> createState() => _CheckoutItemTemplateState();
}

class _CheckoutItemTemplateState extends State<_CheckoutItemTemplate> {
  var image = "".obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    image.value = widget.product['extension_attributes']['image'];

    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Container(
                  child: Obx(() => image.isEmpty
                      ? Image.asset('assets/icons/lip_1.png',
                          width: size.width * 0.05, height: size.width * 0.05)
                      : Image.network(
                          widget.product['extension_attributes']['image'],
                      width:size.width * 0.09, height: size.width * 0.09,
                          fit: BoxFit.fill,
                      errorBuilder: (BuildContext context,
                              Object exception, StackTrace? stackTrace) {
                          return Image.asset('assets/icons/lip_1.png',
                              width: size.width * 0.05,
                              height: size.width * 0.05);
                        }))),
              SizedBox(width: size.width * 0.001),
              Expanded(
                child: Container(
                  width: size.width * 0.30,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: Text(
                    '${widget.product['name'].toUpperCase()}',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.black,
                          fontSize: size.height * 0.014,
                          letterSpacing: 0.5,
                        ),
                  ),
                ),
              ),
              Container(
                  height: size.width * 0.03,
                  width: size.width * 0.03,
                  color: getColor()),
              SizedBox(width: 12),
              Text(
                '${(widget.product['qty'] as num)}',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
              ),
              SizedBox(width: 10),
              Container(
                alignment: Alignment.centerRight,
                width: size.width * 0.21,
                child: Text(
                  '${(widget.product['price'] as num).toDouble().toString().toProperCurrency()}',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.5),
      ],
    );
  }
  getColor()
  {
    try
    {
      return Color(int.parse(
          widget.product['extension_attributes']["shade_color"]
              .toString()
              .substring(1, 7),
          radix: 16) +
          0xFF000000);
    }
    catch(e)
    {
      return Colors.grey;

    }

  }
}
