import 'package:api_challanges_skl/model/hoaxes.dart';
import 'package:api_challanges_skl/model/hospitals.dart';
import 'package:api_challanges_skl/model/news.dart';
import 'package:api_challanges_skl/model/stats.dart';
import 'package:api_challanges_skl/service/covid19_api.dart';
import 'package:api_challanges_skl/ui/bottom_bar.dart';
import 'package:api_challanges_skl/ui/hoaxes_detail_screen.dart';
import 'package:api_challanges_skl/ui/hospitals_detail_screen.dart';
import 'package:api_challanges_skl/ui/news_detail_screen.dart';
import 'package:api_challanges_skl/ui/stats_detail_screen.dart';
import 'package:api_challanges_skl/ui/view_all_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Color.fromARGB(255, 25, 25, 25)
  // Color.fromARGB(255, 125, 125, 125)
  // Color.fromARGB(255, 27, 32, 37)
  // Color.fromARGB(255, 0, 197, 168)
  final Future<List<News>?> news = Covid19Api().getNews();
  final Future<List<Hoaxes>?> hoaxes = Covid19Api().getHoaxes();
  final Future<List<Hospitals>?> hospitals = Covid19Api().getHospitals();
  final Future<Stats> stats = Covid19Api().getStats();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 52.0,
                  bottom: 32,
                  right: 16.0,
                  left: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Discover',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'News',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Jost',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.all(1),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewAllScreen(
                                      initialIndex: 0, // Untuk News
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'View All',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'Jost',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.blue,
                                    size: 16.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 440,
                      width: double.infinity,
                      child: FutureBuilder<List<News>?>(
                        future: news,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}',
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                'News not found',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else {
                            List<News> news = snapshot.data as List<News>;
                            return SizedBox(
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.0,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  final newsItem = news[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NewsDetailScreen(
                                            newsItem: newsItem,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 300,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      margin: EdgeInsets.only(
                                        top: 24.0,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Container(
                                              height: 216,
                                              width: 300,
                                              child: Image.network(
                                                'https://i.pinimg.com/474x/d0/95/57/d095573863cb6888450ab167d47caa52.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 16.0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  height: 100,
                                                  child: Text(
                                                    '${snapshot.data![index].title}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Jost',
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    bottom: 8.0,
                                                  ),
                                                  child: Text(
                                                    DateFormat(
                                                            'EE, MMM dd, yyyy')
                                                        .format(
                                                      DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                        snapshot.data?[index]
                                                                .timestamp ??
                                                            0,
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Jost',
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.share_outlined,
                                                        color: Colors.white,
                                                        size: 20.0,
                                                      ),
                                                      SizedBox(
                                                        width: 16.0,
                                                      ),
                                                      Icon(
                                                        Icons.more_vert,
                                                        color: Colors.white,
                                                        size: 24.0,
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
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Hospitals',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Jost',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.all(0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewAllScreen(
                                      initialIndex: 2, // Untuk News
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'View All',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'Jost',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.blue,
                                    size: 16.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 220,
                      padding: EdgeInsets.symmetric(
                        vertical: 32.0,
                      ),
                      child: FutureBuilder<List<Hospitals>?>(
                        future: hospitals,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error Setan: ${snapshot.error}',
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                'Hospitals not found',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    width: 120,
                                    child: Container(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HospitalsDetailScreen(
                                                hospitals:
                                                    snapshot.data![index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                40,
                                              ),
                                              child: Container(
                                                width: 80,
                                                height: 80,
                                                child: Image.network(
                                                  'https://i.pinimg.com/564x/65/bf/4b/65bf4b1ff2ecd3a6542daedd4817cee1.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                top: 12.0,
                                                bottom: 8.0,
                                              ),
                                              child: Text(
                                                '${snapshot.data![index].name}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Jost',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0,
                                                ),
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 6.0,
                                                horizontal: 16.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.blueAccent,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  16.0,
                                                ),
                                              ),
                                              child: Text(
                                                'Follow',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Jost',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Hoaxes',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Jost',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.all(0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewAllScreen(
                                      initialIndex: 1,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'View All',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'Jost',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.blue,
                                    size: 16.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 440,
                      width: double.infinity,
                      child: FutureBuilder<List<Hoaxes>?>(
                        future: hoaxes,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}',
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                'Hoaxes not found',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else {
                            List<Hoaxes> hoaxes = snapshot.data as List<Hoaxes>;
                            return SizedBox(
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.0,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  final hoaxesItem = hoaxes[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HoaxesDetailScreen(
                                            hoaxesItem: hoaxesItem,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 300,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      margin: EdgeInsets.only(
                                        top: 24.0,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Container(
                                              height: 216,
                                              width: 300,
                                              child: Image.network(
                                                'https://i.pinimg.com/474x/ee/47/66/ee4766d7951f05134e8d79675cb6fba3.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 16.0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  height: 100,
                                                  child: Text(
                                                    '${snapshot.data![index].title}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Jost',
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    bottom: 8.0,
                                                  ),
                                                  child: Text(
                                                    DateFormat(
                                                            'EE, MMM dd, yyyy')
                                                        .format(
                                                      DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                        snapshot.data?[index]
                                                                .timestamp ??
                                                            0,
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Jost',
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.share_outlined,
                                                        color: Colors.white,
                                                        size: 20.0,
                                                      ),
                                                      SizedBox(
                                                        width: 16.0,
                                                      ),
                                                      Icon(
                                                        Icons.more_vert,
                                                        color: Colors.white,
                                                        size: 24.0,
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
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Statistic',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Jost',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.all(1),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewAllScreen(
                                      initialIndex: 3,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'View All',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'Jost',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.blue,
                                    size: 16.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 300,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                      width: double.infinity,
                      child: FutureBuilder(
                        future: stats,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                              child: SingleChildScrollView(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 16.0,
                                        ),
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 27, 32, 37),
                                          borderRadius: BorderRadius.circular(
                                            12.0,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    width: 80,
                                                    height: 48,
                                                    child: Image.network(
                                                      "https://i.pinimg.com/474x/08/4c/c9/084cc9b6374beac9d0e4bc0704f1c565.jpg",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  Text(
                                                    '${stats.name}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Jost',
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Infected :',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Jost',
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    formatNumber(stats
                                                        .numbers!.infected),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Jost',
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  Text(
                                                    'Recovered :',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Jost',
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    formatNumber(stats
                                                        .numbers!.recovered),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Jost',
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  Text(
                                                    'Fatal :',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Jost',
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    formatNumber(
                                                        stats.numbers!.fatal),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Jost',
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              DateFormat('EEE, dd MMM yyyy')
                                                  .format(
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                  stats.timestamp ?? 0,
                                                ),
                                              ),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Jost',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        height: 300,
                                        width: 240 *
                                            (stats.regions!.length / 3)
                                                .ceilToDouble(),
                                        child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisExtent: 240,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: stats.regions!.length,
                                          itemBuilder: (context, index) {
                                            final statsItem =
                                                stats.regions![index];
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        StatsDetailScreen(
                                                      stats: statsItem,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12.0,
                                                ),
                                                margin: EdgeInsets.all(
                                                  8.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                    255,
                                                    27,
                                                    32,
                                                    37,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    12.0,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '${stats.regions![index].name}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Jost',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8.0,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Infected',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Jost',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  formatNumber(stats
                                                                      .regions![
                                                                          index]
                                                                      .numbers!
                                                                      .infected),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Jost',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Recovered',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Jost',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  formatNumber(stats
                                                                      .regions![
                                                                          index]
                                                                      .numbers!
                                                                      .recovered),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Jost',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Fatal',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Jost',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  formatNumber(stats
                                                                      .regions![
                                                                          index]
                                                                      .numbers!
                                                                      .fatal),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Jost',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12.0,
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
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
