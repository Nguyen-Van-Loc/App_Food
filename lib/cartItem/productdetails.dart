import 'package:flutter/material.dart';
import 'package:lab5/main.dart';

class viewproductDetails extends State<productDetails> {
  bool checkFavorite = true, checkText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Stack(
                children: [
                  Image.asset(
                    "assets/image/dienthoai.png",
                    width: MediaQuery.of(context).size.width,
                    height: 250,
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
                              "6,150,000₫",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "LibreBodoni-Medium",
                                  fontSize: 20),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              "Điện thoại Redmi Note 13 Pro",
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
                                  "1230",
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
                                    fontFamily: "LibreBaskerville-Regular"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "  - Xiaomi Redmi Note 13 Pro 5G là mẫu điện thoại "
                                "sở hữu camera thông số 200MP siêu khủng. "
                                "Đây là cảm biến camera khủng nhất trên thế "
                                "giới smartphone hiện nay. Bên cạnh đó, thiết "
                                "bị được trang bị chip Dimensity tầm trung mạnh "
                                "mẽ, màn hình OLED 1 tỷ màu chất lượng cao.",
                                style: TextStyle(
                                    fontFamily: "LibreBodoni-Medium",
                                    color: Color(0xff646464),
                                    wordSpacing: 1),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Thiết kế",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "LibreBodoni-Medium",
                                      color: Color(0xff6C6B6B))),
                              Text(
                                "  - Xiaomi Redmi Note 13 Pro 5G là mẫu điện thoại "
                                "sở hữu camera thông số 200MP siêu khủng. "
                                "Đây là cảm biến camera khủng nhất trên thế "
                                "giới smartphone hiện nay. Bên cạnh đó, thiết "
                                "bị được trang bị chip Dimensity tầm trung mạnh "
                                "mẽ, màn hình OLED 1 tỷ màu chất lượng cao.",
                                style: TextStyle(
                                    fontFamily: "LibreBodoni-Medium",
                                    color: Color(0xff646464),
                                    wordSpacing: 1),
                              ),
                              Image.asset(
                                "assets/image/dienthoai.png",
                                height: 241,
                                width: 231,
                              ),
                              Text("Màn hình",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "LibreBodoni-Medium",
                                      color: Color(0xff6C6B6B))),
                              Text(
                                "  - Màn hình Xiaomi Note 13 Pro sử dụng tấm nền OLED 120Hz mang đến màu sắc sống động, "
                                "hỗ trợ bit màu giúp hiển thị tới 1 tỷ màu, cùng hỗ trợ Dolby Vision và HDR10+,"
                                " giúp nâng cao trải nghiệm xem phim và chơi game cho người dùng.",
                                style: TextStyle(
                                    fontFamily: "LibreBodoni-Medium",
                                    color: Color(0xff646464),
                                    wordSpacing: 1),
                                overflow: checkText
                                    ? TextOverflow.ellipsis
                                    : TextOverflow.visible,
                                maxLines: checkText ? 2 : null,
                              ),
                              Center(
                                  child: TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    checkText = !checkText;
                                  });
                                },
                                label: Text("Xem thêm"),
                                icon: Image.asset(
                                  "assets/image/add.png",
                                  height: 20,
                                  width: 20,
                                ),
                              ))
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
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: const EdgeInsets.only(left: 20, top: 15),
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
                          InkWell(
                            onTap: () {},
                            child: Image.asset(
                              "assets/image/add-to-cart.png",
                              height: 30,
                              width: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {},
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
