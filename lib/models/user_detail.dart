class UserDetail {
  UserDetail(
      {required this.userId,
      required this.email,
      required this.name,
      required this.achievement,
      required this.places,
      required this.food});

  final String userId, name, email;
  final int achievement;
  final List<String> places, food;

  static UserDetail fromMapPlaces(Map<String, dynamic> data, String id) =>
      UserDetail(
        userId: id,
        email: data['email'],
        name: data['name'],
        achievement: data['achievement'],
        places: data['places'],
        food: data['food'],
      );
}
