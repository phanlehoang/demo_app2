// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

import 'enum/enums.dart';

class Profile {
  String id = 'Unknown';
  String name = 'Unknown';
  num weight = 0;
  //height
  num height = 0;
  DateTime birthday;
  String address = '';
  String phone = '';
  Gender gender;
  ProcedureType procedureType;
  String room;
  String currentProcedureId;

  Profile({
    this.id = 'Unknown',
    this.name = 'Unknown',
    this.weight = 0,
    this.currentProcedureId = 'Unknown',
    required this.height,
    required this.birthday,
    required this.address,
    required this.phone,
    required this.gender,
    this.procedureType = ProcedureType.Unknown,
    required this.room,
  });
  //toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'height': height,
      'currentProcedureId': currentProcedureId,
      'birthday':
          //TimeStamp to DateTime
          birthday,
      'address': address,
      'phone': phone,
      'gender': EnumToString.genderToString(gender),
      'procedureType': EnumToString.enumToString(procedureType),
      'room': room,
    };
  }

  //fromMap
  factory Profile.fromMap(Map<String, dynamic>? map) {
    if (map == null) return unknownProfile();
    return Profile(
        id: map['id'] != null ? map['id'] : 'Unknown',
        name: map['name'],
        weight: map['weight'],
        height: map['height'],
        currentProcedureId: map['currentProcedureId'] != null
            ? map['currentProcedureId']
            : 'Unknown',
        birthday: map['birthday'].toDate(),
        address: map['address'],
        phone: map['phone'],
        gender: StringToEnum.stringToGender(map['gender']),
        procedureType: StringToEnum.stringToProcedureType(map['procedureType']),
        room: map['room']);
  }
  Profile clone() {
    return Profile(
      id: id,
      name: name,
      weight: weight,
      height: height,
      birthday: birthday,
      address: address,
      phone: phone,
      gender: gender,
      procedureType: procedureType,
      room: room,
      currentProcedureId: currentProcedureId,
    );
  }

  DocumentReference ref() {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(room)
        .collection('patients')
        .doc(id);
  }

  DocumentReference regimenStateStream() {
    return ref()
        .collection('procedureTypes')
        .doc('Sonde')
        .collection('regimen')
        .doc('state');
  }

  //toString
  @override
  String toString() {
    return ''' 
    id: $id,
    name: $name,
    weight: $weight,
    height: $height,
    birthday: $birthday,
    address: $address,
    currentProcedureId: $currentProcedureId,
    procedureType: $procedureType,
    ''';
  }
}

Profile unknownProfile() {
  return Profile(
    height: 170,
    birthday: DateTime(1999),
    address: 'VN',
    phone: '123',
    gender: Gender.Female,
    procedureType: ProcedureType.Unknown,
    room: 'Unknown',
  );
}
