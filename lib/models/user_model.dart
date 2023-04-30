class UserModel {
  final String userId;
  final String fullname; // 3-70 char
  final String nickname; // 3-20 char
  final String email;
  final String phone;
  final String gender; // female, male, others
  final DateTime birthDate; // 2 options: 1.below 18 2. above 18
  final List<String> interests = []; // maximum 5
  final List<String> createdEvents = [];
  final List<String> joinedEvents = [];
  final int behaviorPoint = 3;

  UserModel({
    required this.userId,
    required this.fullname,
    required this.nickname,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthDate,
  });
}
