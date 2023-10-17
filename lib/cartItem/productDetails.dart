import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lab5/changeNotifier/ProfileUser.dart';
import 'package:lab5/main.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
class viewproductDetails extends State<productDetails> {

  Future<void> AddBuy({String? checkBuy}){
    return showModalBottomSheet(context: context, builder: (context)=>
        bottomSheet(
          data: widget.data,
          check:checkBuy,
          keyID:widget.keyId,
        )
    );
  }
  bool showFullText = false;
  bool checkFavorite = true, checkText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                            margin: EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              widget.data["Price  "] + "₫",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "LibreBodoni-Medium",
                                  fontSize: 20),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              widget.data["ProductName  "],
                              style: TextStyle(
                                  fontFamily: "LibreBaskerville-Regular",
                                  fontSize: 20),
                            )),
                        Container(
                            margin:
                                EdgeInsets.only(left: 10, top: 10, bottom: 20),
                            child: Row(
                              children: [
                                Text(
                                  "4.4",
                                  style: TextStyle(color: Color(0xfffb6e2e)),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color(0xfffb6e2e),
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("(" "30" ")"),
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  width: 1,
                                  height: 20,
                                  color: Colors.grey,
                                ),
                                Text(
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
                          color: Color(0xffF1F1F1),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 15, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mô tả về sản phẩm",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "LibreBaskerville-Regular",
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.data["Description  "] ?? "",
                                style: TextStyle(
                                  fontFamily: "LibreBodoni-Medium",
                                  color: Color(0xff646464),
                                  wordSpacing: 1,
                                ),
                                overflow: showFullText
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                                maxLines: showFullText ? null : 5,
                              ),
                              SizedBox(
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
                                      ? Text("Ẩn bớt")
                                      : Text("Xem thêm"),
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
                          color: Color(0xffF1F1F1),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 15, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Đánh giá của khách hàng",
                                        style: TextStyle(
                                            fontFamily: "LibreBodoni-Medium",
                                            fontSize: 17),
                                      ),
                                      Text(
                                        "(190)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Text(
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
                                    "4.9",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    " / 5",
                                    style: TextStyle(
                                        color: Color(0xff817F7F), fontSize: 18),
                                  ),
                                  Image.asset(
                                    "assets/image/Group 28.png",
                                    height: 20,
                                    width: 90,
                                  )
                                ],
                              ),
                              ListView.builder(
                                itemCount: 2,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        width: double.infinity,
                                        height: 1,
                                        color: Color(0xffDAD6D6),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Minh Tú",
                                                style: TextStyle(fontSize: 18),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Sản Phẩm: ",
                                                style: TextStyle(
                                                    color: Color(0xff817F7F),
                                                    fontSize: 16),
                                              ),
                                              Container(
                                                  width: 100,
                                                  child: Text(
                                                    "Điện thoại Redmi Note 13 Pro",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/image/Group 28.png",
                                        height: 20,
                                        width: 80,
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        width: double.infinity,
                                        height: 1,
                                        color: Color(0xffDAD6D6),
                                      ),
                                      Text(
                                          "Giá siêu rẻ, vừa với tầm giá ,sử dụng mượt mà, màu sắc đẹp."),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey,
                                      )
                                    ],
                                  );
                                },
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                height: 1,
                                color: Color(0xffDAD6D6),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 60),
                          width: double.infinity,
                          height: 10,
                          color: Color(0xffDAD6D6),
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
                              checkFavorite = !checkFavorite;
                            });
                          },
                          child: checkFavorite
                              ? Image.asset(
                                  "assets/image/Mask-group.png",
                                  height: 100,
                                  width: 100,
                                )
                              : Image.asset(
                                  "assets/image/Group-84.png",
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
                            child:Image.asset(
                          "assets/image/left-chevron.png",
                          width: 20,
                          height: 20,
                        )),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      color: Color(0xff2BBAA9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {},
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
                              onTap: () {AddBuy(checkBuy: "AddtoCart");},
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
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          AddBuy(checkBuy: "AddBuy");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFF6900),
                            shape:
                                RoundedRectangleBorder(side: BorderSide.none)),
                        child: Text("Mua ngay"),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
class bottomSheet extends StatefulWidget{
  final  Map<String, dynamic> data;
  final String? check;
  final String? keyID;
  const bottomSheet({super.key, required this.data,required this.check,required this.keyID});
  showButtomSheet createState() => showButtomSheet();
}
class showButtomSheet extends State<bottomSheet>{
  bool checkCount= false;
  final countController= TextEditingController();
  int count=1;
  @override
  void initState() {
    super.initState();
    countController.text=count.toString();
    Provider.of<getProflieUser>(context,listen: false).fetchData();
  }
  void addToCart() async{
    final item = Provider.of<getProflieUser>(context,listen: false);
    item.fetchData();
    final _firestore =FirebaseFirestore.instance;
    await _firestore.collection('User').doc(item.data[0]["key"]).collection("Cart").add(
      {
        "productID":widget.keyID,
        "productName":widget.data["ProductName  "],
        "quantity": countController.text,
        "price":widget.data["Price  "],
        "imageUrl":widget.data["ImageURL "],
        "createdAt":Timestamp.now()
      }
    ).then((value) {
      print("Ok");
    }).catchError((e){
      print("lỗi");
    });
    EasyLoading.showToast("Thêm vào giỏ hàng thành công");
    Navigator.pop(context);
  }
  void minusCount (){
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
  void addCount (){
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
  @override
  Widget build(BuildContext context) {
    final isEditing = widget.check == "AddtoCart";
    final buttonText = isEditing ? 'Thêm vào giỏ hàng' : 'Thanh toán';
    return Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 330,
            child: Stack(children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.end,
                      children: [
                        Image.network(
                          widget.data["ImageURL "],
                          height: 150,
                          width: 150,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data["Price  "] +
                                  "₫",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontFamily:
                                  "LibreBodoni-Bold"),
                            ),
                            Text(
                              "Kho: " +
                                  widget.data["Price  "],
                              style: TextStyle(
                                  color: Colors.grey),
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
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Số lượng ",style: TextStyle(fontSize: 18,color: Colors.grey),),
                        Row(
                          mainAxisSize: MainAxisSize.min
                          ,children: [
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
                              onTap:  checkCount ? ()=> minusCount() : null,
                            ),
                          ),
                          Container(
                            width: 50,height: 30,
                            decoration: BoxDecoration(
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
                                }else{
                                  checkCount=true;
                                }
                              },
                              controller: countController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 17),
                                border: InputBorder.none,
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
                              onTap: (){addCount();},
                            ),
                          ),
                        ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
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
                      onPressed: () {Navigator.pop(context);},
                      icon: Image.asset(
                          "assets/image/close (1).png"))),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if(widget.check == "AddtoCart"){
                       addToCart();
                      }else{
                        print("pay");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFF6900),
                        shape:
                        RoundedRectangleBorder(side: BorderSide.none)),
                    child: Text(buttonText),
                  ),
                ),
              ),
            ]),
          );
        }
}
