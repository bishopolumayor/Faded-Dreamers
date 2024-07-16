class UserModel {
  int userId;
  String username;
  String email;
  String? firstName;
  String? lastName;
  String? address;
  String? country;
  String? state;
  String? city;
  String? avatarUrl;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    this.address,
    this.country,
    this.state,
    this.city,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      address: json['address'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
      'country': country,
      'state': state,
      'city': city,
      'avatar_url': avatarUrl,
    };
  }
}
