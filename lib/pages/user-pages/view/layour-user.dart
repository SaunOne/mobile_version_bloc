import 'package:appbar_animated/appbar_animated.dart';
import 'package:flutter/material.dart';
import 'package:mobile_version_bloc/pages/user-pages/view/content/home.dart';
import 'package:mobile_version_bloc/utility/appColor.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutUser extends StatefulWidget {
  const LayoutUser({super.key});

  @override
  State<LayoutUser> createState() => _LayoutUserState();
}

class _LayoutUserState extends State<LayoutUser> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  bool isSideMenu = false;
  

  Widget? activeContent;
  List<Widget> listContent = [
    Home(),
    Container(),
  ];

  

  void initState() {
    super.initState();

    // // Use normal tab controller
    // _tabController = TabController(
    //   initialIndex: 1,
    //   length: 4,
    //   vsync: this,
    // );

    //// use "MotionTabBarController" to replace with "TabController", if you need to programmatically change the tab
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 2,
      vsync: this,
    );
    activeContent = Home();
  }

  @override
  void dispose() {
    super.dispose();

    // _tabController.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScaffoldLayoutBuilder(
        backgroundColorAppBar: const ColorBuilder(
            Colors.transparent, Color.fromARGB(255, 255, 249, 237)),
        textColorAppBar:
            const ColorBuilder(Colors.white, Color.fromARGB(255, 0, 0, 0)),
        appBarBuilder: _appBar,
        child: Stack(
          children: [
            SingleChildScrollView(child: activeContent),
            if (isSideMenu)
              Positioned.fill(
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      isSideMenu = false;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
            if (isSideMenu) Positioned(top: 100, right: 20, child: sideBar(context))
          ],
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        controller:
            _motionTabBarController, // ADD THIS if you need to change your tab programmatically
        initialSelectedTab: "Home",
        labels: const ["Home", "Product"],
        icons: const [Icons.home, Icons.cake],
        // optional badges, length must be same with labels
        badges: [
          // Default Motion Badge Widget
          null,
          // custom badge Widget
          null,
          // Default Motion Badge Widget with indicator only
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: AppColors.primaryColor,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: AppColors.primaryColor,
        tabIconSelectedColor: Colors.white,
        tabBarColor: AppColors.backgroundColor,
        onTabItemSelected: (int value) {
          setState(() {
            // _tabController!.index = value;
            _motionTabBarController!.index = value;
            activeContent = listContent[value];
          });
        },
      ),
    );
  }

  Widget _appBar(BuildContext context, ColorAnimated colorAnimated) {
    return AppBar(
      backgroundColor: colorAnimated.background,
      elevation: 2,
      title: Text(
        "  Atma Kitchen",
        style: TextStyle(
          color: colorAnimated.color,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSideMenu = true;
            });
          },
          icon: Icon(
            Icons.menu,
            color: colorAnimated.color,
          ),
        ),
      ],
    );
  }

  Widget sideBar(BuildContext context) {
    return Container(
      height: 400,
      width: 280,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(50)),
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pandu Prayaksa",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "tinartianr720@gmail.com",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  height: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: Color.fromARGB(255, 82, 73, 68),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/user/history');
                      },
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Icon(
                            Icons.history,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "History",
                            style: TextStyle(
                              color: Color.fromARGB(255, 82, 73, 68),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(
                          color: Color.fromARGB(255, 82, 73, 68),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
  }
}
