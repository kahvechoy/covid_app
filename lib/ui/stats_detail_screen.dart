import 'package:api_challanges_skl/model/stats.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsDetailScreen extends StatelessWidget {
  final Region stats;

  const StatsDetailScreen({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    String formatNumber(number) {
      final formatter = NumberFormat('#,##0', 'id_ID');
      return formatter.format(number);
    }

    return Scaffold(
      body: Container(
        color: Colors.black,
        height: 1000,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 48.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BackButton(
                    color: Colors.white,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 32.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${stats.name}',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Jost',
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              '${stats.type}',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Jost',
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          formatNumber(
                            stats.numbers!.infected,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          'Infected',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.8,
                    height: 64.0,
                    color: Color.fromARGB(255, 125, 125, 125),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          formatNumber(
                            stats.numbers!.recovered,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          'Recovered',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.8,
                    height: 64.0,
                    color: Color.fromARGB(255, 125, 125, 125),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          formatNumber(
                            stats.numbers!.fatal,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          'Fatal',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Container(
              width: double.infinity,
              height: 4.0,
              color: Color.fromARGB(
                255,
                27,
                32,
                37,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
