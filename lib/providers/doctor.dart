import 'package:flutter/foundation.dart';

class Doctor with ChangeNotifier {
  final String id;
  final String name;
  final String imageUrl;
  final String email;
  final String location;
  final String specialist;
  final DateTime startWork;
  final DateTime endWork;
  final String holidayDay;
  final String gender;
  final String phoneNumber;
  final dateOfBirth;
  bool status = false;
  double rate = 0.0;

  Doctor(
      {@required this.id,
      @required this.name,
      @required this.email,
      @required this.imageUrl,
      @required this.specialist,
      @required this.location,
        @required this.dateOfBirth,
      @required this.startWork,
      @required this.endWork,
      @required this.holidayDay,
      @required this.gender,
      @required this.phoneNumber});

  Future<void> addAcount({Doctor doctor}) {
    //post data into firebase
  }

  Future<void> changeStatus({String token}) async {
    final oldStatus = status;

    try {
      if (token != null) {
        status = !status;

        //update for status remeber await
      }
    } catch (e) {
      status = oldStatus;
    }
    notifyListeners();
  }
}
