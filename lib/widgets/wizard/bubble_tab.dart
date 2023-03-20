import 'package:flutter/material.dart';

class BubbleTab extends StatelessWidget {
  final int length;
  final int current;
  BubbleTab({required this.length, required this.current});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            length,
            (index) {
              if (index == current) {
                return _SelectedTab();
              } else {
                return _UnSelectedTab();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _UnSelectedTab extends StatelessWidget {
  const _UnSelectedTab();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: Color(0xFFC7A46B),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

class _SelectedTab extends StatelessWidget {
  const _SelectedTab();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
      width: 11,
      height: 7,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
