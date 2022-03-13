import 'package:flutter/material.dart';
import 'package:login/models/property_model.dart';
import 'package:login/pages/add_new_property_page.dart';
import 'package:login/pages/widgets/drawer.dart';
import 'package:login/pages/widgets/recomendadation_card_home.dart';
import 'package:login/property_feature/all_property_get_method.dart';
import 'package:login/token_shared_preferences.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic>? userData;
  HomePage({Key? key, this.userData}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _userName;
  String? _email;

  Future<void> setUserName() async {
    final prefs = await TokenSharedPrefernces.instance.getNameValue('userName');
    debugPrint("This is the prefs ${prefs}");
    final emailPrefs =
        await TokenSharedPrefernces.instance.getNameValue('email');
    debugPrint("This is the email ${emailPrefs}");
    setState(() {
      _userName = prefs;
      _email = emailPrefs;
    });
  }

  //New

  int _selectedIndex = 2;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void _onItemTapped(int index) {
    if (index == 4) {
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
  void initState() {
    super.initState();
    setUserName();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _drawerKey,
          endDrawer: MyDrawer(
            userName: _userName.toString(),
            userEmail: _email.toString(),
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
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
                    child: const Text('Post Property'),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddProperty())),
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(108, 99, 255, 100),
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(207, 206, 206, 100),
                    hintText: 'Search Area, City or Property',
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      text: greetingMessage(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: _userName == null ? 'Guest' : _userName,
                          // text: widget.userData!['firstName'].toString(),

                          style: TextStyle(
                              color: Color(0xff4d3a58),
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        )
                      ]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: const [
                    Text(
                      "Explore E-States Nepal",
                      style: TextStyle(
                        color: Color.fromRGBO(93, 83, 253, 1),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "SEE ALL",
                      style: TextStyle(
                        color: Color(0xfff63e3c),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: properties.length,
                  itemBuilder: (BuildContext context, int index) {
                    final PropertyModel propertyModel = properties[index];
                    return RecommendationCard(propertyModel: propertyModel);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: const [
                    Text(
                      "Categories:",
                      style: TextStyle(
                        color: Color.fromRGBO(93, 83, 253, 1),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff857EF5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.house,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
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
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff857EF5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.landscape_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
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
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff857EF5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.apps,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
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
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedIconTheme:
                const IconThemeData(color: Color.fromRGBO(0, 0, 0, 65)),
            selectedItemColor: const Color.fromRGBO(0, 0, 0, 65),
            elevation: 0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: ('Home'),
                  backgroundColor: Color.fromRGBO(196, 196, 196, 26)),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: ('Properties'),
                backgroundColor: Color.fromRGBO(196, 196, 196, 26),
              ),
              BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProperty(),
                      ),
                    );
                  },
                  child: Icon(Icons.add_circle,
                      size: 40, color: Colors.deepPurpleAccent),
                ),
                label: (''),
                backgroundColor: Color.fromRGBO(196, 196, 196, 26),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: ('Favorite'),
                backgroundColor: Color.fromRGBO(196, 196, 196, 26),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: ('Profile'),
                backgroundColor: Color.fromRGBO(196, 196, 196, 26),
              ),
            ],
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped, //New
          )),
    );
  }

  void dispose() {
    super.dispose();
  }
}
