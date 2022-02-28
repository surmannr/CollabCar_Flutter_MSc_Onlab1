class User {
  final int id;
  final String email;
  final String password;
  final String name;
  final String telephone;
  final DateTime birthDate;
  final bool hasCarpoolService;
  final String imageUrl;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.telephone,
    required this.birthDate,
    required this.hasCarpoolService,
    required this.imageUrl,
  });
}
