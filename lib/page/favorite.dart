import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class viewFavorite extends State<favorite> with AutomaticKeepAliveClientMixin {
  bool check =true;
  void _check(){
    setState(() {
      check=!check;
    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      margin: const EdgeInsets.only(right: 15),
                        child: InkWell(
                          child: const Icon(
                            CupertinoIcons.cart_fill,
                            size: 25,
                          ),
                          onTap: () {Navigator.push(context, CupertinoPageRoute(builder: (context)=>cart()));},
                        ),
                      )
                    ],
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 5,
                color: Color(0xffe7e6e6),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {},
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
                                "https://cdn.tgdd.vn/Products/Images/44/314849/msi-bravo-15-b7ed-r5-010vn-thumb-1-600x600.jpg",
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
                                        child: const Text(
                                          "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
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
                                              child: const Text(
                                                "15.490.000₫",
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
                            Positioned(right: 0,child: GestureDetector(onTap:(){_check();},child: check? Image.asset("assets/image/Mask-group.png",height:80):Image.asset("assets/image/Group-84.png",height:80) ))
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
