import 'package:api_challanges_skl/ui/bottom_bar.dart';
import 'package:api_challanges_skl/ui/hoaxes_view.dart';
import 'package:api_challanges_skl/ui/hospitals_view.dart';
import 'package:api_challanges_skl/ui/news_view.dart';
import 'package:api_challanges_skl/ui/stats_view.dart';
import 'package:flutter/material.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({
    super.key,
    required this.initialIndex,
  });

  final int initialIndex;

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  late int _selectedIndex = 0;

  final List<Widget> _view = [
    NewsView(),
    HoaxesView(),
    HospitalsView(),
    StatsView(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 48.0,
                right: 16.0,
                left: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BackButton(
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        color: Color.fromARGB(255, 28, 35, 38),
                      ),
                      margin: EdgeInsets.only(
                        left: 24.0,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 32.0,
                            ),
                          ),
                          Text(
                            'Search',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Jost',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AllButtonsView(
              selectedIndex: _selectedIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            Expanded(
              child: _view[_selectedIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class AllButtonsView extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const AllButtonsView({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Row(
          children: <Widget>[
            _allViewButton('News', 0),
            _allViewButton('Hoaxes', 1),
            _allViewButton('Hospitals', 2),
            _allViewButton('Stats', 3),
          ],
        ),
      ),
    );
  }

  Container _allViewButton(String buttonText, int index) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: ElevatedButton(
        onPressed: () {
          onTabSelected(index);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedIndex == index
              ? Colors.blueAccent
              : Colors.black,
          side: BorderSide(
            color: Color.fromARGB(255, 27, 32, 37),
            width: selectedIndex == index ? 0 : 3,
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Jost',
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}