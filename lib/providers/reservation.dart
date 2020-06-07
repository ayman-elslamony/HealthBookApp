import 'package:flutter/foundation.dart';

class Reservation with ChangeNotifier {
  final String id; //get that from userId+1 || userId+totalVisits
  final DateTime lastVisit;
  final DateTime nextVisit;
  final String patientName;
  int totalVisits = 0;

  Reservation(
      {@required this.id,
      @required this.lastVisit,
      @required this.nextVisit,
      @required this.patientName,
      @required this.totalVisits});
}
