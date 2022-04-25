import 'package:flutter/material.dart';
import 'package:login/property_feature/get_own_property.dart';

import '../../models/property_model.dart';
import 'all_expanded_recommendation_card_listings.dart';

class BookmarkedPropertyListings extends StatefulWidget {
  const BookmarkedPropertyListings({Key? key}) : super(key: key);

  @override
  State<BookmarkedPropertyListings> createState() =>
      _BookmarkedPropertyListingsState();
}

//getbookmarked property function calls data from api
class _BookmarkedPropertyListingsState
    extends State<BookmarkedPropertyListings> {
  List<PropertyModel>? getterData;
  Future<void> getData() async {
    getterData = await GetOwnProperty.getBookmarkedProperty();
    setState(() {});
  }

//initialize the state
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bookmarked Properties'),
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
