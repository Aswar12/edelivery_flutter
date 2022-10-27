class UserLocationModel {
  int id;
  String customerName;
  String address;
  String latitude;
  String longitude;
  String addresType;
  String phoneNumber;
  DateTime createdAt;
  DateTime updatedAt;

  UserLocationModel({
    this.id,
    this.customerName,
    this.address,
    this.longitude,
    this.latitude,
    this.addresType,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
  });

  UserLocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    customerName = json['customer_name'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    addresType = json['addres_type'];
    phoneNumber = json['phone_number'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_name': customerName,
      'address': address,
      'longitude': longitude,
      'addres_type': addresType,
      'latitude': latitude,
      'phone_number': phoneNumber,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
