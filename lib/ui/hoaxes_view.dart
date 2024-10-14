import 'package:api_challanges_skl/model/hoaxes.dart';
import 'package:api_challanges_skl/service/covid19_api.dart';
import 'package:api_challanges_skl/ui/hoaxes_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HoaxesView extends StatefulWidget {
  const HoaxesView({super.key});

  @override
  State<HoaxesView> createState() => _HoaxesViewState();
}

class _HoaxesViewState extends State<HoaxesView> {
  final Future<List<Hoaxes>?> hoaxes = Covid19Api().getHoaxes();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: FutureBuilder<List<Hoaxes>?>(
        future: hoaxes,
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
                'Hoaxes not found',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          } else {
            List<Hoaxes> hoaxes = snapshot.data as List<Hoaxes>;
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final hoaxesItem = hoaxes[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HoaxesDetailScreen(
                          hoaxesItem: hoaxesItem,
                        ),
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
                                    'https://joss.co.id/data/uploads/2019/04/hoax.jpg',
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
