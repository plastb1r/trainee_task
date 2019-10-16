class User {
  final int id;
  final String name;
  final String email;
  final String city;
  final String street;
  final String phone;
  final String company;

  User(
      {this.city,
      this.company,
      this.email,
      this.id,
      this.name,
      this.phone,
      this.street});

  factory User.fromJson(Map<String, dynamic> json) => User(
        city: json['address']['city'] as String,
        company: json['company']['name'] as String,
        email: json['email'] as String,
        id: json['id'] as int,
        name: json['name'] as String,
        phone: json['phone'] as String,
        street: json['address']['street'] as String,
      );
}
