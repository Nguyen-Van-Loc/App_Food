import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
class Image1 {
  String text, image;
  int item1;
  Image1(this.text, this.image,this.item1);
}final List<Image1> imgList1 = [
  Image1("Laptop",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Laptop-129x129.png",120),
  Image1("Tablet",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Tablet-128x129.png",30),
  Image1("Ốp lưng",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Oplung-128x128.png",50),
  Image1("Chuột máy tính",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/chuot-128x129.png",80),
  Image1("Máy cũ giá rẻ",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/icon-may-cu-60x60.png",70),
  Image1("Bàn phím",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/ban-phim-128x129.png",40),
  Image1("Loa",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Loa-128x128.png",20),
  Image1("Tai nghe",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Tainghe-128x129.png",10),
  Image1("Sạc dự phòng",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Sacduphong-128x129.png",70),
  Image1("Phụ kiện gaming",
      "https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//content/Phukiengaming-128x129.png",20),
];
class viewMenu extends State<menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            "Danh mục ",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold,fontFamily: "LibreBodoni-BoldItalic"),
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
                      onTap: () {},
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 30, bottom: 20, right: 10, left: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(CupertinoIcons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10)),
                ),
              ),
          Stack(
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Color(0xffee683f),
                  ),
                  width: 120,
                  height: imgList1.length*125
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 20,top: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () {},
                          child: Stack(
                            children: [
                              Positioned(
                                left: 70,
                                top: 10,
                                child: Container(
                                padding: EdgeInsets.only(left: 30,top: 10),
                                  width:
                                  MediaQuery.of(context).size.width - 100,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(1, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(imgList1[index].text,style: TextStyle(fontSize: 25,fontFamily: "LibreBodoni-Medium"),),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text(imgList1[index].item1.toString(), style:TextStyle(fontFamily: "LibreBodoni-Italic"),),
                                          Text(" Sản Phẩm",style:TextStyle(fontFamily: "LibreBodoni-Italic"))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20,bottom: 20,top: 15),
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.5),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: Offset(0, 4),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                    ),
                                    child: Image.network(imgList1[index].image),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20,bottom: 8),
                                    padding: EdgeInsets.all(8),
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xFFFBFBFB),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.5),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child:
                                      Image.asset("assets/image/arrowhead.png"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: imgList1.length,
                  ))
            ],
          )]
          ),
        ),
      ),
    );
  }
}
