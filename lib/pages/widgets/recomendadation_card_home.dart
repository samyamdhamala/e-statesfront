import 'package:flutter/material.dart';
import 'package:login/models/property_model.dart';
import '../property_details_page.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    Key? key,
    required this.propertyModel,
  }) : super(key: key);

  final PropertyModel propertyModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetails(propertyModel: propertyModel),
          ),
        );
      },
      child: Container(
        width: 180,
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
              child: Image(
                height: 120,
                width: double.infinity,
                image: AssetImage(propertyModel.thumbnail),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Text(
                    propertyModel.title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 12,
                      ),
                    ),
                    TextSpan(
                      text: propertyModel.streetaddress,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ])),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Rs ${propertyModel.price}/- only ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
//New
