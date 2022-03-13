class PropertyModel {
  String title;
  String streetaddress;
  String city;
  String province;
  String area;
  String longitude;
  String latitude;
  String description;
  String thumbnail;
  List<String> images;
  int price;
  PropertyModel({
    required this.title,
    required this.streetaddress,
    required this.description,
    required this.city,
    required this.area,
    required this.province,
    required this.longitude,
    required this.latitude,
    required this.thumbnail,
    required this.images,
    required this.price,
  });
}

List<PropertyModel> properties = [
  PropertyModel(
    title: 'Penthouse Villa For Sale',
    streetaddress: "St. Second Avenue 780, NY",
    description:
        'Est pariatur pariatur nisi cupidatat deserunt incididunt enim eiusmod do minim exercitation. Exercitation mollit enim officia cupidatat occaecat quis cillum cupidatat consectetur ad. Amet in dolore occaecat labore non anim. Laborum anim occaecat eiusmod occaecat ut sit. Est excepteur Lorem culpa deserunt anim duis quis anim ea in tempor exercitation exercitation. Veniam magna pariatur irure commodo mollit ut irure. Tempor aute consequat in labore magna sunt et commodo ut cupidatat.',
    thumbnail: 'assets/images/properties/villa2.jpeg',
    images: [
      'assets/images/properties/villa1.jpeg',
      'assets/images/properties/villa2.jpeg',
      'assets/images/properties/villa3.jpeg'
    ],
    price: 3000000,
    city: 'New York',
    area: '500sqft',
    province: 'New York',
    longitude: '-73.9557413',
    latitude: '40.6552076',
  ),
  PropertyModel(
    title: 'Duplex Housing For Sale',
    streetaddress: "St. Second Avenue 780, NY",
    description:
        'Est pariatur pariatur nisi cupidatat deserunt incididunt enim eiusmod do minim exercitation. Exercitation mollit enim officia cupidatat occaecat quis cillum cupidatat consectetur ad. Amet in dolore occaecat labore non anim. Laborum anim occaecat eiusmod occaecat ut sit. Est excepteur Lorem culpa deserunt anim duis quis anim ea in tempor exercitation exercitation. Veniam magna pariatur irure commodo mollit ut irure. Tempor aute consequat in labore magna sunt et commodo ut cupidatat.',
    thumbnail: 'assets/images/properties/ap4.jpeg',
    images: [
      'assets/images/properties/ap2.jpeg',
      'assets/images/properties/ap7.jpeg',
      'assets/images/properties/ap6.jpeg'
    ],
    price: 50000000,
    city: 'New York',
    area: '500sqft',
    province: 'New York',
    longitude: '-73.9557413',
    latitude: '40.6552076',
  ),
  PropertyModel(
    title: 'Orchard House for Rent',
    streetaddress: "St. Second Avenue 780, NY",
    description:
        'Est pariatur pariatur nisi cupidatat deserunt incididunt enim eiusmod do minim exercitation. Exercitation mollit enim officia cupidatat occaecat quis cillum cupidatat consectetur ad. Amet in dolore occaecat labore non anim. Laborum anim occaecat eiusmod occaecat ut sit. Est excepteur Lorem culpa deserunt anim duis quis anim ea in tempor exercitation exercitation. Veniam magna pariatur irure commodo mollit ut irure. Tempor aute consequat in labore magna sunt et commodo ut cupidatat.',
    thumbnail: 'assets/images/properties/ap6.jpeg',
    images: [
      'assets/images/properties/ap4.jpeg',
      'assets/images/properties/ap5.jpeg',
      'assets/images/properties/ap6.jpeg'
    ],
    price: 6000000,
    city: 'New York',
    area: '500sqft',
    province: 'New York',
    longitude: '-73.9557413',
    latitude: '40.6552076',
  ),
];

class GetPost {
  final String message;
  final String data;

  GetPost({
    required this.message,
    required this.data,
  });

  factory GetPost.toJson(Map<String, dynamic> json) {
    return GetPost(
      message: json['message'],
      data: json['data'],
    );
  }
}
