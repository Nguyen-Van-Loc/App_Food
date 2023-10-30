import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:lab5/barNavigation.dart';
import 'package:lab5/cartItem/addressPay.dart';
import 'package:lab5/changeNotifier/ProfileUser.dart';
import 'package:lab5/page/notifications.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
class payProduct extends StatefulWidget {
  final int totaPrice;
  final List<Map<String,dynamic>> data;
  payProduct({required this.totaPrice,required this.data});
  viewpayProduct createState() => viewpayProduct();
}
List<String> list = ["Thanh toán khi nhận hàng", " Thanh toán qua ví "];
class viewpayProduct extends State<payProduct> {
  final NotificationServices _services = NotificationServices();
  String text = list.first;
  int totalProductPrice = 0;
  int totalAllProductPrices = 0;
  int transport = 30000;
  int totalTransportFee = 0;
  int transportFee = 0;
  int SumtransportFee = 0;
  int SumPrice = 0;
  int sumAllPrice = 0;
  List<int> productTotalPrices = [];
  void addBuyProduct(Map<String, dynamic> selectedAddress)async{
    final itemUser =Provider.of<getProflieUser>(context,listen: false);
    final firestore = FirebaseFirestore.instance;
    List<int> prices = productTotalPrices;
    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
    for (int i = 0; i < widget.data.length; i++) {
      final getItem = widget.data[i];
      final getData = getItem["data"];
      print(getData[""]);
      String formattedTotalPayment = NumberFormat.decimalPattern("vi").format(SumPrice);
      formattedTotalPayment.toString().replaceAll(",", ".");
      String formattransportFee = NumberFormat.decimalPattern("vi").format(prices[i]);
      formattransportFee.toString().replaceAll(",", ".");
      final newDocument = firestore.collection("User").doc(itemUser.data[0]["key"]).collection("History").doc();
      newDocument.set({
        "CategoriesId":getData["CategoriesId"],
        "productKey": getData["productID"],
        "productName": getData["productName"],
        "price": getData["price"],
        "quantity": getData["quantity"],
        "createAt": formattedDate,
        "totalPrice": formattedTotalPayment,
        "paymentMethods":text,
        "address":selectedAddress,
        "transport":transport,
        "transportFee": formattransportFee,
        "orderStatus":"Chờ xác nhận",
        "imageUrl":getData["imageUrl"]
      });
      final newDocument1 = firestore.collection("User").doc(itemUser.data[0]["key"]).collection("Notification").doc();
      newDocument1.set({
        "CategoriesId":getData["CategoriesId"],
        "productKey": getData["productID"],
        "productName": getData["productName"],
        "price": getData["price"],
        "quantity": getData["quantity"],
        "createAt": formattedDate,
        "totalPrice": formattedTotalPayment,
        "paymentMethods":text,
        "address":selectedAddress,
        "transport":transport,
        "transportFee": formattransportFee,
        "orderStatus":"Đang vận chuyển",
        "imageUrl":getData["imageUrl"]
      });
    }

    EasyLoading.show(status: "loading...");
    await Future.delayed(Duration(seconds: 3));
    EasyLoading.showSuccess("Đặt hàng thành công !");
    await Future.delayed(Duration(seconds: 3));
    EasyLoading.show(status: "loading...");
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => barNavigation(),));
    EasyLoading.dismiss();
    for(int i=0; i< widget.data.length;i++){
      await firestore.collection("User").doc(itemUser.data[0]["key"]).collection("Cart").doc(widget.data[i]["key"]).delete();
    }
    _services.getDeviceToken().then((value) async{
      var data = {
        'to':value.toString(),
        'priority':'high',
        'notification':{
          'title':"Thông báo",
          'body':"Bạn đã đặt hàng thành công !"
        },
      };
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body: jsonEncode(data),
        headers: {
          'Content-Type':'application/json; charset=UTF-8',
          'Authorization':'key=AAAA8RSe39E:APA91bHHfagU3E9eknYgyQfdDbi4_UjBcm15mxNyUraAqNuA2foddBkxdYQkR_3u_HH8xyWeFx0MfHHzt_gjvTb1RfaVlj9LTQsLHGq13KMoNsXpe9wiM0aJhGHlY2DRll4N9vJiwvKT'
        }
      );
    });
    widget.data.clear();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading();
    check();
    Provider.of<getProflieUser>(context,listen: false).fetchData();
  }
  bool checkLoading = false;
  void loading() async{
    checkLoading = false;
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      checkLoading = true;
    });
  }
  void check() {
    SumPrice=0;
    transport = 30000;
    totalAllProductPrices = 0;
    totalProductPrice = 0;
    SumtransportFee = 0;
    sumAllPrice = 0;
    for (int i = 0; i < widget.data.length; i++) {
      final getItem = widget.data[i];
      final getData = getItem["data"];
      int price = int.parse(getData["price"].toString().replaceAll(".", "")) *
          int.parse(getData["quantity"]);
      totalAllProductPrices += price;
      if (price < 5000000) {
        transportFee = 15000;
      } else {
        transportFee = 30000;
      }
      totalProductPrice = price + transportFee;
      productTotalPrices.add(transportFee);
      if (transportFee > 0) {
        SumtransportFee += transportFee;
      }
    }
    SumPrice = totalAllProductPrices + transport - SumtransportFee;
  }
  @override
  Widget build(BuildContext context) {
    final itemUser =Provider.of<getProflieUser>(context);
    String formatResult = NumberFormat.decimalPattern("vi").format(totalAllProductPrices);
    String formatTransportFee = NumberFormat.decimalPattern("vi").format(transport);
    String formatSumTransportFee = NumberFormat.decimalPattern("vi").format(SumtransportFee);
    String formatSum = NumberFormat.decimalPattern("vi").format(SumPrice);
    return Scaffold(
      body: SafeArea(
        child: checkLoading ? Stack(children: [
          Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 15),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xFFB0AEAE)),
                            child: Image.asset(
                              "assets/image/left-chevron.png",
                              width: 20,
                              height: 20,
                            )),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Thanh toán",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "LibreBodoni-BoldItalic"),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 5,
                  color: const Color(0xffe7e6e6),
                ),
                Expanded(child: SingleChildScrollView(child:Column(children: [ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.data.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final getItem = widget.data[index];
                      final getData = getItem["data"];
                      String formatFee = getData["price"].toString().replaceAll(".", "");
                      return Column(
                        children: [
                          Card(
                            elevation: 4,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(getData["imageUrl"],
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 150,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        getData["productName"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily:
                                            "LibreBaskerville-Regular"),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        getData["price"]+
                                            "₫",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 17,
                                            fontFamily: "LibreBodoni-Medium"),
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 10, right: 10),
                                        alignment: Alignment.bottomRight,
                                        child: Text("x"+getData["quantity"],
                                            style: TextStyle(
                                                fontFamily: "LibreBodoni-Medium",
                                                color: Color(0xff6D6D6D))),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 2,
                            color: const Color(0xffe7e6e6),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 4,
                                    offset: Offset(2,2)
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Phí vân chuyển :" ,style: TextStyle(fontSize: 15,fontFamily: "LibreBodoni-Medium"),),
                                int.parse(formatFee)>5000000? Text("0₫",style: TextStyle(fontSize: 17,fontFamily: "LibreBodoni-Medium"),):Text("15.000₫",style: TextStyle(fontSize: 18,fontFamily: "LibreBodoni-Medium"),)
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 2,
                            color: const Color(0xffe7e6e6),
                          ),
                        ],
                      )
                      ;}
                ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: const Color(0xffe7e6e6),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Địa chỉ nhận hàng",
                              style: TextStyle(
                                  fontFamily: "LibreBodoni-Medium", fontSize: 18),
                            ),
                            InkWell(
                                onTap: ()async{
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => addressPay()));
                                },
                                child: Image.asset(
                                  "assets/image/next.png",
                                  height: 25,
                                  width: 35,
                                  cacheHeight: 15,
                                )
                            )
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            if(itemUser.addresses.isNotEmpty) {
                              final getItem= itemUser.addresses[index];
                              final getData= getItem.value;
                              return  Card(
                                  elevation: 2,
                                  child: Container(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              getData["username"],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "LibreBodoni-Medium"),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 10,
                                              color: const Color(0xffD3D3D3),
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                            ),
                                            Text(
                                              getData["phone"],
                                              style: const TextStyle(
                                                  fontFamily: "LibreBodoni-Medium",
                                                  color: Color(0xffAEAEAE)),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Ghi chú: ",
                                              style: TextStyle(
                                                  fontFamily: "LibreBodoni-Medium",
                                                  color: Color(0xffAEAEAE)),
                                            ),
                                            Text(
                                              getData["note"],
                                              style: const TextStyle(
                                                  fontFamily: "LibreBodoni-Medium",
                                                  color: Color(0xffAEAEAE)),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Địa chỉ: ",
                                              style: TextStyle(
                                                  fontFamily: "LibreBodoni-Medium",
                                                  color: Color(0xffAEAEAE)),
                                            ),
                                            Text(
                                              getData["address"],
                                              style: const TextStyle(
                                                  fontFamily: "LibreBodoni-Medium",
                                                  color: Color(0xffAEAEAE)),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ));}
                            else{
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white ,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(1,1),
                                          blurRadius: 4,color: Colors.grey.withOpacity(.5)
                                      )
                                    ]
                                ),
                                width: MediaQuery.of(context).size.width-20,
                                height: 100 ,
                                child: Center(child: Text("Vui lòng thêm địa chỉ nhận hàng",style: TextStyle(fontSize: 18,fontFamily: "LibreBodoni-Medium"),)),
                              );}
                          },)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: const Color(0xffe7e6e6),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text("Phương thức thanh toán",
                          style: TextStyle(
                              fontFamily: "LibreBodoni-Medium", fontSize: 18))),
                  DropdownMenu(
                      width: MediaQuery.of(context).size.width - 20,
                      initialSelection: text,
                      onSelected: (value) {
                        setState(() {
                          text = value!;
                        });
                      },
                      dropdownMenuEntries: list
                          .map<DropdownMenuEntry>((value) =>
                          DropdownMenuEntry(value: value, label: value))
                          .toList()),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: const Color(0xffe7e6e6),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10, bottom: 10,top: 10),
                      child: Text("Chi tiết thanh toán",
                          style: TextStyle(
                              fontFamily: "LibreBodoni-Medium", fontSize: 18))),
                  Container(
                    margin: EdgeInsets.only(left: 10, bottom: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tổng số tiền sản phẩm",
                          style: TextStyle(
                              fontFamily: "LibreBodoni-Medium",
                              color: Color(0xff767676)),
                        ),
                        Text(
                          "$formatResult₫",
                          style: TextStyle(
                              fontFamily: "LibreBodoni-Medium", fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, bottom: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phí vận chuyển",
                          style: TextStyle(
                              fontFamily: "LibreBodoni-Medium",
                              color: Color(0xff767676)),
                        ),
                        Text(
                          "$formatTransportFee₫",
                          style: TextStyle(
                              fontFamily: "LibreBodoni-Medium", fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, bottom: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Giảm giá phí vận chuyển",
                          style: TextStyle(
                              fontFamily: "LibreBodoni-Medium",
                              color: Color(0xff767676)),
                        ),
                        Text(
                          "- $formatSumTransportFee₫",
                          style: TextStyle(
                              fontFamily: "LibreBodoni-Medium", fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, bottom: 65, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tổng tiền thanh toán",
                          style: TextStyle(
                              fontFamily: "LibreBodoni-Medium",
                              color: Color(0xff767676)),
                        ),
                        Text(
                          "$formatSum₫",
                          style: TextStyle(
                              fontFamily: "LibreBodoni-Medium",
                              fontSize: 18,
                              color: Colors.red),
                        )
                      ],
                    ),
                  ),],) ,))

              ],
            ),
          Positioned(
            bottom: 0,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: itemUser.addresses.isNotEmpty ?(){
                    if (itemUser.addresses.isNotEmpty) {
                      final selectedAddress = itemUser.addresses[0].value;
                      addBuyProduct(selectedAddress);
                    }
                  }:null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFF6900),
                      shape: RoundedRectangleBorder(side: BorderSide.none)),
                  child: Text("Thanh toán"),
                )),
          )
        ]): isLoading(),
      ),
    );
  }
}
class isLoading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return SingleChildScrollView(
     child: Column(
       children: [
         Container(
           margin: const EdgeInsets.only(left: 15, top: 15),
           child: Row(
             children: [
               InkWell(
                 onTap: () {
                   Navigator.pop(context);
                 },
                 child: Container(
                     padding: const EdgeInsets.all(5),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                         color: const Color(0xFFB0AEAE)),
                     child: Image.asset(
                       "assets/image/left-chevron.png",
                       width: 20,
                       height: 20,
                     )),
               ),
               const SizedBox(
                 width: 20,
               ),
               const Text(
                 "Thanh toán",
                 style: TextStyle(
                     fontSize: 25,
                     fontWeight: FontWeight.bold,
                     fontFamily: "LibreBodoni-BoldItalic"),
               ),
             ],
           ),
         ),
         Container(
           margin: const EdgeInsets.only(top: 20),
           width: MediaQuery.of(context).size.width,
           height: 5,
           color: const Color(0xffe7e6e6),
         ),
         Shimmer.fromColors(  baseColor: Colors.grey[300]!,
           highlightColor: Colors.grey[100]!,
           child:Column(
             children: [
               Card(
                 margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                 child: Row(
                   children: [
                     Container(
                       width: 100,
                       height: 100,
                       padding: const EdgeInsets.all(10),
                       color: Colors.white,
                     ),
                     Container(
                       width: MediaQuery.of(context).size.width - 150,
                       color: Colors.white,
                     ),
                   ],
                 ),
               ),
               Container(
                 margin: const EdgeInsets.only(top: 20),
                 width: MediaQuery.of(context).size.width,
                 height: 2,
                 color: const Color(0xffe7e6e6),
               ),
               Container(
                 height: 120,
                 color: Colors.white,
                 width: MediaQuery.of(context).size.width-20,
                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
               ),
               Container(
                 margin: const EdgeInsets.only(top: 20),
                 width: MediaQuery.of(context).size.width,
                 height: 2,
                 color: const Color(0xffe7e6e6),
               ),
               Container(
                 height: 20,
                 alignment: Alignment.centerLeft,
                 margin: EdgeInsets.only(left: 10, bottom: 10),
                 color: Colors.white,
               ),
               Container(
                 height: 120,
                 alignment: Alignment.centerLeft,
                 margin: EdgeInsets.only(left: 10, bottom: 10),
                 color: Colors.white,
               ),
               Container(
                 margin: const EdgeInsets.only(top: 20),
                 width: MediaQuery.of(context).size.width,
                 height: 2,
                 color: const Color(0xffe7e6e6),
               ),
               Container(
                   margin: const EdgeInsets.only(top: 20),
                   width: MediaQuery.of(context).size.width,
                   height: 100,
                   color: Colors.white),
               Container(
                 margin: const EdgeInsets.only(top: 20),
                 width: MediaQuery.of(context).size.width,
                 height: 100,
                 color: const Color(0xffe7e6e6),
               ),
             ],
           ) ,)
       ],
     ),
   );
  }

}
