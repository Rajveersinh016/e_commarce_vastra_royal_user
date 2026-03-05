class UserModel{
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String profileImage;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
  });

  factory UserModel.fromMap(String uid, Map data){
    return UserModel(
      uid: uid,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['Phone'] ?? '',
      profileImage: data['profileImage'] ?? '',
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? profileImage,
  }) {
    return UserModel(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}