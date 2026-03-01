class UserModel{
  final String uid;
  final String name;
  final String email;
  final String phone;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromMap(String uid, Map data){
    return UserModel(
        uid: uid,
        name: data['name'] ?? '',
        email: data ['email'] ?? '',
        phone: data ['Phone'] ?? '',
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
  }) {
    return UserModel(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }


}