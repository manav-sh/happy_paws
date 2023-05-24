class DogModel {
  String id;
  String image;
  String address;
  String description;

  DogModel(
      {required this.id,
      required this.image,
      required this.address,
      required this.description});

  factory DogModel.fromJson(Map<String, dynamic> json) => DogModel(
        id: json['id'] ?? "",
        image: json['image'] ?? "",
        address: json['address'] ?? "",
        description: json['description'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "address": address,
        "description": description,
      };
}
