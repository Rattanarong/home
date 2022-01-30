class UserModel {
  String? uid;
  String? username;
  String? phone;
  String? email;
  String? password;

  UserModel({this.uid, this.username, this.email, this.phone, this.password});

  // receiving data from sever
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        username: map['username'],
        email: map['email'],
        password: map['password'],
        phone: map['phone']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
      'phone': phone
    };
  }
}
