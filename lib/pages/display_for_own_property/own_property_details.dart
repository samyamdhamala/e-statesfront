import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:login/models/property_model.dart';
import 'package:login/pages/display_for_own_property/update_own_property_form.dart';
import 'package:login/pages/webviewtest.dart';
import 'package:login/property_feature/get_owner_contact.dart';
import 'package:login/token_shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/endpoint.dart';
import '../../property_feature/delete_own_property.dart';
import 'own_property_listings.dart';

class OwnPropertyDetails extends StatefulWidget {
  final PropertyModel propertyModel;
  const OwnPropertyDetails({Key? key, required this.propertyModel})
      : super(key: key);

  @override
  State<OwnPropertyDetails> createState() => _OwnPropertyDetailsState();
}

class _OwnPropertyDetailsState extends State<OwnPropertyDetails> {
  String? _ownerFirstName;
  String? _ownerLastName;
  String? _ownerEmail;
  String? _ownerPhone;
  var tokenValue;
  Map<String, dynamic> userDetails = {};
  @override
  void initState() {
    super.initState();
    getOwnerContact();
  }

  Future<dynamic> getOwnerContact() async {
    userDetails = await GetOwnerContact.getOwnerContact(
        widget.propertyModel.customer_id.toString());
    debugPrint('This is phone: ${_ownerPhone}');
    setState(() {
      _ownerFirstName = userDetails['firstName'];
      _ownerLastName = userDetails['lastName'];
      _ownerEmail = userDetails['email'];
      _ownerPhone = userDetails['phonenumber'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 30),
          child: SpeedDial(
            icon: Icons.more_vert,
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(234, 126, 117, 241),
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            spaceBetweenChildren: 12,
            spacing: 15,
            children: [
              SpeedDialChild(
                child: Icon(Icons.edit),
                backgroundColor: Color.fromARGB(255, 145, 212, 151),
                label: "Edit",
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProperty(
                              property: widget.propertyModel,
                            )),
                  );
                },
              ),
              SpeedDialChild(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete Property"),
                          content: Text(
                              "Are you sure you want to delete this property?"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("Yes"),
                              onPressed: () async {
                                dynamic data = await DeleteOwnProperty(
                                  property: widget.propertyModel.id.toString(),
                                ).deleteOwnProperty();
                                debugPrint("This is data ${data}");
                                if (data == "success") {
                                  debugPrint("This is data ${data}");
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new OwnPropertyListings()));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Deleted Successfully'),
                                    ),
                                  );
                                }
                              },
                            ),
                            TextButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Icon(Icons.delete),
                backgroundColor: Color.fromARGB(255, 230, 104, 104),
                label: "Delete",
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselwithIndicatorDemo(
                    propertyModel: widget.propertyModel,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.propertyModel.name,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  LineIcons.mapMarker,
                                  color: Colors.deepPurple,
                                ),
                                Text(
                                  widget.propertyModel.streetaddress
                                          .toString() +
                                      ', ' +
                                      widget.propertyModel.city.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(),
                                ),
                              ],
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: '${widget.propertyModel.likes} Likes  ',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              WidgetSpan(
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                              ),
                            ])),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              specWidget(
                                context,
                                LineIcons.dollarSign,
                                "Rs ${widget.propertyModel.price}/- only",
                              ),
                              specWidget(
                                context,
                                LineIcons.areaChart,
                                widget.propertyModel.area,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.deepPurple.withOpacity(0.22),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Divider(
                                color: Colors.deepPurple,
                              ),
                              Text(
                                widget.propertyModel.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      letterSpacing: 1.1,
                                      height: 1.4,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.deepPurple.withOpacity(0.22),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18)),
                              Divider(
                                color: Colors.deepPurple,
                              ),
                              Tooltip(
                                message: 'Double tap to Open',
                                preferBelow: false,
                                child: InkWell(
                                  onDoubleTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WebViewTest(
                                              propertyModel:
                                                  widget.propertyModel),
                                        ));
                                  },
                                  child: Container(
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    decoration:
                                        BoxDecoration(color: Colors.green),
                                    child: Image(
                                        image: AssetImage(
                                            "assets/images/googlemaps.png"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap: () async {
                                  final url =
                                      'https://www.google.com/maps/search/?api=1&query=${widget.propertyModel.latitude},${widget.propertyModel.longitude}';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      LineIcons.mapMarker,
                                      color: Colors.deepPurple,
                                    ),
                                    Text(
                                      "Open in Google Maps",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                            letterSpacing: 1.1,
                                            height: 1.4,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.deepPurple,
                                          ),
                                    ),
                                  ],
                                ),
                              ),

                              // WebView(
                              //   initialUrl:
                              //       'https://www.google.com/maps/search/?api=1&query=${widget.propertyModel.latitude},${widget.propertyModel.longitude}',
                              //   javascriptMode: JavascriptMode.unrestricted,
                              // )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.deepPurple.withOpacity(0.22),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Owner Details",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Divider(
                                color: Colors.deepPurple,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    LineIcons.user,
                                    color: Colors.deepPurple,
                                  ),
                                  Text(
                                    '    ${_ownerFirstName} ${_ownerLastName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          letterSpacing: 1.1,
                                          height: 1.4,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    LineIcons.envelope,
                                    color: Colors.deepPurple,
                                  ),
                                  Text(
                                    '   ${_ownerEmail}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          letterSpacing: 1.1,
                                          height: 1.4,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    LineIcons.phone,
                                    color: Colors.deepPurple,
                                  ),
                                  Text(
                                    '   ${_ownerPhone}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          letterSpacing: 1.1,
                                          height: 1.4,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
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
  }

  Widget specWidget(BuildContext context, IconData iconData, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 136, 131, 204),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, size: 24, color: Colors.white),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}

class CarouselwithIndicatorDemo extends StatefulWidget {
  final PropertyModel propertyModel;
  const CarouselwithIndicatorDemo({
    Key? key,
    required this.propertyModel,
  }) : super(key: key);

  @override
  _CarouselwithIndicatorDemoState createState() =>
      _CarouselwithIndicatorDemoState();
}

class _CarouselwithIndicatorDemoState extends State<CarouselwithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  var tokenValue;

  Future<String> getToken() async {
    tokenValue = await TokenSharedPrefernces.instance.getTokenValue("token");
    setState(() {
      tokenValue = tokenValue;
    });
    debugPrint(tokenValue);
    return tokenValue;
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    var images = json.decode(widget.propertyModel.image);
    List list = images;
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: list
              .map((item) => Image.network(
                    '${baseUrl}${item}',
                    headers: {
                      "content-type": "application/json",
                      "Authorization": tokenValue, //this is the token value
                    },
                    fit: BoxFit.cover,
                    width: 1000,
                  ))
              .toList(),
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.3,
            autoPlay: true,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: list.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                width: 12,
                height: _current == entry.key ? 6 : 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(
                    _current == entry.key ? 0.5 : 0.2,
                  ),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
