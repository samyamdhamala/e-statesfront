import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login/api/endpoint.dart';
import 'package:http/http.dart' as http;
import '../../../models/property_model.dart';
import '../../../token_shared_preferences.dart';
import '../../display_for_all_property/all_expanded_recommendation_card_listings.dart';

class DataSearch extends SearchDelegate<Future<Widget>> {
  Future<List<PropertyModel>> searchProperty() async {
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final Uri url = Uri.parse(searchPropertyEndpoint + '${query}');
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue,
    };

    final response = await http.get(url, headers: header);
    debugPrint('This is the response of search: ${response.body}');

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];
    if (response.statusCode == 200) {
      return data
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw UnimplementedError();
    }
  }

  List<PropertyModel>? getterData;
  Future<void> getData() async {
    getterData = await searchProperty();
    debugPrint('${getterData}');
  }

  final cities = [
    'Koteshwor',
    'Bhaktapur',
    'Pokhara',
    'Lalitpur',
    'Kathmandu',
    'Bhairahawa',
    'Thamel',
    'Tikathali',
    'Kupandole',
    'Kamaladi',
    'Kamalpokhari',
    'Baneswor',
    'Hattiban',
    'Harisiddhi',
  ];

  final recentCities = [
    'Thamel',
    'Tikathali',
    'Kupandole',
    'Kamaladi',
    'Kamalpokhari',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //leading icon topleft app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () => {
              Navigator.pop(context),
            });
  }

  @override
  Widget buildResults(BuildContext context) {
    //show results based on selection
    return Container(
      child: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (getterData == null) {
            return Container(
              child: Center(
                child: Text('No Data Found'),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: getterData?.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpandedRecommendationCard(
                    propertyModel: getterData![index]);
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
            text: TextSpan(
          text: suggestionList[index].substring(0, query.length),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: suggestionList[index].substring(query.length),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        )),
      ),
      itemCount: suggestionList.length,
    );
  }
}
