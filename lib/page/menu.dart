import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../changeNotifier/Categories.dart';
import '../main.dart';

class viewMenu extends State<menu> {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<getCategories>(context);
    item.fetchDataCategories();
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
                          "Danh mục ",
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
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: Color(0xffee683f),
                    ),
                    width: 120,
                    height: item.data.length*130),
                Container(
                    margin: EdgeInsets.only(bottom: 20, top: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final getItem = item.data[index];
                        final itemData = getItem["data"] ?? "";
                        return Card(
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          elevation: 3,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 13),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                          )
                                        ],
                                        color: Colors.white),
                                    padding: EdgeInsets.all(10),
                                    child: Image.network(
                                      itemData["image"],
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          itemData["name"],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "LibreBodoni-Medium"),
                                        ),
                                        margin: EdgeInsets.only(top: 20),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: Text(
                                              itemData["description"],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily:
                                                      "LibreBodoni-Medium"),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              " Sản phẩm",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily:
                                                      "LibreBodoni-Medium"),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                                Image.asset("assets/image/arrowhead.png",height: 30,width: 30,)
                              ]
                            ),
                          ),
                        );
                      },
                      itemCount: item.data.length,
                    ))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
