import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab5/main.dart';

class viewhistoryCart extends State<historycart> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "Lịch sử mua hàng",
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
              TabBar(
                controller: _tabController,
                tabs: [
                  Text(
                    "Chờ xác nhận",
                    style: TextStyle(
                        fontFamily: "LibreBodoni-Medium", fontSize: 15),
                  ),
                  Text(
                    "Đang vận chuyển",
                    style: TextStyle(
                        fontFamily: "LibreBodoni-Medium", fontSize: 15),
                  ),
                  Text(
                    "Chờ giao hàng",
                    style: TextStyle(
                        fontFamily: "LibreBodoni-Medium", fontSize: 15),
                  ),
                  Text(
                    "Đã nhận",
                    style: TextStyle(
                        fontFamily: "LibreBodoni-Medium", fontSize: 15),
                  ),
                  Text(
                    "Đã hủy",
                    style: TextStyle(
                        fontFamily: "LibreBodoni-Medium", fontSize: 15),
                  ),
                ],
                isScrollable: true,
                labelPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: TabBarView(controller: _tabController, children: [
                  Stack(children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (context, index) => Card(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)),
                        elevation: 5,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 170,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    margin: EdgeInsets.all(10),
                                    child: Image.network(
                                      "https://cdn.tgdd.vn/Products/Images/44/314849/msi-bravo-15-b7ed-r5-010vn-thumb-1-600x600.jpg",
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    margin: const EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 200,
                                                child: const Text(
                                                  "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily:
                                                          "LibreBaskerville-Regular"),
                                                )),
                                            Text(
                                              "15.490.000₫",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 200,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Chờ xác nhận",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "x1",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xff6D6D6D),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ]),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 30),
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: const Text(
                                    "Hủy",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "LibreBodoni-MediumItalic",
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   right: 0,
                    //   left: 0,
                    //   bottom: 0,
                    //   top: 90,
                    //   child: Column(
                    //     children: [
                    //       Image.asset(
                    //         "assets/image/grocery-bag.png",
                    //         height: 150,
                    //         width: 150,
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Text(
                    //         "Chưa có đơn hàng",
                    //         style: TextStyle(
                    //             fontFamily: "LibreBodoni-Medium",
                    //             fontSize: 18,
                    //             color: Color(0xff7d7d7d)),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ]),
                  Stack(
                    children: [
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   itemCount: 2,
                      //   itemBuilder: (context, index) => Card(
                      //     shape: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide: BorderSide(color: Colors.white)),
                      //     elevation: 5,
                      //     margin:
                      //         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      //     child: Container(
                      //       width: MediaQuery.of(context).size.width,
                      //       height: 120,
                      //       child: Row(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Container(
                      //             width: 100,
                      //             height: 100,
                      //             margin: EdgeInsets.all(10),
                      //             child: Image.network(
                      //               "https://cdn.tgdd.vn/Products/Images/44/314849/msi-bravo-15-b7ed-r5-010vn-thumb-1-600x600.jpg",
                      //             ),
                      //           ),
                      //           Container(
                      //             height: 100,
                      //             margin: const EdgeInsets.only(
                      //                 left: 10, top: 10, bottom: 10),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Container(
                      //                         width: 200,
                      //                         child: const Text(
                      //                           "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
                      //                           overflow: TextOverflow.ellipsis,
                      //                           textAlign: TextAlign.left,
                      //                           style: TextStyle(
                      //                               fontSize: 18,
                      //                               fontFamily:
                      //                                   "LibreBaskerville-Regular"),
                      //                         )),
                      //                     Text(
                      //                       "15.490.000₫",
                      //                       style: TextStyle(
                      //                           fontSize: 16,
                      //                           fontWeight: FontWeight.bold),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Container(
                      //                   width: 200,
                      //                   child: Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.spaceBetween,
                      //                       children: [
                      //                         Text(
                      //                           "Đang vận chuyển",
                      //                           style: TextStyle(
                      //                               fontSize: 16,
                      //                               color: Colors.green,
                      //                               fontWeight: FontWeight.bold),
                      //                         ),
                      //                         Text(
                      //                           "x1",
                      //                           style: TextStyle(
                      //                               fontSize: 16,
                      //                               color: Color(0xff6D6D6D),
                      //                               fontWeight: FontWeight.bold),
                      //                         ),
                      //                       ]),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        right: 0,
                        left: 0,
                        bottom: 0,
                        top: 90,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/image/grocery-bag.png",
                              height: 150,
                              width: 150,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Chưa có đơn hàng",
                              style: TextStyle(
                                  fontFamily: "LibreBodoni-Medium",
                                  fontSize: 18,
                                  color: Color(0xff7d7d7d)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Stack(children: [
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   itemCount: 2,
                    //   itemBuilder: (context, index) => Card(
                    //     shape: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: BorderSide(color: Colors.white)),
                    //     elevation: 5,
                    //     margin:
                    //         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //     child: Container(
                    //       width: MediaQuery.of(context).size.width,
                    //       height: 170,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.end,
                    //         children: [
                    //           Row(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Container(
                    //                 width: 100,
                    //                 height: 100,
                    //                 margin: EdgeInsets.all(10),
                    //                 child: Image.network(
                    //                   "https://cdn.tgdd.vn/Products/Images/44/314849/msi-bravo-15-b7ed-r5-010vn-thumb-1-600x600.jpg",
                    //                 ),
                    //               ),
                    //               Container(
                    //                 height: 100,
                    //                 margin: const EdgeInsets.only(
                    //                     left: 10, top: 10, bottom: 10),
                    //                 child: Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Container(
                    //                             width: 200,
                    //                             child: const Text(
                    //                               "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
                    //                               overflow:
                    //                                   TextOverflow.ellipsis,
                    //                               textAlign: TextAlign.left,
                    //                               style: TextStyle(
                    //                                   fontSize: 18,
                    //                                   fontFamily:
                    //                                       "LibreBaskerville-Regular"),
                    //                             )),
                    //                         Text(
                    //                           "15.490.000₫",
                    //                           style: TextStyle(
                    //                               fontSize: 16,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     Container(
                    //                       width: 200,
                    //                       child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment
                    //                                   .spaceBetween,
                    //                           children: [
                    //                             Text(
                    //                               "Giao hàng thành công",
                    //                               style: TextStyle(
                    //                                   fontSize: 16,
                    //                                   color: Colors.green,
                    //                                   fontWeight:
                    //                                       FontWeight.bold),
                    //                             ),
                    //                             Text(
                    //                               "x1",
                    //                               style: TextStyle(
                    //                                   fontSize: 16,
                    //                                   color: Color(0xff6D6D6D),
                    //                                   fontWeight:
                    //                                       FontWeight.bold),
                    //                             ),
                    //                           ]),
                    //                     )
                    //                   ],
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //           Container(
                    //             height: 1,
                    //             color: Colors.grey,
                    //           ),
                    //           Container(
                    //             margin: EdgeInsets.only(right: 10),
                    //             child: ElevatedButton(
                    //               onPressed: () {},
                    //               style: ElevatedButton.styleFrom(
                    //                   backgroundColor: Colors.red,
                    //                   padding: const EdgeInsets.symmetric(
                    //                       vertical: 10, horizontal: 30),
                    //                   elevation: 2,
                    //                   shape: RoundedRectangleBorder(
                    //                       borderRadius:
                    //                           BorderRadius.circular(10))),
                    //               child: const Text(
                    //                 "Đã nhận",
                    //                 style: TextStyle(
                    //                     color: Colors.white,
                    //                     fontFamily: "LibreBodoni-MediumItalic",
                    //                     fontSize: 15),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      top: 90,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/image/grocery-bag.png",
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Chưa có đơn hàng",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium",
                                fontSize: 18,
                                color: Color(0xff7d7d7d)),
                          )
                        ],
                      ),
                    ),
                  ]),
                  Stack(children: [
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   itemCount: 2,
                    //   itemBuilder: (context, index) => Card(
                    //     shape: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: BorderSide(color: Colors.white)),
                    //     elevation: 5,
                    //     margin:
                    //         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //     child: Container(
                    //       width: MediaQuery.of(context).size.width,
                    //       height: 120,
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Container(
                    //             width: 100,
                    //             height: 100,
                    //             margin: EdgeInsets.all(10),
                    //             child: Image.network(
                    //               "https://cdn.tgdd.vn/Products/Images/44/314849/msi-bravo-15-b7ed-r5-010vn-thumb-1-600x600.jpg",
                    //             ),
                    //           ),
                    //           Container(
                    //             height: 100,
                    //             margin: const EdgeInsets.only(
                    //                 left: 10, top: 10, bottom: 10),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Container(
                    //                         width: 200,
                    //                         child: const Text(
                    //                           "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
                    //                           overflow: TextOverflow.ellipsis,
                    //                           textAlign: TextAlign.left,
                    //                           style: TextStyle(
                    //                               fontSize: 18,
                    //                               fontFamily:
                    //                                   "LibreBaskerville-Regular"),
                    //                         )),
                    //                     Text(
                    //                       "15.490.000₫",
                    //                       style: TextStyle(
                    //                           fontSize: 16,
                    //                           fontWeight: FontWeight.bold),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Container(
                    //                   width: 200,
                    //                   child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text(
                    //                           "Đã nhận",
                    //                           style: TextStyle(
                    //                               fontSize: 16,
                    //                               color: Colors.green,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                         Text(
                    //                           "x1",
                    //                           style: TextStyle(
                    //                               fontSize: 16,
                    //                               color: Color(0xff6D6D6D),
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                       ]),
                    //                 )
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      top: 90,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/image/grocery-bag.png",
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Chưa có đơn hàng",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium",
                                fontSize: 18,
                                color: Color(0xff7d7d7d)),
                          )
                        ],
                      ),
                    ),
                  ]),
                  Stack(children: [
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   itemCount: 2,
                    //   itemBuilder: (context, index) => Card(
                    //     shape: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: BorderSide(color: Colors.white)),
                    //     elevation: 5,
                    //     margin:
                    //         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //     child: Container(
                    //       width: MediaQuery.of(context).size.width,
                    //       height: 120,
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Container(
                    //             width: 100,
                    //             height: 100,
                    //             margin: EdgeInsets.all(10),
                    //             child: Image.network(
                    //               "https://cdn.tgdd.vn/Products/Images/44/314849/msi-bravo-15-b7ed-r5-010vn-thumb-1-600x600.jpg",
                    //             ),
                    //           ),
                    //           Container(
                    //             height: 100,
                    //             margin: const EdgeInsets.only(
                    //                 left: 10, top: 10, bottom: 10),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Container(
                    //                         width: 200,
                    //                         child: const Text(
                    //                           "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
                    //                           overflow: TextOverflow.ellipsis,
                    //                           textAlign: TextAlign.left,
                    //                           style: TextStyle(
                    //                               fontSize: 18,
                    //                               fontFamily:
                    //                                   "LibreBaskerville-Regular"),
                    //                         )),
                    //                     Text(
                    //                       "15.490.000₫",
                    //                       style: TextStyle(
                    //                           fontSize: 16,
                    //                           fontWeight: FontWeight.bold),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Container(
                    //                   width: 200,
                    //                   child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text(
                    //                           "Đã Hủy",
                    //                           style: TextStyle(
                    //                               fontSize: 16,
                    //                               color: Colors.red,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                         Text(
                    //                           "x1",
                    //                           style: TextStyle(
                    //                               fontSize: 16,
                    //                               color: Color(0xff6D6D6D),
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                       ]),
                    //                 )
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      top: 90,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/image/grocery-bag.png",
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Chưa có đơn hàng",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium",
                                fontSize: 18,
                                color: Color(0xff7d7d7d)),
                          )
                        ],
                      ),
                    ),
                  ]),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
