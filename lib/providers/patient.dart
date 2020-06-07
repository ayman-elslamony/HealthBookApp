import 'package:flutter/foundation.dart';

class Patient with ChangeNotifier {
  final String id;
  final String name;
  final String imageUrl;
  final String email;
  final String address;
  final dateOfBirth;
  final String gender;
  final String phoneNumber;

  Patient(
      {@required this.id,
      @required this.name,
      @required this.imageUrl,
  @required this.dateOfBirth,
      @required this.email,
      @required this.address,
      @required this.gender,
      @required this.phoneNumber});

  Future<void> addAcount({Patient doctor}) {
    //post data into firebase
  }
}
