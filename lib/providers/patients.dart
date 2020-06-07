import 'package:flutter/foundation.dart';

import './patient.dart';


class Patients with ChangeNotifier{
  final String userId;

  Patients({@required this.userId});

  List<Patient> _patientsList =[];

  List<Patient> get patients {
    return [..._patientsList];
  }
  Patient findById(String id) {
    return _patientsList.firstWhere((prod) => prod.id == id);
  }
  Future<void> getPatients({String location , String specialist}) async {

//    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
//    var url =
//        'https://flutter-update.firebaseio.com/products.json?auth=$authToken&$filterString';
//    try {
//      final response = await http.get(url);
//      final extractedData = json.decode(response.body) as Map<String, dynamic>;
//      if (extractedData == null) {
//        return;
//      }
//      url =
//      'https://flutter-update.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
//      final favoriteResponse = await http.get(url);
//      final favoriteData = json.decode(favoriteResponse.body);
//      final List<Product> loadedProducts = [];
//      extractedData.forEach((prodId, prodData) {
//        loadedProducts.add(Product(
//          id: prodId,
//          title: prodData['title'],
//          description: prodData['description'],
//          price: prodData['price'],
//          isFavorite:
//          favoriteData == null ? false : favoriteData[prodId] ?? false,
//          imageUrl: prodData['imageUrl'],
//        ));
//      });
//      _items = loadedProducts;
//      notifyListeners();
//    } catch (error) {
//      throw (error);
//    }
  }
}