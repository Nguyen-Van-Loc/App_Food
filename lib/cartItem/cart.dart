import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab5/main.dart';

class Image1 {
  String text, image, price;
  int count;

  Image1(this.text, this.image, this.count, this.price);
}

final List<Image1> imgList1 = [
  Image1(
      "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Laptop-129x129.png",
      2,
      "3.199.000"),
  Image1(
      "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Tablet-128x129.png",
      2,
      "3.199.000"),
  Image1(
      "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Oplung-128x128.png",
      4,
      "3.199.000"),
  Image1(
      "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/chuot-128x129.png",
      5,
      "3.199.000"),
  Image1(
      "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/ban-phim-128x129.png",
      7,
      "3.199.000"),
  Image1(
      "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Loa-128x128.png",
      7,
      "3.199.000"),
  Image1(
      "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Tainghe-128x129.png",
      7,
      "3.199.000"),
  Image1(
      "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Sacduphong-128x129.png",
      8,
      "3.199.000"),
  Image1(
      "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Phukiengaming-128x129.png",
      17,
      "3.199.000"),
];

class viewCart extends State<cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              margin: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width,
              height: 5,
              color: Color(0xffe7e6e6),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 116,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
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
                  ),
                  // ListView.builder(
                  //     padding: EdgeInsets.only(bottom: 70),
                  //     itemCount: imgList1.length,
                  //     itemBuilder: (context, index) => Stack(
                  //           children: [
                  //             Card(
                  //               elevation: 3,
                  //               margin: EdgeInsets.symmetric(
                  //                   horizontal: 15, vertical: 15),
                  //               child: Row(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Image.network(
                  //                     imgList1[index].image,
                  //                     width: 100,
                  //                     height: 100,
                  //                   ),
                  //                   Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Container(
                  //                           width: MediaQuery.of(context)
                  //                               .size.width - 130,
                  //                           child: Text(
                  //                             imgList1[index].text,
                  //                             overflow: TextOverflow.ellipsis,
                  //                             style: TextStyle(
                  //                                 fontSize: 17,
                  //                                 fontFamily:
                  //                                     "LibreBaskerville-Regular"),
                  //                           )),
                  //                       Container(
                  //                           margin: EdgeInsets.symmetric(
                  //                               vertical: 7),
                  //                           child: Text(imgList1[index].price+"₫",
                  //                               style: TextStyle(
                  //                                   fontSize: 17,
                  //                                   fontFamily: "LibreBodoni-Medium",color: Color(
                  //                                   0xffff0000)))),
                  //                       Row(
                  //                         children: [
                  //                           InkWell(
                  //                             onTap: () {},
                  //                             child: Container(
                  //                               padding: EdgeInsets.all(10),
                  //                               color: Color(0xffe6e3e3),
                  //                               child: Image.asset(
                  //                                 "assets/image/minus.png",
                  //                                 height: 10,
                  //                                 width: 10,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           Container(
                  //                               width: 50,
                  //                               height: 20,
                  //                               child: Center(
                  //                                   child: Text(imgList1[index]
                  //                                       .count
                  //                                       .toString()))),
                  //                           InkWell(
                  //                             onTap: () {},
                  //                             child: Container(
                  //                               padding: EdgeInsets.all(10),
                  //                               color: Color(0xffe6e3e3),
                  //                               child: Image.asset(
                  //                                 "assets/image/add (1).png",
                  //                                 height: 10,
                  //                                 width: 10,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       )
                  //                     ],
                  //                   )
                  //                 ],
                  //               ),
                  //             )
                  //           ],
                  //         )),
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
                                  Container(
                                      width: 100,
                                      child: Text(
                                        "Tổng thanh toán",
                                        style: TextStyle(
                                            fontFamily: "LibreBodoni-Medium",
                                            fontSize: 17),
                                      )),
                                  Row(
                                    children: [
                                      Text("123.456.790₫",
                                          style: TextStyle(
                                              fontFamily: "LibreBodoni-Medium",
                                              color: Colors.red,
                                              fontSize: 17)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xffff6900),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 13,
                                                  horizontal: 15)),
                                          onPressed: () {Navigator.push(context, CupertinoPageRoute(builder: (context)=>payProduct()));},
                                          child: Text("Thanh toán",
                                              style: TextStyle(
                                                  fontFamily:
                                                      "LibreBodoni-Medium",
                                                  fontSize: 15))),
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
            )
          ],
        ),
      ),
    );
  }
}
