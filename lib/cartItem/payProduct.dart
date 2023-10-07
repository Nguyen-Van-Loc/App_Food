import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab5/main.dart';

List<String> list = ["Thanh toán khi nhận hàng", " Thanh toán qua ví "];

class viewpayProduct extends State<payProduct> {
  String text = list.last;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
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
                        "Thanh toán",
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
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) => Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                width: 100,
                                height: 100,
                                color: Colors.grey,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Điện thoại Redmi Note 13 Pro",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily:
                                              "LibreBaskerville-Regular"),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "6,150,000₫",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "LibreBodoni-Medium"),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, right: 10),
                                      alignment: Alignment.bottomRight,
                                      child: Text("x1",
                                          style: TextStyle(
                                              fontFamily: "LibreBodoni-Medium",
                                              color: Color(0xff6D6D6D))),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: const Color(0xffe7e6e6),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Địa chỉ nhận hàng",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium", fontSize: 18),
                          ),
                          InkWell(
                              onTap: () {Navigator.push(context, CupertinoPageRoute(builder: (context)=>addressPay()));},
                              child: Image.asset(
                                "assets/image/next.png",
                                height: 25,
                                width: 35,
                                cacheHeight: 15,
                              ))
                        ],
                      ),
                      Card(
                          child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Minh",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "LibreBodoni-Medium"),
                                ),
                                Container(
                                  width: 1,
                                  height: 10,
                                  color: const Color(0xffD3D3D3),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                ),
                                Text(
                                  "09123456789",
                                  style: const TextStyle(
                                      fontFamily: "LibreBodoni-Medium",
                                      color: Color(0xffAEAEAE)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Ghi chú: ",
                                  style: TextStyle(
                                      fontFamily: "LibreBodoni-Medium",
                                      color: Color(0xffAEAEAE)),
                                ),
                                Text(
                                  "cách hàng nhà xóm 100m",
                                  style: const TextStyle(
                                      fontFamily: "LibreBodoni-Medium",
                                      color: Color(0xffAEAEAE)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Địa chỉ: ",
                                  style: TextStyle(
                                      fontFamily: "LibreBodoni-Medium",
                                      color: Color(0xffAEAEAE)),
                                ),
                                Text(
                                  "An Khánh ,Hoài Đức ,Hà Nội",
                                  style: const TextStyle(
                                      fontFamily: "LibreBodoni-Medium",
                                      color: Color(0xffAEAEAE)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: const Color(0xffe7e6e6),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10, bottom: 10),
                    child: Text("Phương thức thanh toán",
                        style: TextStyle(
                            fontFamily: "LibreBodoni-Medium", fontSize: 18))),
                DropdownMenu(
                    width: MediaQuery.of(context).size.width - 20,
                    initialSelection: list.last,
                    onSelected: (value) {
                      setState(() {
                        text = value!;
                      });
                    },
                    dropdownMenuEntries: list
                        .map<DropdownMenuEntry>((value) =>
                            DropdownMenuEntry(value: value, label: value))
                        .toList()),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: const Color(0xffe7e6e6),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10, bottom: 10),
                    child: Text("Chi tiết thanh toán",
                        style: TextStyle(
                            fontFamily: "LibreBodoni-Medium", fontSize: 17))),
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 5, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Số tiền sản phẩm",
                        style: TextStyle(
                            fontFamily: "LibreBodoni-Medium",
                            color: Color(0xff767676)),
                      ),
                      Text(
                        "6,150,000₫",
                        style: TextStyle(
                            fontFamily: "LibreBodoni-Medium", fontSize: 16),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 5, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phí vận chuyển",
                        style: TextStyle(
                            fontFamily: "LibreBodoni-Medium",
                            color: Color(0xff767676)),
                      ),
                      Text(
                        "15,000₫",
                        style: TextStyle(
                            fontFamily: "LibreBodoni-Medium", fontSize: 16),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 5, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Giảm giá",
                        style: TextStyle(
                            fontFamily: "LibreBodoni-Medium",
                            color: Color(0xff767676)),
                      ),
                      Text(
                        "20,000₫",
                        style: TextStyle(
                            fontFamily: "LibreBodoni-Medium", fontSize: 16),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 65, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng tiền thanh toán",
                        style: TextStyle(
                            fontFamily: "LibreBodoni-Medium",
                            color: Color(0xff767676)),
                      ),
                      Text(
                        "18,140,000₫",
                        style: TextStyle(
                            fontFamily: "LibreBodoni-Medium",
                            fontSize: 18,
                            color: Colors.red),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFF6900),
                      shape: RoundedRectangleBorder(side: BorderSide.none)),
                  child: Text("Thanh toán"),
                )),
          )
        ]),
      ),
    );
  }
}
