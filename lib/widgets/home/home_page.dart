import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/widgets/home/h1a.dart';
import 'package:sofiqe/widgets/home/h1b.dart';
import 'package:sofiqe/widgets/home/h1c.dart';
import 'package:sofiqe/widgets/home/h1de.dart';

import '../../provider/account_provider.dart';
import '../../screens/banner/banner_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return PageView(
    //   scrollDirection: Axis.vertical,
    //   children: [
    //     Container(
    //       height: size.height - AppBar().preferredSize.height - 56 - MediaQuery.of(context).padding.bottom,
    //       child: H1A(),
    //     ),
    //     Container(
    //       height: size.height - AppBar().preferredSize.height - 56 - MediaQuery.of(context).padding.bottom,
    //       child: H1B(),
    //     ),
    //     Container(
    //       height: size.height - AppBar().preferredSize.height - 56 - MediaQuery.of(context).padding.bottom,
    //       child: H1C(),
    //     ),
    // Container(
    //   height: size.height - AppBar().preferredSize.height - 56 - MediaQuery.of(context).padding.bottom,
    //   child: H1DE(),
    // ),
    //   ],
    // );
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            _GreetingsCard(),
            SizedBox(
              height: 12,
            ),

            Container(
              height: size.height/2*1.5,
              //size.height - AppBar().preferredSize.height - 56 - MediaQuery.of(context).padding.bottom-65,
              color: Color(0xFFF8F8F8),
              child: Banner1(),
            ),
            //Greetings And Deals of the Day
            Container(
              height: size.height - AppBar().preferredSize.height - 56 - MediaQuery.of(context).padding.bottom,
              color: Color(0xFFF8F8F8),
              child: H1A(),
            ),

            /// Banner 2
            // Container(
            //   height: size.height - AppBar().preferredSize.height - 56 - MediaQuery.of(context).padding.bottom,
            //   color: Color(0xFFF8F8F8),
            //   child: Banner2(),
            // ),
            SizedBox(
              height: 10,
            ),
            //Products for Making
            Container(
              height: size.height - AppBar().preferredSize.height - 56 - MediaQuery.of(context).padding.bottom,
              color: Colors.green,
              child: H1B(),
            ),

            /// Banner 3
            // SizedBox(
            //   height: 15,
            // ),
            // Container(
            //   height: size.height - AppBar().preferredSize.height - 56 - MediaQuery.of(context).padding.bottom,
            //   color: Color(0xFFF8F8F8),
            //   child: Banner3(),
            // ),
            SizedBox(
              height: 15,
            ),
            //Best Sellers
            Container(
              height: size.height - AppBar().preferredSize.height - 56 - MediaQuery.of(context).padding.bottom,
              color: Colors.blue,
              child:H1C(),
            ),
            //Signup and Try On
            Container(
              height: size.height - AppBar().preferredSize.height - 56 - MediaQuery.of(context).padding.bottom,
              child: H1DE(),
            ),
          ],
        ),
      ),
    );
  }
}

class _GreetingsCard extends StatelessWidget {
  const _GreetingsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dayDate = '';
    String timeOfDayGreetings = '';
    String name = '';
    Size size = MediaQuery.of(context).size;

    DateTime date = DateTime.now();
    print("HOURS ${date}");
    dayDate = DateFormat('EEEE d MMMM').format(date);

    int hour = date.hour;
    print("HOURS ${hour}");
    timeOfDayGreetings=GetGreetings(hour);

    // if (hour > 18) {
    //   timeOfDayGreetings = 'Good Evening';
    // } else if (hour > 12) {
    //   timeOfDayGreetings = 'Good Afternoon';
    // } else if (hour > 6) {
    //   timeOfDayGreetings = 'Good Morning';
    // } else if (hour >= 0) {
    //   timeOfDayGreetings = 'Good Night';
    // }

    if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
      name = ', ${Provider.of<AccountProvider>(context, listen: false).user?.firstName ?? ""}';
      if (name == ', ') {
        name = '';
      }
    }

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            '$dayDate',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.016,
                  letterSpacing: 0,
                ),
          ),
          Text(
            '$timeOfDayGreetings$name',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.019,
                  letterSpacing: 1.2,
                ),
          ),
        ],
      ),
    );
  }

  String GetGreetings(int hour) {
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    if (hour < 20) {
      return 'Good Evening';
    }
    return 'Good Night';
  }
}