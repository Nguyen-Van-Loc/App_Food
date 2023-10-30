import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab5/cartItem/productDetails.dart';
import 'package:shimmer/shimmer.dart';
import 'cart.dart';


// ignore: must_be_immutable
class productPortfolio extends StatefulWidget {
  List<Map<String, dynamic>> data;
  final String Name;
  final String keyID;
  productPortfolio({required this.Name, required this.data, required this.keyID});

  showproductPortfolio createState() => showproductPortfolio();
}
class showproductPortfolio extends State<productPortfolio> {
  final firestore = FirebaseFirestore.instance;
  bool show = false;
  bool checkLoading=true;
  String? price;
  void isLoading() async{
    checkLoading=true;
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      checkLoading=false;
    });
  }
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    isLoading();
    loadProductNames();
  }
  Future<void> arrangeNameA_Z() async {
    try {
      final querySnapshot = await firestore
          .collection("Categories")
          .doc(widget.keyID)
          .collection("products")
          .orderBy("ProductName")
          .get();
      final sortedProducts = querySnapshot.docs.map((productDoc) {
        return {
          "key": productDoc.id,
          "data": productDoc.data(),
        };
      }).toList();

      setState(() {
        widget.data = sortedProducts;
      });
    } catch (e) {
      print('Lỗi khi lấy dữ liệu từ Firestore: $e');
    }
  }
  Future<void> arrangeNameZ_A() async {
    try {
      final querySnapshot = await firestore
          .collection("Categories")
          .doc(widget.keyID)
          .collection("products")
          .orderBy("ProductName",descending: true)
          .get();
      final sortedProducts = querySnapshot.docs.map((productDoc) {
        return {
          "key": productDoc.id,
          "data": productDoc.data(),
        };
      }).toList();

      setState(() {
        widget.data = sortedProducts;
      });
    } catch (e) {
      print('Lỗi khi lấy dữ liệu từ Firestore: $e');
    }
  }
  Future<void> arrangePriceA_Z() async {
    try {
      final querySnapshot = await firestore
          .collection("Categories")
          .doc(widget.keyID)
          .collection("products")
          .orderBy("Price  ")
          .get();
      final sortedProducts = querySnapshot.docs.map((productDoc) {
        return {
          "key": productDoc.id,
          "data": productDoc.data(),
        };
      }).toList();

      setState(() {
        widget.data = sortedProducts;
      });
    } catch (e) {
      print('Lỗi khi lấy dữ liệu từ Firestore: $e');
    }
  }
  Future<void> arrangePriceZ_A() async {
    try {
      final querySnapshot = await firestore
          .collection("Categories")
          .doc(widget.keyID)
          .collection("products")
          .orderBy("Price  ",descending: true)
          .get();
      final sortedProducts = querySnapshot.docs.map((productDoc) {
        return {
          "key": productDoc.id,
          "data": productDoc.data(),
        };
      }).toList();

      setState(() {
        widget.data = sortedProducts;
      });
    } catch (e) {
      print('Lỗi khi lấy dữ liệu từ Firestore: $e');
    }
  }
  List<DocumentSnapshot> allProducts = [];
  void loadProductNames() async {
    final snapshot = await firestore
        .collection("Categories")
        .doc(widget.keyID)
        .collection("products")
        .get();

    setState(() {
      allProducts = snapshot.docs;
    });
  }
  SearchController controller = SearchController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10, top: 15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xFFB0AEAE)),
                              child: Image.asset(
                                "assets/image/left-chevron.png",
                                width: 20,
                                height: 20,
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          widget.Name,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "LibreBodoni-BoldItalic"),
                        ),
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 15),
                  child: InkWell(
                    child: const Icon(
                      CupertinoIcons.cart_fill,
                      size: 25,
                    ),
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => cart(),));
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: 5,
              color: Color(0xffe7e6e6),
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 70,
                  margin: const EdgeInsets.only(
                      top: 20, bottom: 5, right: 10, left: 10),
                  child: SearchAnchor(
                      builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          hintText: "Search...",
                          hintStyle: MaterialStateProperty.all(TextStyle(color: Colors.grey)),
                          controller: controller,
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 10)),
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                          leading: const Icon(Icons.search),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        );
                      }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                        String removeDiacritics(String input) {
                          return input
                              .replaceAll('Đ', 'D')
                              .replaceAll('đ', 'd')
                              .replaceAll(RegExp(r'[^\x00-\x7F]+'), '');
                        }
                        final normalizedQuery = removeDiacritics(controller.text).toLowerCase();
                        List<DocumentSnapshot> filteredProducts = allProducts.where((product) {
                          String productName = product['ProductName'].toString();
                          String normalizedProductName = removeDiacritics(productName).toLowerCase();
                          return normalizedProductName.contains(normalizedQuery);
                        }).toList();
                        List<Widget> suggestionList = [];
                        for (int i = 0; i < filteredProducts.length&& filteredProducts.length<7; i++) {
                          suggestionList.add(ListTile(
                            title: Text(filteredProducts[i]['ProductName'],maxLines: 1,overflow: TextOverflow.ellipsis,),
                            onTap: () {
                              setState(() {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => productDetails(data: widget.data[i]["data"], keyId: widget.data[i]["key"] ,keyIdCa: widget.keyID),));
                              });
                            },
                          ));

                          if (i < filteredProducts.length - 1) {
                            suggestionList.add(Divider());
                          }
                        }
                        return suggestionList;
                  })
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    icon: Image.asset("assets/image/edit.png")),
              ],
            ),
            show ? Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {arrangeNameA_Z();},
                          child: Text("Theo tên từ A-Z",style: TextStyle(fontSize: 13),),
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xffd9d9d9),
                            foregroundColor: Color(0xff3a3030),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),
                        TextButton(
                          onPressed: () {arrangeNameZ_A();},
                          child: Text("Theo tên từ Z-A",style: TextStyle(fontSize: 13)),
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xffd9d9d9),
                              foregroundColor: Color(0xff3a3030),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("Theo đánh giá",style: TextStyle(fontSize: 13)),
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xffd9d9d9),
                              foregroundColor: Color(0xff3a3030),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {arrangePriceA_Z();},
                          child: Text("Theo giá từ thấp đến cao",style: TextStyle(fontSize: 13)),
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xffd9d9d9),
                              foregroundColor: Color(0xff3a3030),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        ),
                        TextButton(
                          onPressed: () {arrangePriceZ_A();},
                          child: Text("Theo giá từ cao đến thấp",style: TextStyle(fontSize: 13)),
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xffd9d9d9),
                              foregroundColor: Color(0xff3a3030),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ):Container(),
                Card(
                  color: const Color(0xffeaeaea),
                  margin: const EdgeInsets.only(top: 10),
                  elevation: 2,
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.data.length,
                          shrinkWrap: true,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, mainAxisExtent: 370),
                          itemBuilder: (context, index) {
                            if (checkLoading){
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Card(
                                  elevation: 3,
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 200,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Container(
                                          width: 100,
                                          height: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 20,
                                        color: Colors
                                            .white,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            width: 40,
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 20,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 40,
                                              height: 20,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else{
                              final getItem = widget.data[index];
                              final itemData = getItem["data"];
                              final keyId = getItem["key"];
                              final keyIdCa =getItem["categoryKey"];
                              String fomatPrice=NumberFormat.decimalPattern("vi").format(itemData["Price  "]);
                              price = fomatPrice.toString().replaceAll(",", ".");
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        CupertinoPageRoute(
                                            builder: (context) =>productDetails(data: itemData, keyId: keyId,keyIdCa: keyIdCa,)));
                                  },
                                  child: Card(
                                    elevation: 3,
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Image.network(
                                            itemData["ImageURL "],
                                            height: 200,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: itemData["Listimages "] !=
                                              null &&
                                              itemData["Listimages "]
                                                  .isNotEmpty
                                              ? Image.network(
                                              itemData["Listimages "],
                                              height: 30)
                                              : null,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            margin:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              itemData["ProductName"],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontFamily:
                                                  "LibreBaskerville-Regular"),
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "$price₫",
                                                    style: TextStyle(
                                                        fontFamily:
                                                        "LibreBodoni-Medium",
                                                        fontSize: 17,
                                                        color:
                                                        Color(0xffd0021c),
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                color:
                                                const Color(0xfffff0e9),
                                                child: itemData["discount"] !=
                                                    null &&
                                                    itemData["discount"]
                                                        .isNotEmpty
                                                    ? Text(
                                                  "-" +
                                                      itemData[
                                                      "discount"] +
                                                      "%",
                                                  style: TextStyle(
                                                      color: Color(
                                                          0xffeb5757)),
                                                )
                                                    : null,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: const Row(
                                            children: [
                                              Text(
                                                "4.4",
                                                style: TextStyle(
                                                    color: Color(0xfffb6e2e)),
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color(0xfffb6e2e),
                                                size: 18,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("(" "30" ")")
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            }
                          }
                      )),
                ),
          ]),
        ),
      ),
    );
  }
}

