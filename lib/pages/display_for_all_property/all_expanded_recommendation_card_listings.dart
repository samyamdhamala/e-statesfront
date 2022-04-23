import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login/property_feature/get_all_property.dart';
import '../../api/endpoint.dart';
import '../../models/property_model.dart';
import '../../token_shared_preferences.dart';
import 'all_property_details_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandedRecommendationCard extends StatefulWidget {
  final PropertyModel propertyModel;
  const ExpandedRecommendationCard({Key? key, required this.propertyModel})
      : super(key: key);

  @override
  State<ExpandedRecommendationCard> createState() =>
      _ExpandedRecommendationCardState();
}

class _ExpandedRecommendationCardState
    extends State<ExpandedRecommendationCard> {
  var tokenValue;

  List<PropertyModel>? getterData;
  Future<void> getData() async {
    getterData = await GetAllProperty.getAllProperty();
    debugPrint(getterData.toString());
    setState(() {});
  }

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
    getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var images = json.decode(widget.propertyModel.image);
    List list = images;
    String status = '${widget.propertyModel.status}';

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PropertyDetails(
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
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '${baseUrl}${list[0]}',
                  headers: {
                    "content-type": "application/json",
                    "Authorization": tokenValue,
                  },
                  height: 120,
                  width: 125,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: status == 'For Rent'
                        ? Colors.blue[800]
                        : Colors.green[600],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      status,
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.propertyModel.name,
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
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
                          color: Color.fromARGB(255, 219, 57, 46),
                          size: 16,
                        ),
                      ),
                    ])),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs. ${widget.propertyModel.price}/- only ",
                          style: Theme.of(context).textTheme.headline5!,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
