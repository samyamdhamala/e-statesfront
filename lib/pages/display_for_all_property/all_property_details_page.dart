import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:line_icons/line_icons.dart';
import 'package:login/api/endpoint.dart';
import 'package:login/models/property_model.dart';
import 'package:login/pages/webviewtest.dart';
import 'package:login/property_feature/bookmark_property.dart';
import 'package:login/property_feature/get_owner_contact.dart';
import 'package:login/token_shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../property_feature/like_unlike_property.dart';

class PropertyDetails extends StatefulWidget {
  final PropertyModel propertyModel;
  const PropertyDetails({Key? key, required this.propertyModel})
      : super(key: key);

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  String? _userName;
  String? _lastName;
  String? _phoneNumber;
  String? _ownerFirstName;
  String? _ownerLastName;
  String? _ownerEmail;
  String? _ownerPhone;
  DateTime date = DateTime(2022, 4, 13);

  var tokenValue;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> userDetails = {};
  @override
  void initState() {
    super.initState();
    setUserName();
    getOwnerContact();
  }

  // function to get the requester name and contact details
  Future<void> setUserName() async {
    final prefs =
        await TokenSharedPrefernces.instance.getNameValue('firstName');
    final lastPrefs =
        await TokenSharedPrefernces.instance.getNameValue('lastName');
    final phoneprefs =
        await TokenSharedPrefernces.instance.getNameValue('phonenumber');

    setState(() {
      _userName = prefs;
      _lastName = lastPrefs;
      _phoneNumber = phoneprefs;
    });
  }
    TextEditingController _date = new TextEditingController();
  Future<dynamic> getOwnerContact() async {
    userDetails = await GetOwnerContact.getOwnerContact(
        widget.propertyModel.customer_id.toString());
    setState(() {
      _ownerFirstName = userDetails['firstName'];
      _ownerLastName = userDetails['lastName'];
      _ownerEmail = userDetails['email'];
      _ownerPhone = userDetails['phonenumber'];
    });
  }


  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                                    style:
                                        Theme.of(context).textTheme.subtitle2!),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: LikeButton(
                                size: 30,
                                isLiked: widget.propertyModel.hasLiked,
                                likeCount: widget.propertyModel.likes,
                                circleColor: CircleColor(
                                  start: Color.fromARGB(255, 219, 57, 46),
                                  end: Color.fromARGB(255, 219, 57, 46),
                                ),
                                bubblesColor: BubblesColor(
                                  dotPrimaryColor:
                                      Color.fromARGB(255, 219, 57, 46),
                                  dotSecondaryColor:
                                      Color.fromARGB(255, 219, 57, 46),
                                ),
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.favorite,
                                    color: isLiked
                                        ? Color.fromARGB(255, 219, 57, 46)
                                        : Colors.grey,
                                    size: 30,
                                  );
                                },
                                countBuilder:
                                    (count, bool isLiked, String text) {
                                  var color = isLiked
                                      ? Color.fromARGB(255, 219, 57, 46)
                                      : Colors.grey;
                                  Widget result;
                                  if (count == 0) {
                                    result = Text(
                                      "Like",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14, color: color),
                                    );
                                  } else
                                    result = Text(
                                      count.toString(),
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14, color: color),
                                    );
                                  return result;
                                },
                                onTap: (isLiked) async {
                                  var response = await LikeUnlikeProperty
                                      .likeUnlikePropertyInit(
                                          widget.propertyModel.id.toString(),
                                          isLiked);
                                  if (response.values == 200) {
                                    setState(() {
                                      widget.propertyModel.hasLiked = isLiked;
                                      widget.propertyModel.likes =
                                          widget.propertyModel.likes +
                                              (isLiked ? 1 : -1);
                                    });
                                  }
                                  return !isLiked;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              specWidget(context, LineIcons.areaChart,
                                  widget.propertyModel.area),
                              specWidget(
                                context,
                                LineIcons.indianRupeeSign,
                                "Rs. ${widget.propertyModel.price}",
                              ),
                              specWidget(context, LineIcons.eye,
                                  widget.propertyModel.status),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32,
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
                                  style: Theme.of(context).textTheme.headline6),
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
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(4, 4),
                            blurRadius: 20,
                            spreadRadius: 4,
                          )
                        ],
                      ),
                      height: 55,
                      width: 55,
                      child: LikeButton(
                        isLiked: widget.propertyModel.hasBookmarked,
                        size: 29,
                        circleColor: CircleColor(
                          start: Colors.deepPurple,
                          end: Colors.deepPurple.withOpacity(0.5),
                        ),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Colors.deepPurple,
                          dotSecondaryColor: Colors.deepPurple.withOpacity(0.5),
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.bookmark,
                            size: 32,
                            color:
                                isLiked ? Colors.deepPurple[400] : Colors.grey,
                          );
                        },
                        onTap: (isLiked) async {
                          var response = await BookmarkUnbookmarkProperty
                              .bookmarkUnbookmarkPropertyInit(
                                  widget.propertyModel.id.toString(), isLiked);
                          if (response.values == 200) {
                            setState(() {
                              widget.propertyModel.hasBookmarked = isLiked;
                            });
                          }
                          return !isLiked;
                        },
                      ),
                    ),
                    Container(
                      // padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                            offset: const Offset(4, 4),
                            blurRadius: 20,
                            spreadRadius: 4,
                          )
                        ],
                      ),
                      height: 55,
                      width: 55,
                      child: GestureDetector(
                        onTap: () async {
                          final phoneNumber = '+977${_ownerPhone}';
                          final url = 'tel:$phoneNumber';

                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Icon(
                          LineIcons.phone,
                          size: 30,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () async {
                    //     final toEmail = _ownerEmail;
                    //     final subject =
                    //         'Permission to visit site for Inspection';
                    //     final body =
                    //         'Dear Sir/Madam,\n\nI would like to visit your site for inspection. Please provide me with a viable time for inspection.\n\nRegards,\n$_userName $_lastName';
                    //     final url =
                    //         'mailto:$toEmail?subject=$subject&body=$body';

                    //     if (await canLaunch(url)) {
                    //       await launch(url);
                    //     } else {
                    //       throw 'Could not launch $url';
                    //     }
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.all(12),
                    //     margin: const EdgeInsets.only(right: 8),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(12),
                    //       border: Border.all(
                    //         color: Colors.black.withOpacity(0.3),
                    //       ),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.black.withOpacity(0.1),
                    //           offset: const Offset(4, 4),
                    //           blurRadius: 20,
                    //           spreadRadius: 4,
                    //         )
                    //       ],
                    //     ),
                    //     height: 55,
                    //     width: 55,
                    //     child: const Icon(
                    //       LineIcons.envelopeAlt,
                    //       color: Colors.black,
                    //       size: 30,
                    //     ),
                    //   ),
                    // ),
                    SpeedDial(
                      label: Text('     More Options'),
                      animatedIcon: AnimatedIcons.list_view,
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(234, 126, 117, 241),
                      overlayColor: Colors.black,
                      overlayOpacity: 0.7,
                      spaceBetweenChildren: 12,
                      spacing: 15,
                      childrenButtonSize: const Size(80, 80),
                      children: [
                        SpeedDialChild(
                          child: Icon(
                            Icons.call,
                            size: 30,
                            color: Colors.white,
                          ),
                          backgroundColor: Color.fromARGB(223, 2, 170, 16),
                          label: "Call Owner",
                          onTap: () async {
                            final phoneNumber = '+977${_ownerPhone}';
                            final url = 'tel:$phoneNumber';

                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        SpeedDialChild(
                          child: Icon(
                            Icons.sms,
                            size: 30,
                            color: Colors.white,
                          ),
                          backgroundColor: Color.fromARGB(223, 240, 205, 11),
                          label: "Send Sms",
                          onTap: () async {
                            final phoneNumber = '+977${_ownerPhone}';
                            final url = 'sms:$phoneNumber';

                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        // SpeedDialChild(
                        //   onTap: () async {
                        //     final toEmail = _ownerEmail;
                        //     final subject =
                        //         'Permission to visit site for Inspection';
                        //     final body =
                        //         'Dear Sir/Madam,\n\nI would like to visit your site for inspection. Please provide me with a viable time for inspection.\n\nRegards,\n$_userName $_lastName';
                        //     final url =
                        //         'mailto:$toEmail?subject=$subject&body=$body';

                        //     if (await canLaunch(url)) {
                        //       await launch(url);
                        //     } else {
                        //       throw 'Could not launch $url';
                        //     }
                        //   },
                        //   child: Icon(
                        //     Icons.mail,
                        //     size: 30,
                        //     color: Colors.white,
                        //   ),
                        //   backgroundColor: Color.fromARGB(255, 60, 141, 218),
                        //   label: "Request for Inspection",
                        // ),
                        SpeedDialChild(
                          child: Icon(
                            Icons.mail,
                            size: 30,
                            color: Colors.white,
                          ),
                          backgroundColor: Color.fromARGB(255, 60, 141, 218),
                          label: "Request for Inspection",
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Stack(
                                      clipBehavior: Clip.none,
                                      children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Inspection Date',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  controller: _date,
                                                  autocorrect: false,
                                                  validator: RequiredValidator(
                                                      errorText:
                                                          "Please enter a valid date."),
                                                  onTap: () async {
                                                    DateTime? newDate =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime(2023),
                                                    );
                                                    //if cancel null is returned
                                                    if (newDate == null) return;

                                                    //if newDate is not null then set the date
                                                    setState(() {
                                                      date = newDate;
                                                      print(date.toString());
                                                      // _date.value = TextEditingValue(text: date.toString());
                                                      _date.text =
                                                          DateFormat.yMd()
                                                              .format(date);
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: 'Pick a Date',
                                                    suffixIcon: Icon(
                                                      Icons.calendar_today,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                    child: Text("Send Request"),
                                                    onPressed: () async {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        var inspectiondate =
                                                            _date.text
                                                                .toString();

                                                        final toEmail =
                                                            _ownerEmail;
                                                        final subject =
                                                            'Permission to visit site for Inspection';
                                                        final body =
                                                            'Dear Sir/Madam,\n\nI would like to visit your site \n(${widget.propertyModel.name}) \nlocated at ${widget.propertyModel.streetaddress} \nfor inspection on $inspectiondate . \n\nPlease provide me with a viable time for inspection.\n\nRegards,\n$_userName $_lastName \n$_phoneNumber';
                                                        final url =
                                                            'mailto:$toEmail?subject=$subject&body=$body';

                                                        if (await canLaunch(
                                                            url)) {
                                                          await launch(url);
                                                        } else {
                                                          throw 'Could not launch $url';
                                                        }
                                                        _date.clear();
                                                      }
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                        )
                      ],
                    ),

                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () async {
                    //       final phoneNumber = '+977${_ownerPhone}';
                    //       final url = 'tel:$phoneNumber';

                    //       if (await canLaunch(url)) {
                    //         await launch(url);
                    //       } else {
                    //         throw 'Could not launch $url';
                    //       }
                    //     },
                    //     child: Container(
                    //       padding: const EdgeInsets.all(12),
                    //       margin: const EdgeInsets.only(right: 8),
                    //       decoration: BoxDecoration(
                    //         color: Color.fromARGB(221, 117, 82, 212),
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       child: Center(
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Icon(
                    //               LineIcons.phone,
                    //               color: Colors.white,
                    //               size: 30,
                    //             ),
                    //             SizedBox(
                    //               width: 2,
                    //             ),
                    //             Text(
                    //               "Contact Now",
                    //               style: Theme.of(context)
                    //                   .textTheme
                    //                   .subtitle2!
                    //                   .copyWith(
                    //                     color: Colors.white,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            )
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
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 136, 131, 204),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, size: 26, color: Colors.white),
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
    debugPrint("This is the token VALUE ${tokenValue}");
    setState(() {
      tokenValue = tokenValue;
    });
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
