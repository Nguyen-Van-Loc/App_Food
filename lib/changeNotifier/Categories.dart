import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class getCategories extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _data = [];
  bool _isLoading =true;
  List<Map<String, dynamic>> get data => _data;
  bool get isLoading=>_isLoading;
  Future<void> fetchDataCategories() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final querySnapshot =
            await _firestore.collection('Categories').orderBy("name").get();
        _data = querySnapshot.docs.map((doc) {
          final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          final String key = doc.id;
          return {"key": key, "data": data};
        }).toList();
        _isLoading=false;
        notifyListeners();
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu từ Firestore: $e');
    }
  }
}

class getProducts extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = false;
  bool _isDataShuffled = false;
  List<Map<String, dynamic>> get data => _data;
  bool get isLoading => _isLoading;
  Future<void> fetchDataProducts() async {
    _isLoading=true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (!_isDataShuffled) {
          final categoriesQuerySnapshot = await _firestore.collection('Categories').get();
          final List<String> categoryKeys = [];
          final List<Map<String, dynamic>> products = [];

          for (final doc in categoriesQuerySnapshot.docs) {
            final String categoryKey = doc.id;
            categoryKeys.add(categoryKey);
            final productsQuery = await _firestore
                .collection('Categories')
                .doc(categoryKey)
                .collection('products')
                .get();

            for (final productDoc in productsQuery.docs) {
              final String productKey = productDoc.id;
              final Map<String, dynamic> productData =
              productDoc.data() as Map<String, dynamic>;
              products.add({"key": productKey, "data": productData});
            }
          }
          products.shuffle();
          categoryKeys.shuffle();
          _data = products;
          _isDataShuffled = true;
        }
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu từ Firestore: $e');
    }
  }
}
