class PropertyModel {
  int id;
  int customer_id;
  String name;
  String description;
  String streetaddress;
  String city;
  String province;
  String area;
  int price;
  String image;
  String type;
  String longitude;
  String latitude;
  String status;
  int likes;
  bool hasLiked;
  bool hasBookmarked;

  PropertyModel({
    required this.id,
    required this.customer_id,
    required this.name,
    required this.description,
    required this.streetaddress,
    required this.city,
    required this.province,
    required this.area,
    required this.price,
    required this.image,
    required this.type,
    required this.longitude,
    required this.latitude,
    required this.status,
    required this.likes,
    required this.hasLiked,
    required this.hasBookmarked,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      customer_id: json['customer_id'],
      name: json['name'],
      description: json['description'],
      streetaddress: json['streetaddress'],
      city: json['city'],
      province: json['province'],
      area: json['area'],
      price: json['price'],
      image: json['image'],
      type: json['type'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      status: json['status'],
      likes: json['likes'],
      hasLiked: json['hasLiked'],
      hasBookmarked: json['hasBookmarked'],
    );
  }
}
