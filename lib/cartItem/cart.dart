import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:lab5/cartItem/payProduct.dart';
import 'package:lab5/changeNotifier/ProfileUser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
class cart extends StatefulWidget {
  viewCart createState() => viewCart();
}
class viewCart extends State<cart> {
  final firestore =FirebaseFirestore.instance;
  int totalPayment=0;
  String result="0";
  bool loading =false;
  Set<int> selectedItems = Set<int>();
  bool selectAll = false;
  List<Map<String,dynamic>> selectedItemsList =[];
  List<TextEditingController> quantityControllers = [];
  bool checkLoading=true;
  void isLoading() async{
    await Future.delayed(Duration(seconds: 3));
    checkLoading=false;
  }
  void add(String key,dynamic quantity)async{
    for (var item in selectedItemsList) {
      if (item["key"] == key) {
        item["data"]["quantity"] = (int.parse(item["data"]["quantity"]) + 1).toString();
      }
    }
    final item = Provider.of<getProflieUser>(context,listen: false);
    item.fetchData();
    await firestore.collection("User").doc(item.data[0]["key"]).collection("Cart").doc(key).set({
      'quantity':quantity.toString()
    },SetOptions(merge: true));
    String formattedTotalPayment = NumberFormat.decimalPattern("vi").format(totalPayment);
    result = formattedTotalPayment.toString().replaceAll(",", ".");
  }
  void minus(String key,dynamic quantity)async{
    for (var item in selectedItemsList) {
      if (item["key"] == key) {
        item["data"]["quantity"] = (int.parse(item["data"]["quantity"]) - 1).toString();
      }
    }
    final item = Provider.of<getProflieUser>(context,listen: false);
    item.fetchData();
    await firestore.collection("User").doc(item.data[0]["key"]).collection("Cart").doc(key).set({
      'quantity':(quantity-1).toString()
    },SetOptions(merge: true));
    String formattedTotalPayment = NumberFormat.decimalPattern("vi").format(totalPayment);
    result = formattedTotalPayment.toString().replaceAll(",", ".");
  }
  void addQuantity(String keyid,String text){
    final item = Provider.of<getProflieUser>(context, listen: false);
    item.fetchData();
    firestore.collection("User").doc(item.data[0]["key"]).collection("Cart").doc(keyid).set({
      'quantity': text,
    }, SetOptions(merge: true));
    int itemIndex = selectedItemsList.indexWhere((element) => element["key"] == keyid);
    print(itemIndex);
    if (itemIndex != -1) {
      selectedItemsList[itemIndex]["data"]["quantity"] = text;
    }
    selectTotalPrice();
    String formattedTotalPayment = NumberFormat.decimalPattern("vi").format(totalPayment);
    result = formattedTotalPayment.toString().replaceAll(",", ".");
  }
  void selectTotalPrice(){
    totalPayment = 0;
    for (var selectedItem  in selectedItemsList) {
      final itemData = selectedItem ["data"];
      String priceString = itemData["price"].toString().replaceAll(".", "");
      priceString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
      if (priceString.isNotEmpty) {
        int? price = int.tryParse(priceString);
        if (price != null) {
          int? quantity = int.tryParse(itemData["quantity"]);
          if (quantity != null) {
            totalPayment += price * quantity;
          }
        }
      }
    }
  }
  void loadingTotalPrice() async{
    loading=true;
    await Future.delayed(Duration(seconds: 2));
    loading=false;
    String formattedTotalPayment = NumberFormat.decimalPattern("vi").format(totalPayment);
    result = formattedTotalPayment.toString().replaceAll(",", ".");
  }

  @override
  void initState() {
    super.initState();
    isLoading();
    fetchDataAndInitialize();
  }
  Future<void> fetchDataAndInitialize() async {
    final item = Provider.of<getCartUser>(context, listen: false);
    final itemUser = Provider.of<getProflieUser>(context, listen: false);
    await itemUser.fetchData();
    if (itemUser.data.isNotEmpty) {
      await item.fetchDataCart(itemUser.data[0]["key"]);
      quantityControllers = List.generate(item.data.length, (index) => TextEditingController());
    } else {
      quantityControllers = [];
    }
    setState(() {
      checkLoading = false;
    });
  }
  @override
  void dispose() {
    for (var controller in quantityControllers) {
      controller.dispose();
    }
    super.dispose();
  }
  void _diadelete(BuildContext context,String index) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text(
                "Thông báo",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.left,
              ),
              content: const Text(
                "Bạn có chắc chắn muốn xóa không ?",
                style: TextStyle(fontSize: 17),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Hủy"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 30),
                          backgroundColor: const Color(0xffff6900),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        setState(() {
                          delete(index);
                          EasyLoading.showSuccess("Thành công");
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Xác nhận"),
                    )
                  ],
                ),
              ]);
        });
  }
  void delete(String index) async{
    final itemUser = Provider.of<getProflieUser>(context, listen: false);
    await itemUser.fetchData();
    await firestore.collection("User").doc(itemUser.data[0]["key"]).collection("Cart").doc(index).delete();
    await fetchDataAndInitialize();
  }
  @override
   Widget build(BuildContext context) {
    final item=Provider.of<getCartUser>(context);
    final itemUser = Provider.of<getProflieUser>(context);
    itemUser.fetchData();
    if (itemUser.data.isNotEmpty) {
      item.fetchDataCart(itemUser.data[0]["key"]);
    }
    selectTotalPrice();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15, top: 15),
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
                    "Giỏ hàng",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "LibreBodoni-BoldItalic"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: 5,
              color: Color(0xffe7e6e6),
            ),
            Expanded(child:SingleChildScrollView(child: Column(children: [checkLoading ? Container(
              height: MediaQuery.of(context).size.height-96,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: LoadingAnimationWidget.waveDots(color: Colors.red, size: 40),
              ),
            ):
            Container(
              height: MediaQuery.of(context).size.height-96,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  item.data.isEmpty ?
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    top: 90,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/image/shopping-cart.png",
                          height: 150,
                          width: 150,
                        ),
                        SizedBox(height: 10,),
                        Text("Chưa có đơn hàng",style: TextStyle(fontFamily: "LibreBodoni-Medium",fontSize: 18,color: Color(
                            0xff7d7d7d)),)
                      ],
                    ),
                  ) : item.isLoading ==true ?
                  Container():ListView.builder(
                      padding: EdgeInsets.only(bottom: 70),
                      itemCount: item.data.length,
                      itemBuilder: (context, index) {
                        final getLength=item.data[index];
                        final getId=getLength["key"];
                        final itemData=getLength["data"];
                        final quantityController = quantityControllers[index];
                        if (quantityController.text.isEmpty) {
                          quantityController.text = itemData["quantity"];
                        }
                        return Stack(
                          children: [
                            Card(
                              elevation: 3,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: selectedItems.contains(index),
                                    onChanged: (newValue) {
                                      setState(() {
                                        if (newValue!) {
                                          selectedItems.add(index);
                                          selectedItemsList.add(item.data[index]);
                                        } else {
                                          selectedItems.remove(index);
                                          selectedItemsList.removeWhere((element) => element['key'] == getLength['key']);
                                        }
                                        selectTotalPrice();
                                        loadingTotalPrice();
                                      });
                                    },
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Image.network(
                                      itemData["imageUrl"],
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(top: 10),
                                          width: MediaQuery.of(context)
                                              .size.width - 230,
                                          child: Text(
                                            itemData["productName"],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily:
                                                "LibreBaskerville-Regular"),
                                          )),
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 7),
                                          child: Text(itemData["price"]+"₫",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: "LibreBodoni-Medium",color: Color(
                                                  0xffff0000)))),
                                      Row(
                                        children: [
                                          Material(
                                            color: Colors.white.withOpacity(0.0),
                                            child: InkWell(
                                              child: Container(width: 30, height: 30,
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: .5,color: Colors.grey),
                                                ),
                                                child: Image.asset("assets/image/minus (1).png",
                                                  color: Colors.grey,),
                                              ),
                                              onTap: quantityController.text!="1" ? (){
                                                setState(() {
                                                  int currentQuantity = int.parse(quantityController.text);
                                                  if (currentQuantity > 1) {
                                                    quantityController.text = (currentQuantity - 1).toString();
                                                    minus(getId, currentQuantity);
                                                  }
                                                });}:null,
                                            ),
                                          ),
                                          Container(
                                            width: 70,height: 30,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(width: .5, color: Colors.grey),
                                                bottom: BorderSide(width: .5, color: Colors.grey),
                                              ),
                                            ),
                                            child: TextField(
                                              textInputAction: TextInputAction.none,
                                              controller: quantityController,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.digitsOnly,
                                                LengthLimitingTextInputFormatter(2),
                                              ],
                                              onChanged:(value){
                                                if (value.isEmpty) {
                                                  quantityController.text = "0";
                                                } else if (value.startsWith("0")) {
                                                  quantityController.text = value.substring(1);
                                                }
                                                addQuantity(getId, quantityController.text);
                                                selectTotalPrice();

                                              },
                                              keyboardType: TextInputType.number,
                                              style: TextStyle(color: Colors.red),
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide.none
                                                  )
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: Colors.white.withOpacity(0.0),
                                            child: InkWell(
                                              child: Container(width: 30, height: 30,
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: .5,color: Colors.grey),
                                                ),
                                                child: Image.asset("assets/image/plus-sign.png",
                                                  color: Colors.grey,),
                                              ),
                                              onTap: (){
                                                setState(() {
                                                  int currentQuantity = int.parse(quantityController.text);
                                                  quantityController.text = (currentQuantity + 1).toString();
                                                  add(getId, int.parse(quantityController.text));
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  IconButton(onPressed: (){_diadelete(context,getId);}, icon: Image.asset("assets/image/close.png",width: 25,height: 25,))
                                ],
                              ),
                            )
                          ],
                        );
                      }
                  ),
                  Positioned(
                      width: MediaQuery.of(context).size.width,
                      bottom: 0,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 2,
                              color: Color(0xffe7e6e6),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: item.data.isEmpty? false : selectAll,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectAll = newValue!;
                                            if (selectAll) {
                                              selectedItemsList.clear();
                                              for (int i = 0; i < item.data.length; i++) {
                                                selectedItems.add(i);
                                                selectedItemsList.add(item.data[i]);
                                              }
                                            } else {
                                              selectedItems.clear();
                                              selectedItemsList.clear();
                                            }
                                            selectTotalPrice();
                                            item.data.isNotEmpty?
                                            loadingTotalPrice():null;
                                          });
                                        },
                                      ),
                                      Container(
                                          width: 90,
                                          child: Text(
                                            "Tổng thanh toán",
                                            style: TextStyle(
                                                fontFamily: "LibreBodoni-Medium",
                                                fontSize: 16),
                                          )),

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      loading?CircularProgressIndicator(strokeAlign: -5,):
                                      Text("$result₫",
                                          style: TextStyle(
                                              fontFamily: "LibreBodoni-Medium",
                                              color: Colors.red,
                                              fontSize: 16)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              Color(0xffff6900),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 13,
                                                  horizontal: 13)),
                                          onPressed: selectedItemsList.isNotEmpty? () {
                                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>payProduct(totaPrice: totalPayment,data: selectedItemsList,)));
                                          }:null,
                                          child: Text("Thanh toán",
                                              style: TextStyle(
                                                  fontFamily:
                                                  "LibreBodoni-Medium",
                                                  fontSize: 13))),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 0),
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              color: Color(0xffe7e6e6),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            )],),) )
          ],
        ),
      ),
    );
  }
}