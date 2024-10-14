import 'package:api_challanges_skl/model/hospitals.dart';
import 'package:flutter/material.dart';

class HospitalsDetailScreen extends StatelessWidget {
  final Hospitals hospitals;

  const HospitalsDetailScreen({super.key, required this.hospitals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.black,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 72,
                            height: 72,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                48.0,
                              ),
                              child: Image.network(
                                'https://i.pinimg.com/originals/c7/1f/a0/c71fa0ca10f8ae718891f45a1aedebb2.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Container(
                            width: 160,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${hospitals.name}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Jost',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  '${hospitals.province}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Jost',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 197, 168),
                        borderRadius: BorderRadius.circular(
                          32.0,
                        ),
                      ),
                      child: Text(
                        'Follow',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Jost',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name     : ${hospitals.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Province : ${hospitals.province}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Region   : ${hospitals.region}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Address  : ${hospitals.address}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Phone    : ${hospitals.phone}',
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
      ),
    );
  }
}
