class KedaiModel {
  int id;
  String name;
  int userId;
  String address;
  String phoneNumber;

  KedaiModel({
    this.id,
    this.name,
    this.userId,
    this.address,
    this.phoneNumber,
  });

  KedaiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    address = json['address'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
      'address': address,
      'phone_number': phoneNumber,
    };
  }
}
