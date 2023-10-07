import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class viewNotifications extends State<notifications> {
  bool showAllText = false;

  @override
  Widget build(BuildContext context) {
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
                        "Thông báo",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "LibreBodoni-BoldItalic"),
                      ),
                      Container(
                        margin: const EdgeInsets.only( right: 15),
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
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20, left: 10),
                      width: 90,
                      height: 100,
                      color: Colors.grey,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width - 140,
                      child: Column(
                        children: [
                          Text(
                            "Đơn hàng ... đã được xác chúng tôi xác nhận và đơn hàng đang được giao cho đơn vị vận chuyển .Quý khách hàng kiểm tra thông báo thường xuyên để cập nhật thông tin mới nhất .Xin cảm ơn !",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium", fontSize: 14),
                            overflow: showAllText
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            maxLines: showAllText ? null : 3,
                          ),
                          TextButton.icon(
                              onPressed: () {setState(() {
                                showAllText=!showAllText;
                              });},
                              icon: showAllText
                                  ? Image.asset(
                                      "assets/image/minus (2).png",
                                      height: 15,
                                      width: 15,
                                    )
                                  : Image.asset(
                                      "assets/image/add (2).png",
                                      height: 15,
                                      width: 15,
                                    ),
                              label: showAllText
                                  ? Text("Ẩn bớt")
                                  : Text("Xem thêm"))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
