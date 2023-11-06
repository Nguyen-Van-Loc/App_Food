import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class getCategories extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = true;
  List<Map<String, dynamic>> get data => _data;
  bool get isLoading => _isLoading;

  Future<void> fetchDataCategories() async {
    try {
        final querySnapshot =
            await _firestore.collection('Categories').orderBy("name").get();
        _data = querySnapshot.docs.map((doc) {
          final Map<String, dynamic> data = doc.data();
          final String key = doc.id;
          return {"key": key, "data": data};
        }).toList();
        _isLoading = false;
        notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi khi lấy dữ liệu từ Firestore: $e');
      }
    }
  }
}
class getBander extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = true;
  List<Map<String, dynamic>> get data => _data;
  bool get isLoading => _isLoading;

  Future<void> fetchDataBander() async {
    try {
      final querySnapshot =
      await _firestore.collection('Bander').get();
      _data = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data();
        final String key = doc.id;
        return {"key": key, "data": data};
      }).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi khi lấy dữ liệu từ Firestore: $e');
      }
    }
  }
  String getBanderID(String productId) {
    for (var bander in _data) {
      if (bander['data']['productsID'] == productId) {
        return bander['key'];
      }
    }
    return "";
  }
}
class getProducts extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _data = [];
  final List<Map<String, dynamic>> _dataProduct = [];
  bool _isLoading = false;
  bool _isDataShuffled = false;

  List<Map<String, dynamic>> get data => _data;

  List<Map<String, dynamic>> get dataProduct => _dataProduct;

  bool get isLoading => _isLoading;

  Future<void> fetchDataProducts() async {
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 3));
    try {
        if (!_isDataShuffled) {
          final categoriesQuerySnapshot =
              await _firestore.collection('Categories').get();
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
                  productDoc.data();
              products.add({"categoryKey": categoryKey,"key": productKey, "data": productData});
            }
          }
          products.shuffle();
          categoryKeys.shuffle();
          _data = products;
          _isDataShuffled = true;
        }
        _isLoading = false;
        notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi khi lấy dữ liệu từ Firestore: $e');
      }
    }
  }
  List<Map<String, dynamic>> _dataFa = [];
  List<Map<String, dynamic>> get dataFa => _dataFa;
  Future<void> fetchDataFavorite() async {
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 3));
    try {
      if (!_isDataShuffled) {
        final List<Map<String, dynamic>> products = [];

        final categoriesQuerySnapshot =
        await _firestore.collection('Categories').get();
        for (final doc in categoriesQuerySnapshot.docs) {
          final String categoryKey = doc.id;
          final productsQuery = await _firestore
              .collection('Categories')
              .doc(categoryKey)
              .collection('products')
              .get();
          for (final productDoc in productsQuery.docs) {
            final String productKey = productDoc.id;
            final Map<String, dynamic> productData =
            productDoc.data();
            products.add({"categoryKey": categoryKey,"key": productKey, "data": productData});
          }
        }
        products.sort((a, b) {
          int soldA = int.tryParse(a['data']['sold  ']) ?? 0;
          int soldB = int.tryParse(b['data']['sold  ']) ?? 0;
          return soldB.compareTo(soldA);
        });
        _dataFa = products;
        _isDataShuffled = true;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi khi lấy dữ liệu từ Firestore: $e');
      }
    }
  }
}

class categoryProducts extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> _result = [];
  List<Map<String, dynamic>> get result => _result;
  bool _isLoading = false;
  bool _isDataShuffled = false;
  bool get isLoading => _isLoading;

  void filterSuggestions(String query) {
    notifyListeners();
  }
  Future<void> productReview(String idCa,String idPro) async {
    try {
      final querySnapshot =
      await _firestore.collection('Categories')
      .doc(idCa)
      .collection("products")
      .doc(idPro)
      .collection("Review")
          .get();
      _data = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data();
        final String key = doc.id;
        return {"key": key, "data": data};
      }).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi khi lấy dữ liệu từ Firestore: $e');
      }
    }
  }

  Future<void> getCategoriesProducts() async {
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    try {
      if(!_isDataShuffled) {
        final querySnapshot =
        await _firestore.collection('Categories').orderBy("name").get();
        for (var doc in querySnapshot.docs) {
          final Map<String, dynamic> categoryData =
          doc.data();
          final String categoryKey = doc.id;
          final productsQuerySnapshot = await _firestore
              .collection('Categories')
              .doc(categoryKey)
              .collection('products')
              .get();
          List<Map<String, dynamic>> productsData =
          productsQuerySnapshot.docs.map((productDoc) {
            final Map<String, dynamic> productData =
            productDoc.data();
            final String productKey = productDoc.id;
            return {"key": productKey, "data": productData};
          }).toList();
          result.add({
            "categoryKey": categoryKey,
            "categoryData": categoryData,
            "productsData": productsData
          });
        }
        _isDataShuffled = true;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi khi lấy dữ liệu từ Firestore: $e');
      }
    }
  }
  List<Map<String, dynamic>> _data = [];
  List<Map<String, dynamic>> get data => _data;

  Future<void> searchProducts(String query) async {
    _isLoading = true;
    List<Map<String, dynamic>> tempData = [];
    final categoriesQuerySnapshot = await _firestore.collection('Categories').get();

    for (final doc in categoriesQuerySnapshot.docs) {
      final String categoryKey = doc.id;
      final Map<String, dynamic> categoryData = doc.data();
      final String categoryName = removeAccents(categoryData['name'] as String).toLowerCase();
      final userInput = removeAccents(query).toLowerCase();

      if (categoryName == userInput) {
        final productsData = await _searchCategoryProducts(categoryKey);
        if (productsData.isNotEmpty) {
          tempData.add({
            "categoryKey": categoryKey,
            "categoryData": categoryData,
            "productsData": productsData,
          });
        }
        break;
      } else {
        final productsData = await _searchProductsByName(categoryKey, userInput, query);
        if (categoryName.contains(userInput) || productsData.isNotEmpty) {
          tempData.add({
            "categoryKey": categoryKey,
            "productsData": productsData,
          });
        }
      }
    }
    _data = tempData;
    _isLoading = false;
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> _searchCategoryProducts(String categoryKey) async {
    final productsQuery = await _firestore.collection('Categories').doc(categoryKey).collection('products').get();
    return productsQuery.docs.map((productDoc) {
      final String productKey = productDoc.id;
      final Map<String, dynamic> productData = productDoc.data();
      return {
        "key": productKey,
        "data": productData,
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> _searchProductsByName(String categoryKey, String userInput, String originalQuery) async {
    final productsQuery = await _firestore.collection('Categories').doc(categoryKey).collection('products').get();
    return productsQuery.docs.where((productDoc) {
      final Map<String, dynamic> productData = productDoc.data();
      final String productName = removeAccents(productData['ProductName'] as String).toLowerCase();
      return productName.contains(userInput) || productName.contains(originalQuery.toLowerCase());
    }).map((productDoc) {
      final String productKey = productDoc.id;
      final Map<String, dynamic> productData = productDoc.data();
      return {
        "key": productKey,
        "data": productData,
      };
    }).toList();
  }
}

String removeAccents(String input) {
  final accentMap = {
    'àáảãạăắằẳẵặâấầẩẫậ': 'a',
    'Cc': 'c',
    'Gg': "g",
    'Hh': 'h',
    'Kk': 'k',
    'Ll': 'l',
    'Mm': 'm',
    "Nn": 'n',
    "Pp": 'p',
    "Qq": 'q',
    "Rr": 'r',
    "Ss": 's',
    "Tt": 't',
    "Vv": 'v',
    "Xx": 'x',
    'èéẻẽẹêếềểễệ': 'e',
    'ìíỉĩị': 'i',
    'òóỏõọôốồổỗộơớờởỡợ': 'o',
    'ùúủũụưứừửữự': 'u',
    'ỳýỷỹỵ': 'y',
    'đĐDd': 'd',
    'ÀÁẢÃẠĂẮằẲẴẶÂẤẦẨẪẬ': 'A',
    'ÈÉẺẼẸÊẾỀỂỄỆ': 'E',
    'ÌÍỈĨỊ': 'I',
    'ÒÓỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢ': 'O',
    'ÙÚỦŨỤƯỨỪỬỮỰ': 'U',
    'ỲÝỶỸỴ': 'Y',
    'Bb': "b"
  };

  String result = input.toLowerCase();

  for (var pattern in accentMap.keys) {
    for (var accentChar in pattern.characters) {
      result = result.replaceAll(accentChar, accentMap[pattern]!);
    }
  }

  return result;
}
