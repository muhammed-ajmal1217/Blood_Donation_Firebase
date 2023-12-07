class DataModel {
  String? name;
  String? age;
  String? phone;
  String? group;
  String? image;
  DataModel({
    required this.name,
    required this.age,
    required this.phone,
    required this.group,
    required this.image,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
        name: json["Name"],
        age: json['Age'],
        phone: json['Phone'],
        group: json['blood group'],
        image: json["image"],
        );
  }

  DataModel copyWith(
      {String? name, String? address, String? course, String? age}) {
    return DataModel(
        name: name ?? this.name,
        age: age ?? this.age,
        phone: phone ?? this.phone,
        group: group ?? this.group,
        image: image ?? this.image,
        
        );
  }

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Age": age,
      "Phone": phone,
      "blood group": group,
      "image": image
    };
  }
}