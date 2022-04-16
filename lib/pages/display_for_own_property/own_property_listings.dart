import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/pages/display_for_all_property/all_expanded_recommendation_card_listings.dart';
import 'package:login/pages/display_for_own_property/own_expanded_reccomendation_card.dart';
import '../../models/property_model.dart';
import '../../property_feature/get_own_property.dart';

class OwnPropertyListings extends StatefulWidget {
  const OwnPropertyListings({Key? key}) : super(key: key);

  @override
  State<OwnPropertyListings> createState() => _OwnPropertyListingsState();
}

class _OwnPropertyListingsState extends State<OwnPropertyListings> {
  List<PropertyModel>? getterData;
  Future<void> getData() async {
    getterData = await GetOwnProperty.getOwnProperty();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
    setState(() {
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Listings'),
        ),
        body: Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,  
            itemCount: getterData?.length,
            itemBuilder: (BuildContext context, int index) {
              debugPrint(
                  'This is the length of the getter: ${getterData?.length.toString()}');
              return OwnExpandedRecommendationCard(
                  propertyModel: getterData![index]);
            },
          ),
        ));
  }
}
