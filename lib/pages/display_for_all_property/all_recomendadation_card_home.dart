import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login/models/property_model.dart';
import '../../api/endpoint.dart';
import '../../token_shared_preferences.dart';
import 'all_property_details_page.dart';

class RecommendationCard extends StatefulWidget {
  const RecommendationCard({
    Key? key,
    required this.propertyModel,
  }) : super(key: key);

  final PropertyModel propertyModel;

  @override
  State<RecommendationCard> createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<RecommendationCard> {
  var tokenValue;

  Future<String> getToken() async {
    tokenValue = await TokenSharedPrefernces.instance.getTokenValue("token");
    setState(() {
      tokenValue = tokenValue;
    });
    return tokenValue;
  }

  @override
  void initState() {
    super.initState();
    getToken();
    setState(() {});
  }

  Widget build(BuildContext context) {
    var images = json.decode(widget.propertyModel.image);
    List list = images ?? [];
    return GestureDetector(
      onTap: () {
        setState(() {});
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PropertyDetails(
                    propertyModel: widget.propertyModel,
                  )),
        );
      },
      child: Container(
        width: 190,
        padding: const EdgeInsets.symmetric(horizontal: 1),
        margin: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.50),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                '${baseUrl}${list[0]}',
                headers: {
                  "content-type": "application/json",
                  "Authorization": tokenValue,
                },
                height: 110,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.propertyModel.name,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
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
                        child: Icon(Icons.location_on,
                            size: 14, color: Colors.redAccent),
                      ),
                    ])),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Rs ${widget.propertyModel.price}/- only ",
                      style: TextStyle(
                        fontSize: 14,
                      ),
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
//New
