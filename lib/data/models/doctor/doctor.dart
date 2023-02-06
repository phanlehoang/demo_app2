class Doctor {
  String email = 'Unknown';
  String password;
  String fullName;

  Doctor({
    required this.email,
    required this.password,
    required this.fullName,
  });
  //to Map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
    };
  }

  //from Map
  factory Doctor.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return unknownDoctor;
    }
    return Doctor(
      email: map['email'],
      password: map['password'],
      fullName: map['fullName'],
    );
  }
}

//unknown
Doctor unknownDoctor = Doctor(
  email: 'Unknown',
  password: 'Unknown',
  fullName: 'Unknown',
);
