import 'package:api_challanges_skl/model/stats.dart';
import 'package:api_challanges_skl/service/covid19_api.dart';
import 'package:api_challanges_skl/ui/stats_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsView extends StatefulWidget {
  const StatsView({super.key});

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  final Future<Stats> stats = Covid19Api().getStats();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        8.0,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          future: stats,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                ),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'Hoaxes not found',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              Stats stats = snapshot.data!;
              String formatNumber(number) {
                final formatter = NumberFormat('#,##0', 'id_ID');
                return formatter.format(number);
              }

              return SizedBox(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                        color: Color.fromARGB(
                          255,
                          27,
                          32,
                          37,
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  width: 80,
                                  child: Image.network(
                                    'https://www.worldatlas.com/r/w1200-h701-c1200x701/upload/9f/69/0a/id-flag.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  '${stats.name}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Jost',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 24.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Infected',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Jost',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Text(
                                          formatNumber(
                                              snapshot.data!.numbers!.infected),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Jost',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Recovered',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Jost',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Text(
                                          formatNumber(
                                            stats.numbers!.recovered,
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Jost',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Fatal',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Jost',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Text(
                                          formatNumber(stats.numbers!.fatal),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Jost',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 120 * (stats.regions!.length / 2).ceilToDouble(),
                      padding: EdgeInsets.symmetric(
                        vertical: 4.0,
                      ),
                      child: GridView.builder(
                        padding: EdgeInsets.all(
                          0,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 120,
                        ),
                        itemCount: stats.regions!.length,
                        itemBuilder: (context, index) {
                          final statsItem = stats.regions![index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StatsDetailScreen(stats: statsItem),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              margin: EdgeInsets.all(
                                4.0,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(
                                  255,
                                  27,
                                  32,
                                  37,
                                ),
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      '${stats.regions![index].name}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Jost',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.0,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                'Infected     :',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Jost',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12.0,
                                              ),
                                              Text(
                                                formatNumber(
                                                  stats.regions![index].numbers!
                                                      .infected,
                                                ),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Jost',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.0,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                'Recovered  :',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Jost',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12.0,
                                              ),
                                              Text(
                                                formatNumber(
                                                  stats.regions![index].numbers!
                                                      .recovered,
                                                ),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Jost',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.0,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                'Fatal          :',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Jost',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12.0,
                                              ),
                                              Text(
                                                formatNumber(
                                                  stats.regions![index].numbers!
                                                      .fatal,
                                                ),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Jost',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
