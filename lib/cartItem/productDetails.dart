// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:lab5/account/Login/login.dart';
import 'package:lab5/cartItem/allReviews.dart';
import 'package:lab5/cartItem/payProduct.dart';
import 'package:lab5/changeNotifier/Categories.dart';
import 'package:lab5/changeNotifier/ProfileUser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class productDetails extends StatefulWidget {
  final Map<String, dynamic> data;
  final String keyId;
  final String keyIdCa;
  final String start;
  const productDetails(
      {super.key, required this.data, required this.keyId, required this.keyIdCa,required this.start});

  @override
  viewproductDetails createState() => viewproductDetails();
}

class viewproductDetails extends State<productDetails> {
  final firestore = FirebaseFirestore.instance;

  Future<void> AddBuy({String? checkBuy}) async => showModalBottomSheet(
        context: context,
        builder: (context) => bottomSheet(
              data: widget.data,
              check: checkBuy,
              keyID: widget.keyId,
              keyIdCa: widget.keyIdCa,
            ));

  void addFavorite() async {
    final itemUser = Provider.of<getProflieUser>(context, listen: false);
    itemUser.fetchData();
    final firestore = FirebaseFirestore.instance;
    final itemFavo = Provider.of<getFavouriteUser>(context, listen: false);
    if (itemUser.data.isNotEmpty) {
      itemFavo.fetchDataFavourite(itemUser.data[0]["key"]);
    }
    final favoriteRef = firestore
        .collection('User')
        .doc(itemUser.data[0]["key"])
        .collection("Favourite");
    final favoriteQuery =
        await favoriteRef.where('ProductId ', isEqualTo: widget.keyId).get();
    if (favoriteQuery.docs.isNotEmpty) {
      final favoriteDoc = favoriteQuery.docs.first;
      await favoriteDoc.reference.update({
        "ProductId ": widget.keyId,
        "CategoriesId ": widget.keyIdCa,
        "CreatedDate ": widget.data["CreatedDate "],
        "Description  ": widget.data["Description  "],
        "ImageURL ": widget.data["ImageURL "],
        "Listimages ": widget.data["Listimages "],
        "Price  ": widget.data["Price  "],
        "ProductName": widget.data["ProductName"],
        "UpdatedDate  ": widget.data["UpdatedDate  "],
        "discount ": widget.data["discount"],
        "sold  ": widget.data["sold  "],
        "sumComment":widget.data["sumComment"],
        "sumStart":widget.data["sumStart"],
        "Favorite ": true,
      });
      EasyLoading.showSuccess("Thêm vào thành công vào mục Yêu thích");
    } else {
      await favoriteRef.add({
        "ProductId ": widget.keyId,
        "CategoriesId ": widget.keyIdCa,
        "CreatedDate ": widget.data["CreatedDate "],
        "Description  ": widget.data["Description  "],
        "ImageURL ": widget.data["ImageURL "],
        "Listimages ": widget.data["Listimages "],
        "Price  ": widget.data["Price  "],
        "ProductName": widget.data["ProductName"],
        "UpdatedDate  ": widget.data["UpdatedDate  "],
        "discount ": widget.data["discount"],
        "sold  ": widget.data["sold  "],
        "sumComment":widget.data["sumComment"],
        "sumStart":widget.data["sumStart"],
        "Favorite ": true,
      });
      EasyLoading.showSuccess("Thêm vào thành công vào mục Yêu thích");
    }
  }

  void cancerFavorite() async {
    final firestone = FirebaseFirestore.instance;
    final itemUser = Provider.of<getProflieUser>(context, listen: false);
    itemUser.fetchData();
    final itemFavo = Provider.of<getFavouriteUser>(context, listen: false);
    if (itemUser.data.isNotEmpty) {
      itemFavo.fetchDataFavourite(itemUser.data[0]["key"]);
    }
    await firestone
        .collection('User')
        .doc(itemUser.data[0]["key"])
        .collection("Favourite")
        .doc(itemFavo.isKeyFavorites(widget.keyId))
        .update({"Favorite ": false});
    EasyLoading.showSuccess("Xóa vào thành công khỏi mục Yêu thích");
  }

  bool showFullText = false;
  bool checkFavorite = true, checkText = true;
  String? price;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final itemUser = Provider.of<getProflieUser>(context, listen: false);
    itemUser.fetchData();
    final itemFavo = Provider.of<getFavouriteUser>(context, listen: false);
    if (itemUser.data.isNotEmpty) {
      itemFavo.fetchDataFavourite(itemUser.data[0]["key"]);
    }
    isLoading();
  }
  void dialogsupport(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(
            child: Text("Trung tâm hỗ trợ",
                style: TextStyle(fontFamily: "LibreBodoni-Medium")),
          ),
          content:
          const Text("Tính năng đang phát triển !."),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 13, horizontal: 30),
                    backgroundColor: const Color(0xffff6900),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Xác nhận"),
              ),
            )
          ],
        ));
  }
  bool loading = true;
  void isLoading() async{
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    String fomatPrice =
        NumberFormat.decimalPattern("vi").format(widget.data["Price  "]);
    price = fomatPrice.toString().replaceAll(",", ".");
    final itemUser = Provider.of<getProflieUser>(context);
    itemUser.fetchData();
    final itemFavo = Provider.of<getFavouriteUser>(context);
    if (itemUser.data.isNotEmpty) {
      itemFavo.fetchDataFavourite(itemUser.data[0]["key"]);
    }
    final itemRe = Provider.of<categoryProducts>(context);
    itemRe.productReview(widget.keyIdCa, widget.keyId);
    double averageRating = double.parse(widget.start);
    int fullStars = averageRating.floor();
    bool hasHalfStar = (averageRating - fullStars) >= 0.5;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: loading ?SizedBox(
          height: MediaQuery.of(context).size.height-96,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: LoadingAnimationWidget.waveDots(color: Colors.red, size: 40),
          ),
        ) :Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Visibility(
                      visible: widget.data["ImageURL "] != null &&
                          widget.data["ImageURL "].toString().isNotEmpty,
                      replacement: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          color: Colors.white,
                        ),
                      ),
                      child: Image.network(
                        widget.data["ImageURL "],
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 230),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "$price₫",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontFamily: "LibreBodoni-Medium",
                                    fontSize: 20),
                              )),
                          Container(
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                widget.data["ProductName"],
                                style: const TextStyle(
                                    fontFamily: "LibreBaskerville-Regular",
                                    fontSize: 20),
                              )),
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 10, top: 10, bottom: 20),
                              child: Row(
                                children: [
                                   Text(
                                    widget.start,
                                    style: const TextStyle(color: Color(0xfffb6e2e)),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xfffb6e2e),
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("(" "${widget.data['sumComment']}" ")"),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10, right: 10),
                                    width: 1,
                                    height: 20,
                                    color: Colors.grey,
                                  ),
                                  const Text(
                                    "Đã bán :",
                                    style: TextStyle(
                                      color: Color(0xff858585),
                                    ),
                                  ),
                                  Text(
                                    widget.data["sold  "],
                                  ),
                                ],
                              )),
                          Container(
                            width: double.infinity,
                            height: 5,
                            color: const Color(0xffF1F1F1),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, top: 15, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Mô tả về sản phẩm",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "LibreBaskerville-Regular",
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.data["Description  "] ?? "",
                                  style: const TextStyle(
                                    fontFamily: "LibreBodoni-Medium",
                                    color: Color(0xff646464),
                                    wordSpacing: 1,
                                  ),
                                  overflow: showFullText
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                  maxLines: showFullText ? null : 5,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Visibility(
                                  visible: showFullText,
                                  child: Image.network(
                                    widget.data["DescriptionURL"] ?? "",
                                    width: 350,
                                    height: 200,
                                  ),
                                ),
                                Visibility(
                                  visible: showFullText,
                                  child: Image.network(
                                    widget.data["parametersURL"] ?? "",
                                    width: 400,
                                  ),
                                ),
                                Center(
                                  child: TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        showFullText = !showFullText;
                                      });
                                    },
                                    label: showFullText
                                        ? const Text("Ẩn bớt")
                                        : const Text("Xem thêm"),
                                    icon: showFullText
                                        ? Image.asset(
                                            "assets/image/minus (2).png",
                                            height: 20,
                                            width: 20,
                                          )
                                        : Image.asset(
                                            "assets/image/add.png",
                                            height: 20,
                                            width: 20,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10,
                            color: const Color(0xffF1F1F1),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, top: 15, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Đánh giá của khách hàng",
                                          style: TextStyle(
                                              fontFamily: "LibreBodoni-Medium",
                                              fontSize: 17),
                                        ),
                                        Text(
                                          "(" +
                                              itemRe.data.length.toString() +
                                              ')',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => allReviews(idCa:widget.keyIdCa, idPro:widget.keyId),));
                                      },
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Xem thêm",
                                            style: TextStyle(
                                                color: Color(0xff858383)),
                                          ),
                                          Image.asset(
                                            "assets/image/next.png",
                                            height: 10,
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.start,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const Text(
                                      " / 5",
                                      style: TextStyle(
                                          color: Color(0xff817F7F), fontSize: 18),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        for (int i = 1; i <= fullStars; i++)
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                        if (hasHalfStar)
                                          const Icon(
                                            Icons.star_half,
                                            color: Colors.amber,
                                          ),
                                        for (int i =
                                                fullStars + (hasHalfStar ? 2 : 1);
                                            i <= 5;
                                            i++)
                                          const Icon(
                                            Icons.star_border,
                                            color: Colors.grey,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                ListView.builder(
                                  itemCount: 2,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if (index < itemRe.data.length) {
                                    final itemIndex = itemRe.data[index];
                                    final itemData = itemIndex["data"];
                                    List<dynamic> imageUrls = itemData["imageUrls"];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.symmetric(vertical: 10),
                                          width: double.infinity,
                                          height: 1,
                                          color: const Color(0xffDAD6D6),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          itemData["imageUser"]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  itemData["username"],
                                                  style: const TextStyle(fontSize: 18),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Sản Phẩm: ",
                                                  style: TextStyle(
                                                      color: Color(0xff817F7F),
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      itemData["productName"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            for (int i = 1;
                                                i <= itemData["numberofStars"];
                                                i++)
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 18,
                                              ),
                                            for (int i = itemData["numberofStars"]
                                                    .ceil();
                                                i < 5;
                                                i++)
                                              const Icon(
                                                Icons.star_border,
                                                color: Colors.grey,
                                                size: 18,
                                              ),
                                          ],
                                        ),
                                        Text(
                                            itemData["comment"]),
                                        imageUrls.isEmpty ?Container():
                                        Row(
                                          children: [
                                            if (imageUrls.isNotEmpty)
                                              Container(
                                                margin: const EdgeInsets.symmetric(vertical: 10),
                                                width: 100,
                                                height: 100,
                                                child: Image.network(imageUrls[0]),
                                              ),
                                            if (imageUrls.length >= 2)
                                              Stack(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                                    width: 100,
                                                    height: 100,
                                                    child: Image.network(imageUrls[1]),
                                                  ),
                                                  if (imageUrls.length > 2)
                                                    Positioned(
                                                      bottom: 0.0,
                                                      right: 0.0,
                                                      child: Container(
                                                        padding: const EdgeInsets.all(5),
                                                        color: Colors.black54,
                                                        child: Text(
                                                          "+${imageUrls.length - 2}",
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                          ],
                                        )
                                      ],
                                    );
                                  }
                                    return Container();},
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: const Color(0xffDAD6D6),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10,
                            color: const Color(0xffDAD6D6),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 190,
                        right: 10,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                itemFavo.isProductInFavorites(widget.keyId)
                                    ? cancerFavorite()
                                    : addFavorite();
                              });
                            },
                            child: itemFavo.isProductInFavorites(widget.keyId)
                                ? Image.asset(
                                    "assets/image/Group-84.png",
                                    height: 100,
                                    width: 100,
                                  )
                                : Image.asset(
                                    "assets/image/Mask-group.png",
                                    height: 100,
                                    width: 100,
                                  ))),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 15),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFFB0AEAE)),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/image/left-chevron.png",
                            width: 20,
                            height: 20,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      color: const Color(0xff2BBAA9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {dialogsupport(context);},
                              child: Image.asset(
                                "assets/image/bubble-chat.png",
                                height: 30,
                                width: 30,
                              )),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey,
                          ),
                          Material(
                            color: Colors.white.withOpacity(0.0),
                            child: InkWell(
                              onTap: () {
                                AddBuy(checkBuy: "AddtoCart");
                              },
                              child: Image.asset(
                                "assets/image/add-to-cart.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          AddBuy(checkBuy: "AddBuy");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFF6900),
                            shape:
                                const RoundedRectangleBorder(side: BorderSide.none)),
                        child: const Text("Mua ngay"),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
class bottomSheet extends StatefulWidget {
  final Map<String, dynamic> data;
  final String? check;
  final String? keyID;
  final String? keyIdCa;

  const bottomSheet(
      {super.key,
      required this.data,
      required this.check,
      required this.keyID,
      required this.keyIdCa});

  @override
  showButtomSheet createState() => showButtomSheet();
}

class showButtomSheet extends State<bottomSheet> {
  bool checkCount = false;
  final countController = TextEditingController();
  int count = 1, Sum = 0;

  @override
  void initState() {
    super.initState();
    countController.text = count.toString();
    Provider.of<getProflieUser>(context, listen: false).fetchData();
  }

  void addToCart() async {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
    final item = Provider.of<getProflieUser>(context, listen: false);
    item.fetchData();
    final firestore = FirebaseFirestore.instance;
    await firestore
        .collection('User')
        .doc(item.data[0]["key"])
        .collection("Cart")
        .add({
      "CategoriesId": widget.keyIdCa,
      "productID": widget.keyID,
      "productName": widget.data["ProductName"],
      "quantity": countController.text,
      "price": price,
      "imageUrl": widget.data["ImageURL "],
      "createdAt": formattedDate
    }).then((value) {
        if (kDebugMode) {
          print("Ok");
        }
    }).catchError((e) {
      if (kDebugMode) {
        print("lỗi");
      }
    });
    EasyLoading.showSuccess("Thêm vào giỏ hàng thành công");
    Navigator.pop(context);
  }

  void addBuy() async {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
    Sum = 0;
    Sum = count *
        int.parse(widget.data["Price  "].toString().replaceAll(".", ""));
    List<Map<String, dynamic>> list = [];
    Map<String, dynamic> newItem = {
      "key": widget.keyID,
      "data": {
        "CategoriesId": widget.keyIdCa,
        "productName": widget.data["ProductName"],
        "quantity": countController.text,
        "price": price,
        "productID": widget.keyID,
        "imageUrl": widget.data["ImageURL "],
        "createdAt": formattedDate
      }
    };
    list.addAll([newItem]);
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => payProduct(totaPrice: Sum, data: list)));
  }

  void minusCount() {
    int parsedValue = int.tryParse(countController.text) ?? 0;
    if (parsedValue > 1) {
      setState(() {
        parsedValue--;
        countController.text = parsedValue.toString();
        count = parsedValue;
      });
      checkCount = parsedValue > 1;
    }
  }

  void addCount() {
    int parsedValue = int.tryParse(countController.text) ?? 0;
    setState(() {
      parsedValue++;
      countController.text = parsedValue.toString();
      count = parsedValue;
    });
    checkCount = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    countController.clear();
  }

  String? price;

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.check == "AddtoCart";
    final buttonText = isEditing ? 'Thêm vào giỏ hàng' : 'Thanh toán';
    String fomatPrice =
        NumberFormat.decimalPattern("vi").format(widget.data["Price  "]);
    price = fomatPrice.toString().replaceAll(",", ".");
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 330,
      child: Stack(children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.network(
                    widget.data["ImageURL "],
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$price₫",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontFamily: "LibreBodoni-Bold"),
                      ),
                      Text(
                        "$price₫",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.grey,
              height: .5,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Số lượng ",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        color: Colors.white.withOpacity(0.0),
                        child: InkWell(
                          onTap: checkCount ? () => minusCount() : null,
                          child: Container(
                            width: 30,
                            height: 30,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(width: .5, color: Colors.grey),
                            ),
                            child: Image.asset(
                              "assets/image/minus (1).png",
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 30,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(width: .5, color: Colors.grey),
                            bottom: BorderSide(width: .5, color: Colors.grey),
                          ),
                        ),
                        child: TextField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                          onChanged: (text) {
                            int parsedValue = int.tryParse(text) ?? 1;
                            if (parsedValue <= 1) {
                              countController.text = "1";
                            } else {
                              checkCount = true;
                            }
                          },
                          controller: countController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 17),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.white.withOpacity(0.0),
                        child: InkWell(
                          child: Container(
                            width: 30,
                            height: 30,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(width: .5, color: Colors.grey),
                            ),
                            child: Image.asset(
                              "assets/image/plus-sign.png",
                              color: Colors.grey,
                            ),
                          ),
                          onTap: () {
                            addCount();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              color: Colors.grey,
              height: .5,
            ),
          ],
        ),
        Positioned(
            top: -5,
            right: -5,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset("assets/image/close (1).png"))),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  if (widget.check == "AddtoCart") {
                    addToCart();
                  } else {
                    addBuy();
                  }
                } else {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => const login()));
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFF6900),
                  shape: const RoundedRectangleBorder(side: BorderSide.none)),
              child: Text(buttonText),
            ),
          ),
        ),
      ]),
    );
  }
}
