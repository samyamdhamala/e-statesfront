import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/api/endpoint.dart';
import 'package:login/pages/display_for_own_property/own_property_details.dart';
import 'package:login/pages/display_for_own_property/own_property_listings.dart';
import 'package:login/pages/display_for_own_property/update_own_property_form.dart';
import 'package:login/property_feature/delete_own_property.dart';
import 'dart:convert';
import '../../models/property_model.dart';
import '../../token_shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class OwnExpandedRecommendationCard extends StatefulWidget {
  const OwnExpandedRecommendationCard({Key? key, required this.propertyModel})
      : super(key: key);

  final PropertyModel propertyModel;

  @override
  State<OwnExpandedRecommendationCard> createState() =>
      _OwnExpandedRecommendationCardState();
}

class _OwnExpandedRecommendationCardState
    extends State<OwnExpandedRecommendationCard> {
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var images = json.decode(widget.propertyModel.image);
    List list = images;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OwnPropertyDetails(
                    propertyModel: widget.propertyModel,
                  )),
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.20),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '${baseUrl}${list[0]}',
                headers: {
                  "content-type": "application/json",
                  "Authorization": tokenValue,
                },
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.propertyModel.name,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: widget.propertyModel.streetaddress +
                            ', ' +
                            widget.propertyModel.city,
                        style: Theme.of(context).textTheme.subtitle2!,
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 16,
                        ),
                      ),
                    ])),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Rs. ${widget.propertyModel.price}/- only ",
                      style: GoogleFonts.lato(
                        color: Colors.deepPurpleAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  )
                ];
              },
              onSelected: (String value) {
                if (value == 'edit') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProperty(
                              property: widget.propertyModel,
                            )),
                  );
                } else if (value == 'delete') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete Property"),
                        content: Text(
                            "Are you sure you want to delete this property?"),
                        actions: [
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () async {
                              dynamic data = await DeleteOwnProperty(
                                property: widget.propertyModel.id.toString(),
                              ).deleteOwnProperty();
                              debugPrint("This is data ${data}");
                              if (data == "success") {
                                Fluttertoast.showToast(
                                    msg: "Deleted Sucessfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red[200],
                                    textColor: Colors.black,
                                    fontSize: 14.0);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OwnPropertyListings()),
                                );
                              }
                            },
                          ),
                          TextButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
