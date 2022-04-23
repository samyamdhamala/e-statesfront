import 'package:flutter/material.dart';
import 'package:login/models/post.dart';
import 'package:login/models/property_model.dart';
import 'package:login/pages/add_new_property_page.dart';
import 'package:login/pages/common/common/search_delegate.dart';
import 'package:login/pages/display_for_all_property/bookmarked_property_listings.dart';
import 'package:login/pages/display_for_all_property/house_property_listings.dart';
import 'package:login/property_feature/get_all_property.dart';
import 'package:login/pages/display_for_all_property/all_property_listings_page.dart';
import 'package:login/pages/widgets/drawer.dart';
import 'package:login/pages/display_for_all_property/all_recomendadation_card_home.dart';
import 'package:login/token_shared_preferences.dart';
import '../../display_for_all_property/land_property_listings.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic>? userData;
  final dynamic dataList;
  HomePage({Key? key, this.userData, this.dataList}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(),
    AddProperty(),
    PropertyListings(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

  String? _userName;
  String? _lastName;
  String? _email;
  Post? post;
  List<PropertyModel>? getterData;
  @override
  void initState() {
    super.initState();
    getData();
    setUserName();
    setState(() {});
  }

  Future<void> getData() async {
    getterData = await GetAllProperty.getAllProperty();
    setState(() {});
  }

  Future<void> setUserName() async {
    final prefs =
        await TokenSharedPrefernces.instance.getNameValue('firstName');
    final lastNameprefs =
        await TokenSharedPrefernces.instance.getNameValue('lastName');
    final emailPrefs =
        await TokenSharedPrefernces.instance.getNameValue('email');

    setState(() {
      _userName = prefs;
      _email = emailPrefs;
      _lastName = lastNameprefs;
    });
  }

  int _selectedIndex = 2;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void _onItemTapped(int index) {
    if (index == 3) {
      _drawerKey.currentState!.openEndDrawer();
      setState(() {
        _selectedIndex = index;
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Good Morning,\n';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon,\n';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening,\n';
    } else {
      return 'Good Night,\n';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      key: _drawerKey,
      endDrawer: MyDrawer(
        lastName: _lastName.toString(),
        firstName: _userName.toString(),
        userEmail: _email.toString(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                ),
                ElevatedButton(
                  child: const Text('Post Property',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddProperty())),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xff857EF5),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: TextField(
                readOnly: true,
                onTap: () =>
                    showSearch(context: context, delegate: DataSearch()),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(207, 206, 206, 100),
                  hintText: 'Search Area or City',
                  suffixIcon: const Icon(
                    Icons.search,
                    size: 34,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                    text: greetingMessage(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 155, 156, 156),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: _userName == null ? ' Guest' : _userName,
                        // text: widget.userData!['firstName'].toString(),

                        style: Theme.of(context).textTheme.headline3,
                      )
                    ]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Text(
                    "Explore E-States Nepal",
                    style: Theme.of(context).textTheme.headline1!,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PropertyListings())),
                    child: Text(
                      "SEE ALL",
                      style: Theme.of(context).textTheme.headline2!,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.27,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  debugPrint(
                      'This is the length of the getter: ${getterData?.length.toString()}');
                  return RecommendationCard(propertyModel: getterData![index]);
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Text(
                    "Categories:",
                    style: Theme.of(context).textTheme.headline1!,
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HousePropertyListings())),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff857EF5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.06,
                          vertical: MediaQuery.of(context).size.height * 0.025,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.house,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              "House ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LandPropertyListings())),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff857EF5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.06,
                          vertical: MediaQuery.of(context).size.height * 0.025,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.landscape_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              " Land ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PropertyListings())),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff857EF5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.06,
                          vertical: MediaQuery.of(context).size.height * 0.025,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.apps,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              "  All  ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: const Color(0xff857EF5),
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProperty()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          currentScreen = HomePage();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home,
                              color: currentTab == 0
                                  ? Color.fromARGB(255, 157, 116, 229)
                                  : Colors.grey[600]),
                          Text(
                            "Home",
                            style: TextStyle(
                                color: currentTab == 0
                                    ? Color.fromARGB(255, 157, 116, 229)
                                    : Colors.grey[600]),
                          ),
                        ],
                      )),
                  MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PropertyListings()));

                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.business,
                              color: currentTab == 1
                                  ? Color.fromARGB(255, 157, 116, 229)
                                  : Colors.grey[600]),
                          Text(
                            "Properties",
                            style: TextStyle(
                                color: currentTab == 1
                                    ? Color.fromARGB(255, 157, 116, 229)
                                    : Colors.grey[600]),
                          ),
                        ],
                      )),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookmarkedPropertyListings()));
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bookmark,
                              color: currentTab == 2
                                  ? Color.fromARGB(255, 157, 116, 229)
                                  : Colors.grey[600]),
                          Text(
                            "Bookmarks",
                            style: TextStyle(
                                color: currentTab == 2
                                    ? Color.fromARGB(255, 157, 116, 229)
                                    : Colors.grey[600]),
                          ),
                        ],
                      )),
                  Container(
                    child: MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          _onItemTapped(3);
                          currentTab = 3;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person,
                                color: currentTab == 3
                                    ? Color.fromARGB(255, 157, 116, 229)
                                    : Colors.grey[600]),
                            Text(
                              "Profile",
                              style: TextStyle(
                                  color: currentTab == 3
                                      ? Color.fromARGB(255, 157, 116, 229)
                                      : Colors.grey[600]),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedIconTheme:
      //       const IconThemeData(color: Color.fromRGBO(0, 0, 0, 65)),
      //   selectedItemColor: const Color.fromRGBO(0, 0, 0, 65),
      //   elevation: 0,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: InkWell(
      //             onTap: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => HomePage()));
      //             },
      //             child: Icon(Icons.home)),
      //         label: ('Home'),
      //         backgroundColor: Color.fromRGBO(196, 196, 196, 26)),
      //     BottomNavigationBarItem(
      //       icon: InkWell(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => PropertyListings(),
      //               ),
      //             );
      //           },
      //           child: Icon(Icons.business)),
      //       label: ('Properties'),
      //       backgroundColor: Color.fromRGBO(196, 196, 196, 26),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: InkWell(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => AddProperty(),
      //             ),
      //           );
      //         },
      //         child: Icon(Icons.add_circle,
      //             size: 40, color: Colors.deepPurpleAccent),
      //       ),
      //       label: (''),
      //       backgroundColor: Color.fromRGBO(196, 196, 196, 26),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: InkWell(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => HomePage(),
      //               ),
      //             );
      //           },
      //           child: Icon(Icons.bookmark)),
      //       label: ('Bookmark'),
      //       backgroundColor: Color.fromRGBO(196, 196, 196, 26),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: ('Profile'),
      //       backgroundColor: Color.fromRGBO(196, 196, 196, 26),
      //     ),
      //   ],
      //   currentIndex: _selectedIndex, //New
      //   onTap: _onItemTapped, //New
      // )
    ));
  }

  void dispose() {
    super.dispose();
  }
}
