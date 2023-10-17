import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../changeNotifier/Categories.dart';
import '../main.dart';

class Image1 {
  String text, image;

  Image1(this.text, this.image);
}

final CarouselController _controller = CarouselController();
final List<String> imgList = [
  'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn/2023/09/banner/Banner-1---Desk-380x200.png',
  'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn/2023/09/banner/Banner-1---Desk--2--380x200.png',
  'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn/2023/09/banner/Banner-1---Desk--3--380x200.png',
  'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn/2023/09/banner/Banner-1---Desk--1--380x200.png',
];
final List<Widget> imageSliders = imgList
    .map(
      (item) =>
      Container(
        margin: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(color: Colors.green, spreadRadius: 1),
            ],
          ),
          child: Image.network(
            item,
            fit: BoxFit.cover,
            width: 1000.0,
            height: 190,
          ),
        ),
      ),
)
    .toList();

class viewHome extends State<home> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<getProducts>(context, listen: false).fetchDataProducts();
    Provider.of<getCategories>(context, listen: false).fetchDataCategories();
    final item1 = Provider.of<getProducts>(context,listen: false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          if (countStart < item1.data.length) {
            loading=true;
            Future.delayed(Duration(seconds: 3));
            countStart += 10;
          }
        });
      }
    });
  }
  bool showShimmer = true ,loading=true;
  ScrollController _scrollController = ScrollController();
  int countStart=10;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final item = Provider.of<getCategories>(context);
    final item1 = Provider.of<getProducts>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10),
                        child: const Text(
                          "Wellcome to Luxury",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: "LibreBodoni-Italic"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, right: 15),
                        child: InkWell(
                          child: const Icon(
                            CupertinoIcons.cart_fill,
                            size: 25,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => cart()));
                          },
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 50, bottom: 30, right: 10, left: 10),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: const Icon(CupertinoIcons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 10)),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Danh mục",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "LibreBodoni-Medium"),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => menu()));
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Xem thêm",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "LibreBodoni-Medium"),
                                ),
                                Image.asset(
                                  "assets/image/right-arrow.png",
                                  width: 15,
                                  height: 15,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 140,
                      child: ListView.builder(
                          itemCount: item.isLoading ? 6 : item.data.length - 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (item.isLoading) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: InkWell(
                                  onTap: () {},
                                  child: Card(
                                    elevation: 3,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.white,
                                        ),
                                        Container(
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              final getItem = item.data[index];
                              final itemData = getItem["data"] ?? "";
                              return InkWell(
                                onTap: () {},
                                child: Card(
                                  elevation: 3,
                                  child: Column(
                                    children: [
                                      Image.network(
                                        itemData["image"] ?? "",
                                        height: 100,
                                        width: 100,
                                      ),
                                      Text(itemData['name'] ?? ""),
                                    ],
                                  ),
                                ),
                              );
                            }
                          })),
                  Card(
                    color: const Color(0xff6cd347),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 10,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Gợi ý hôm nay",
                                style: TextStyle(
                                    fontFamily: "LibreBodoni-Bold",
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                aspectRatio: 2.0,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                CenterPageEnlargeStrategy.height,
                              ),
                              items: imageSliders,
                              carouselController: _controller,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => _controller.previousPage(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        color:
                                        Colors.transparent.withOpacity(.3),
                                      ),
                                      width: 40,
                                      height: 50,
                                      child: const Icon(
                                        CupertinoIcons.left_chevron,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => _controller.nextPage(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        color:
                                        Colors.transparent.withOpacity(.3),
                                      ),
                                      width: 40,
                                      height: 50,
                                      child: const Icon(
                                        CupertinoIcons.right_chevron,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomRight,
                            colors: [Color(0xfff67d77), Color(0xfffc2b55)])),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Yêu thích nhiều nhất",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "LibreBodoni-Bold",
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) =>
                                  InkWell(
                                    onTap: () {},
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15)),
                                      elevation: 10,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.only(
                                                bottom: 50),
                                            child: Image.network(
                                              "https://cdn.tgdd.vn/Products/Images/44/314849/msi-bravo-15-b7ed-r5-010vn-thumb-1-600x600.jpg",
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery
                                                  .of(context)
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
                                                      margin:
                                                      const EdgeInsets.only(
                                                          left: 10, top: 5),
                                                      width: 200,
                                                      child: const Text(
                                                        "Acer Aspire 5 A514 54 5127 i5 1135G7 (NX.A28SV.007)",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                        TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                            "LibreBaskerville-Regular"),
                                                      )),
                                                  Container(
                                                    width:
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
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
                                                                Text("("
                                                                    "30"
                                                                    ")")
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 10),
                                                            child: const Text(
                                                              "15.490.000₫",
                                                              style: TextStyle(
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
                                            left: 10,
                                            height: 70,
                                            width: 70,
                                            child: Image.network(
                                                "https://media.giphy.com/media/MCFNLhqxTnaRaaEyn1/giphy.gif"),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: const Color(0xffeaeaea),
                    margin: const EdgeInsets.only(top: 10),
                    elevation: 2,
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: item1.isLoading ? 6 : countStart,
                            shrinkWrap: true,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, mainAxisExtent: 370),
                            itemBuilder: (context, index) {
                              if (item1.isLoading){
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
                              }else if(loading && index >= countStart){
                                return CircularProgressIndicator();
                              }
                              else{
                                final getItem = item1.data[index];
                                final itemData = getItem["data"];
                                final keyId = getItem["key"];
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          CupertinoPageRoute(
                                              builder: (context) =>productDetails(data: itemData, keyId: keyId)));
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
                                                itemData["ProductName  "],
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
                                                      itemData["Price  "],
                                                      style: TextStyle(
                                                          fontFamily:
                                                          "LibreBodoni-Medium",
                                                          fontSize: 17,
                                                          color:
                                                          Color(0xffd0021c),
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Text("₫",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffd0021c),
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                    )
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
                                if(loading){
                                  CircularProgressIndicator();
                                }
                              }
                              }
                            )),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
