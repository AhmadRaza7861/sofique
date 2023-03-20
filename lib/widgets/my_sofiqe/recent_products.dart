import 'package:flutter/material.dart';

enum RecentTab {
  RECENTSCANS,
  RECENTCOLORS,
}

class RecentProducts extends StatefulWidget {
  const RecentProducts({Key? key}) : super(key: key);

  @override
  State<RecentProducts> createState() => _RecentProductsState();
}

class _RecentProductsState extends State<RecentProducts> {
  RecentTab tab = RecentTab.RECENTSCANS;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      width: size.width,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: size.width * 0.08),
              GestureDetector(
                onTap: () {
                  tab = RecentTab.RECENTSCANS;
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: tab == RecentTab.RECENTSCANS ? Color(0xFFF2CA8A) : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Text(
                    'RECENT SCANS',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: size.height * 0.014,
                          color: Colors.black,
                          letterSpacing: 0.3,
                        ),
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.08),
              GestureDetector(
                onTap: () {
                  tab = RecentTab.RECENTCOLORS;
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: tab == RecentTab.RECENTCOLORS ? Color(0xFFF2CA8A) : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Text(
                    'RECENT COLOURS',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: size.height * 0.014,
                          color: Colors.black,
                          letterSpacing: 0.3,
                        ),
                  ),
                ),
              ),
            ],
          ),
          tab == RecentTab.RECENTCOLORS ? RecentColors() : RecentScans(),
        ],
      ),
    );
  }
}

class RecentColors extends StatelessWidget {
  const RecentColors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.arrow_left, color: Colors.black),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.arrow_right, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class RecentScans extends StatelessWidget {
  const RecentScans({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.arrow_left, color: Colors.black),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.arrow_right, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
