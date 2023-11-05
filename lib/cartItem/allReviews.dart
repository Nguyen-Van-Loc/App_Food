// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../changeNotifier/Categories.dart';

class allReviews extends StatefulWidget {
  final String idCa;
  final String idPro;
  const allReviews({super.key,required this.idPro,required this.idCa});

  @override
  State<allReviews> createState() => _allReviewsState();
}

class _allReviewsState extends State<allReviews> {
  @override
  Widget build(BuildContext context) {
    final itemRe = Provider.of<categoryProducts>(context);
    itemRe.productReview(widget.idCa, widget.idPro);
    return Scaffold(
      body: SafeArea(
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
                    "Đánh giá",
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
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  itemCount: itemRe.data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final itemIndex = itemRe.data[index];
                    final itemData = itemIndex["data"];
                    List<dynamic> imageUrls = itemData["imageUrls"];
                    return Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
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
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          itemData["imageUser"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  itemData["username"],
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Sản Phẩm: ",
                                  style: TextStyle(
                                      color: Color(0xff817F7F),
                                      fontSize: 16),
                                ),
                                SizedBox(
                                    width: 100,
                                    child: Text(
                                      itemData["productName"],
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ))
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            for (int i = 1;
                            i <= itemData["numberofStars"];
                            i++)
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                            for (int i = itemData["numberofStars"]
                                .ceil();
                            i < 5;
                            i++)
                              const Icon(
                                Icons.star_border,
                                color: Colors.grey,
                                size: 18,
                              ),
                          ],
                        ),
                        Text(
                            itemData["comment"]),
                        Row(
                          children: [
                            for (dynamic imageUrl in imageUrls)
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                width: 100,
                                height: 100,
                                child: Image.network(imageUrl),
                              ),
                          ],
                        ),
                        Container(
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          height: 1,
                          color: const Color(0xffDAD6D6),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
