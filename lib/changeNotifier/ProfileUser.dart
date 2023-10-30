import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
class getProflieUser extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _data = [];

  List<Map<String, dynamic>> get data => _data;

  List<MapEntry<String, dynamic>> get addresses {
    List<MapEntry<String, dynamic>> addressList = [];
    for (var item in _data) {
      if (item['data'] != null && item['data']['address'] != null) {
        final Map<String, dynamic> addressMap = item['data']['address'] as Map<String, dynamic>;
        addressMap.entries.forEach((entry) {
          addressList.add(entry);
              });
            }
        }
            addressList.sort((a, b) {
          if (a.value['isDefault'] && !b.value['isDefault']) {
            return -1;
          } else if (!a.value['isDefault'] && b.value['isDefault']) {
            return 1;
          } else {
            return 0;
          }
        });
    return addressList;
  }
  Future<void> fetchData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final email = user.email;
        final querySnapshot = await _firestore
            .collection('User')
            .where('email', isEqualTo: email)
            .get();
        _data = querySnapshot.docs.map((doc) {
          final Map<String, dynamic> data = doc.data();
          final String key = doc.id;
          return {"key": key, "data": data};
        }).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu từ Firestore: $e');
    }
  }
}
class getCartUser extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = false;
  List<Map<String, dynamic>> get data => _data;
  bool get isLoading => _isLoading;
  Future<void> fetchDataCart(String id) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
          final List<Map<String, dynamic>> products = [];
            final productsQuery = await _firestore
                .collection('User')
                .doc(id)
                .collection('Cart')
                .orderBy('createdAt', descending: true)
                .get();
            for (final productDoc in productsQuery.docs) {
              final String productKey = productDoc.id;
              final Map<String, dynamic> productData =
              productDoc.data();
              products.add({"key": productKey, "data": productData});

        }_data = products;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu từ Firestore: $e');
    }
  }
}
class getNotiUser extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = false;
  List<Map<String, dynamic>> get data => _data;
  bool get isLoading => _isLoading;
  Future<void> fetchDataNoti(String id) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final List<Map<String, dynamic>> products = [];
        final productsQuery = await _firestore
            .collection('User')
            .doc(id)
            .collection('Notification')
            .orderBy('createAt', descending: true)
            .get();
        for (final productDoc in productsQuery.docs) {
          final String productKey = productDoc.id;
          final Map<String, dynamic> productData =
          productDoc.data();
          products.add({"key": productKey, "data": productData});

        }_data = products;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu từ Firestore: $e');
    }
  }
}
class getOderUser extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = false;
  List<Map<String, dynamic>> get data => _data;
  bool get isLoading => _isLoading;
  Future<void> fetchDataOder(String id) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final List<Map<String, dynamic>> products = [];
        final productsQuery = await _firestore
            .collection('User')
            .doc(id)
            .collection('History')
            .orderBy('createAt', descending: true)
            .get();
        for (final productDoc in productsQuery.docs) {
          final String productKey = productDoc.id;
          final Map<String, dynamic> productData =
          productDoc.data();
          products.add({"key": productKey, "data": productData});

        }_data = products;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu từ Firestore: $e');
    }
  }
}
class getFavouriteUser extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = false;
  List<Map<String, dynamic>> get data => _data;
  bool get isLoading => _isLoading;

  Future<void> fetchDataFavourite(String id) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final List<Map<String, dynamic>> products = [];
        final productsQuery = await _firestore
            .collection('User')
            .doc(id)
            .collection('Favourite')
            .orderBy('CreatedDate ', descending: true)
            .get();
        for (final productDoc in productsQuery.docs) {
          final String productKey = productDoc.id;
          final Map<String, dynamic> productData =
          productDoc.data();
          products.add({"key": productKey, "data": productData});
        }_data = products;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu từ Firestore: $e');
    }
  }
  bool isProductInFavorites(String productId) {
    for (var favorite in _data) {
      if (favorite['data']['ProductId '] == productId && favorite['data']['Favorite '] == true) {
        return true;
      }
    }
    return false;
  }
  String isKeyFavorites(String productId) {
    String? key;
    for (var favorite in _data) {
      if (favorite['data']['ProductId '] == productId && favorite['data']['Favorite '] == true) {
        return key = favorite['key'];
      }
    }
    return key!;
  }
}