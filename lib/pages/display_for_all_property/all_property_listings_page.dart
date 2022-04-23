import 'package:flutter/material.dart';
import 'package:login/pages/display_for_all_property/all_expanded_recommendation_card_listings.dart';
import '../../models/property_model.dart';
import '../../property_feature/get_all_property.dart';

class PropertyListings extends StatefulWidget {
  const PropertyListings({Key? key}) : super(key: key);

  @override
  State<PropertyListings> createState() => _PropertyListingsState();
}

class _PropertyListingsState extends State<PropertyListings> {
  List<PropertyModel>? getterData;
  Future<void> getData() async {
    getterData = await GetAllProperty.getAllProperty();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All Property Listings'),
        ),
        body: Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: getterData?.length,
            itemBuilder: (BuildContext context, int index) {
              debugPrint(
                  'This is the length of the getter: ${getterData?.length.toString()}');
              return ExpandedRecommendationCard(
                  propertyModel: getterData![index]);
            },
          ),
        ));
  }
}
