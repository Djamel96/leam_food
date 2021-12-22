import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leamapp/search/screens/search_main_screen.dart';
import 'package:provider/provider.dart';

import 'common/models/app_colors.dart';
import 'home/screens/home_screen.dart';

class TabViewMain extends StatefulWidget {
  final int initialPage;

  const TabViewMain({Key key, this.initialPage}) : super(key: key);

  @override
  _TabViewMainState createState() => _TabViewMainState();
}

class _TabViewMainState extends State<TabViewMain>
    with TickerProviderStateMixin {
  int _page;
  TabController _tabController;
  final double iconLabelpadding = 4;
  bool clickedBackAgain = false;
  @override
  void initState() {
    super.initState();
    print('init home');
    _page = widget.initialPage ?? 0;
    _tabController = TabController(initialIndex: _page, vsync: this, length: 4);
    _tabController.addListener(_setActiveTabIndex);
  }

  void _setActiveTabIndex() {
    if (mounted)
      setState(() {
        _page = _tabController.index;
      });
  }

  void goToPage(int index) {
    setState(() {
      _tabController.animateTo(index,
          duration: const Duration(microseconds: 400), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    double activeSize;
    double inactiveSize;
    return WillPopScope(
      child: Center(
        child: Container(
          color: Colors.white,
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: <Widget>[
                Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          HomeScreen(),
                          SearchMainScreen(),
                          Container(),
                          Container(),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      height: kBottomNavigationBarHeight,
                    )
                  ],
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.white,
                      currentIndex: _tabController.index,
                      elevation: 0,
                      showSelectedLabels: true,
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: MyColors.appMain100,
                      unselectedItemColor: Color(0xff2b2a35).withOpacity(.28),
                      selectedFontSize: 12,
                      unselectedFontSize: 12,
                      showUnselectedLabels: true,
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                      selectedLabelStyle: const TextStyle(
                        color: Color(0xff444444),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                      onTap: (index) {
                        goToPage(index);
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.only(bottom: iconLabelpadding),
                            child: const Icon(Icons.home),
                          ),
                          activeIcon: Padding(
                            padding: EdgeInsets.only(bottom: iconLabelpadding),
                            child: const Icon(
                              Icons.home,
                              color: MyColors.appMain100,
                            ),
                          ),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.only(bottom: iconLabelpadding),
                            child: const Icon(Icons.search),
                          ),
                          activeIcon: Padding(
                            padding: EdgeInsets.only(bottom: iconLabelpadding),
                            child: const Icon(
                              Icons.search,
                              color: MyColors.appMain100,
                            ),
                          ),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.only(bottom: iconLabelpadding),
                            child: const Icon(Icons.shopping_basket_outlined),
                          ),
                          activeIcon: Padding(
                            padding: EdgeInsets.only(bottom: iconLabelpadding),
                            child: const Icon(
                              Icons.shopping_basket_outlined,
                              color: MyColors.appMain100,
                            ),
                          ),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.only(bottom: iconLabelpadding),
                            child: Image.asset(
                              "assets/icons/save.png",
                              width: 35,
                              color: MyColors.grey169,
                            ),
                          ),
                          activeIcon: Padding(
                            padding: EdgeInsets.only(bottom: iconLabelpadding),
                            child: Image.asset(
                              "assets/icons/save.png",
                              width: 35,
                              color: MyColors.appMain100,
                            ),
                          ),
                          label: '',
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {},
    );
  }
}
