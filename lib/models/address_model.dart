class AddressModel {

  final String id;
  final String name;
  final String phone;
  final String line1;
  final String line2;
  final String city;
  final String state;
  final String zipcode;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.line1,
    required this.line2,
    required this.city,
    required this.state,
    required this.zipcode,
    this.isDefault = false,
  });

  Map<String,dynamic> toJson(){
    return {
      "name": name,
      "phone": phone,
      "line1": line1,
      "line2": line2,
      "city": city,
      "state": state,
      "zipcode": zipcode,
      "isDefault": isDefault,
    };
  }

  factory AddressModel.fromMap(String id, Map data){
    return AddressModel(
      id: id,
      name: data["name"] ?? "",
      phone: data["phone"] ?? "",
      line1: data["line1"] ?? "",
      line2: data["line2"] ?? "",
      city: data["city"] ?? "",
      state: data["state"] ?? "",
      zipcode: data["zipcode"] ?? "",
      isDefault: data["isDefault"] ?? false,
    );
  }

}