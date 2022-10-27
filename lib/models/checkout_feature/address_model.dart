class AddressModel {
  final String title;
  final String address;
  AddressModel({required this.title, required this.address});
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(title: json['title'], address: json['address']);
  }
}
