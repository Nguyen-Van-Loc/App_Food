import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:lab5/cartItem/cart.dart';
import 'package:lab5/cartItem/productDetails.dart';
import 'package:lab5/changeNotifier/ProfileUser.dart';
import 'package:lab5/page/notifications.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class favorite extends StatefulWidget {
  viewFavorite createState() => viewFavorite();
}
class viewFavorite extends State<favorite> with AutomaticKeepAliveClientMixin {
  bool? check;
  String? price;
  final NotificationServices _services = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _services.requestNotificationServices();
    _services.firebaseInit(context);
    _services.getDeviceToken().then((value) {
      print(value);
    });
    checkData();
  }
  void checkData()async{
    final itemUser =Provider.of<getProflieUser>(context,listen: false);
    itemUser.fetchData();
    if(itemUser.data.isNotEmpty){
    await Provider.of<getFavouriteUser>(context,listen: false).fetchDataFavourite(itemUser.data[0]["key"]);
    }
  }
  void cancerFavorite(String id)async{
    final firestone =FirebaseFirestore.instance;
    final itemUser = Provider.of<getProflieUser>(context,listen: false);
    itemUser.fetchData();
    final itemFavo =Provider.of<getFavouriteUser>(context,listen: false);
    if(itemUser.data.isNotEmpty){
      itemFavo.fetchDataFavourite(itemUser.data[0]["key"]);
    }
    await firestone.collection('User').doc(itemUser.data[0]["key"]).collection("Favourite").doc(itemFavo.isKeyFavorites(id)).update({
      "Favorite ": false
    });
    EasyLoading.showSuccess("Xóa vào thành công khỏi mục Yêu thích");
  }
  @override
  Widget build(BuildContext context) {
    final itemUser =Provider.of<getProflieUser>(context);
    itemUser.fetchData();
    final itemFavo =Provider.of<getFavouriteUser>(context);
    final itemCart=Provider.of<getCartUser>(context);
    if(itemUser.data.isNotEmpty){
      itemFavo.fetchDataFavourite(itemUser.data[0]["key"]);
      itemCart.fetchDataCart(itemUser.data[0]["key"]);
    }
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 15, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Yêu thích",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "LibreBodoni-BoldItalic"),
                      ),
                      Container(
                          margin: EdgeInsets.only( right: 15),
                          child: badges.Badge(
                            badgeContent: Text(
                              itemCart.data.length.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            showBadge: true,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => cart(),
                                      ));
                                },
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 30,
                                )),
                            ignorePointer: false,
                          ))
                    ],
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 5,
                color: Color(0xffe7e6e6),
              ),
              Expanded(child: SingleChildScrollView(child: Column(children: [ Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: itemFavo.data.length,
                      itemBuilder: (context, index) {
                        final itemIndex=itemFavo.data[index];
                        final itemData=itemIndex["data"];
                        final keyIdCa =itemIndex["categoryKey"];
                        String fomatPrice =
                        NumberFormat.decimalPattern("vi")
                            .format(itemData["Price  "]);
                        price =
                            fomatPrice.toString().replaceAll(",", ".");
                        if(itemData["Favorite "]==true && itemFavo.data.isNotEmpty){
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          productDetails(
                                              data: itemData,
                                              keyId: itemData["ProductId "],keyIdCa: keyIdCa,)));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15)),
                              elevation: 10,
                              margin:
                              const EdgeInsets.symmetric(vertical: 10),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    padding:
                                    const EdgeInsets.only(bottom: 50),
                                    child: Image.network(
                                      itemData["ImageURL "],height: 170,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width,
                                      decoration: const BoxDecoration(
                                          borderRadius:
                                          BorderRadius.vertical(
                                              top: Radius.circular(
                                                  10)),
                                          color: Color(0xfff1f1f1)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10, top: 5),
                                              width: 200,
                                              child:  Text(
                                                itemData["ProductName"],
                                                overflow: TextOverflow
                                                    .ellipsis,
                                                textAlign:
                                                TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 18,fontFamily: "LibreBaskerville-Regular"),
                                              )),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    margin:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 10,
                                                        top: 5),
                                                    child: const Row(
                                                      children: [
                                                        Text(
                                                          "4.4",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xfffb6e2e)),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color(
                                                              0xfffb6e2e),
                                                          size: 18,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("(" "30" ")")
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                    const EdgeInsets.only(
                                                        right: 10),
                                                    child:  Text(
                                                      "$price₫",
                                                      style: TextStyle(
                                                          fontFamily: "LibreBodoni-Medium",
                                                          fontSize: 18,
                                                          color: Color(
                                                              0xffd0021c),
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                    ),
                                                  ),
                                                ]),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    height: 70,
                                    child: Image.network(
                                        "https://media.giphy.com/media/fUV88nhjfZrhBFkBim/giphy.gif"),
                                  ),
                                  Positioned(right: 0,child: GestureDetector(onTap:(){
                                    setState(() {
                                      cancerFavorite(itemData["ProductId "]);
                                    }); },
                                      child:itemData["Favorite "] ? Image.asset("assets/image/Group-84.png",height:80):Image.asset("assets/image/Mask-group.png",height:80) ))
                                ],
                              ),
                            ),
                          );
                        }else{
                          return Container();
                        }
                      })
              ),
                if(itemFavo.data.isEmpty ||!itemFavo.data.any((getIndex) => getIndex["data"]["Favorite "] == true))
                  Center(
                      child: Column(
                        children: [
                          SizedBox(height: 50,),
                          Image.asset("assets/image/search.png",height: 100,),
                          SizedBox(height: 20,),
                          Text("Bạn chưa có sản phẩm nào yêu thích ?",style: TextStyle(fontSize: 15),),
                        ],
                      )
                  )],),))
            ],
          ),
      ),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
