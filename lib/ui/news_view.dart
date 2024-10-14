import 'package:api_challanges_skl/model/news.dart';
import 'package:api_challanges_skl/service/covid19_api.dart';
import 'package:api_challanges_skl/ui/news_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final Future<List<News>?> news = Covid19Api().getNews();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: FutureBuilder<List<News>?>(
        future: news,
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
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final newsItem = news[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(newsItem: newsItem),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      '${snapshot.data![index].title}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Jost',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Container(
                                height: 120,
                                width: 128,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    8.0,
                                  ),
                                  child: Image.network(
                                    'https://i.pinimg.com/236x/b2/a7/8b/b2a78b7520577fc3664213e22bffd2c3.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              DateFormat(
                                'EE, MMM dd, yyyy',
                              ).format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  snapshot.data?[index].timestamp ?? 0,
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.w400,
                                fontSize: 10.0,
                              ),
                            ),
                            Container(
                              width: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      Icons.share_outlined,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
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
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
