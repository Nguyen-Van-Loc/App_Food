import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class informationProducst extends StatefulWidget {
  final Map<String,dynamic> data;
  const informationProducst({super.key,required this.data});
  @override
  State<informationProducst> createState() => _informationProducst();
}
class _informationProducst extends State<informationProducst> {
  String? transport;
  @override
  Widget build(BuildContext context) {
    String formattedTotalPayment = NumberFormat.decimalPattern("vi").format(widget.data["transport"]);
    transport = formattedTotalPayment.toString().replaceAll(",", ".");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:  Column(
          mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 15,bottom: 20),
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
                          "Thông tin đơn hàng",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "LibreBodoni-BoldItalic"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(widget.data['orderStatus']=="Chờ xác nhận")
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            color: const Color(0xff26AB9A),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  height: 100,
                                  margin: const EdgeInsets.only(left: 10),
                                  child: RichText(
                                      text: const TextSpan(
                                          text: "Chờ xác nhận!",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "LibreBaskerville-Regular",
                                              fontSize: 18),
                                          children: [
                                        TextSpan(
                                            text:
                                                "\n\nĐơn hàng đang được cửa hàng xác nhận .",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    "LibreBaskerville-Regular",
                                                fontSize: 15)),
                                      ])),
                                ),
                                Image.asset(
                                  "assets/image/to-do-list.png",
                                  width: 100,
                                  height: 100,
                                )
                              ],
                            ),
                          ),
                          if(widget.data['orderStatus']=="Đang vận chuyển")
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              color: const Color(0xff26AB9A),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    height: 100,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: RichText(
                                        text: const TextSpan(
                                            text: "Đã xác nhận đơn hàng !",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "LibreBaskerville-Regular",
                                                fontSize: 18),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  "\n\nĐơn hàng đang được đưa tới đơn vị vận chuyển !.",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                      "LibreBaskerville-Regular",
                                                      fontSize: 15)),
                                            ])),
                                  ),
                                  Image.asset(
                                    "assets/image/delivery-service.png",
                                    width: 100,
                                    height: 100,
                                  )
                                ],
                              ),
                            ),
                          if(widget.data['orderStatus']=="Đang giao hàng")
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              color: const Color(0xff26AB9A),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    height: 100,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: RichText(
                                        text: const TextSpan(
                                            text: "Đang giao hàng!",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "LibreBaskerville-Regular",
                                                fontSize: 18),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  "\n\nĐơn hàng đang được đưa tới khách hàng !",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                      "LibreBaskerville-Regular",
                                                      fontSize: 15)),
                                            ])),
                                  ),
                                  Image.asset(
                                    "assets/image/transport.png",
                                    width: 100,
                                    height: 100,
                                  )
                                ],
                              ),
                            ),
                          if(widget.data['orderStatus']=="Đã nhận")
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              color: const Color(0xff26AB9A),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    height: 100,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: RichText(
                                        text: const TextSpan(
                                            text: "Đã nhận hàng!",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "LibreBaskerville-Regular",
                                                fontSize: 18),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  "\n\nĐơn hàng đã giao thành công !",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                      "LibreBaskerville-Regular",
                                                      fontSize: 15)),
                                            ])),
                                  ),
                                  Image.asset(
                                    "assets/image/booking.png",
                                    width: 100,
                                    height: 100,
                                  )
                                ],
                              ),
                            ),
                          if(widget.data['orderStatus']=="Đã hủy")
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              color: const Color(0xff26AB9A),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    height: 100,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: RichText(
                                        text: const TextSpan(
                                            text: "Đã hủy đơn hàng!",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "LibreBaskerville-Regular",
                                                fontSize: 18),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  "\n\nĐơn hàng đã hủy thành công !",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                      "LibreBaskerville-Regular",
                                                      fontSize: 15)),
                                            ])),
                                  ),
                                  Image.asset(
                                    "assets/image/cancel.png",
                                    width: 100,
                                    height: 100,
                                  )
                                ],
                              ),
                            ),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/image/location.png",
                                  width: 25,
                                  height: 25,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "Địa chỉ nhận hàng",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'LibreBaskerville-Regular'),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                                elevation: 3,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.data["address"]["username"],
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: "LibreBodoni-Bold",
                                          )),
                                      Text(
                                        widget.data["address"]["phone"],
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: "LibreBodoni-Bold",
                                            color: Color(0xff818181)),
                                      ),
                                      Text(widget.data["address"]["note"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: "LibreBodoni-Bold",
                                              color: Color(0xff818181))),
                                      Text(
                                        widget.data["address"]["address"],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "LibreBodoni-Bold",
                                            color: Color(0xff818181)),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          Container(
                            height: 10,
                            color: const Color(0xffececec),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/image/shopping-bag.png",
                                        width: 25,
                                        height: 25,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "Thông tin đơn hàng",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'LibreBaskerville-Regular'),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          widget.data["imageUrl"],
                                          height: 100,
                                          width: 100,
                                        ),
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            width: MediaQuery.of(context).size.width -
                                                130,
                                            child:  Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  widget.data["productName"],
                                                  style: const TextStyle(fontSize: 20),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text("x"+widget.data["quantity"],
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontFamily:
                                                            "LibreBaskerville-Regular"),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(widget.data["price"]+"₫",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Color(0xffD6563B),
                                                        fontFamily:
                                                            "LibreBaskerville-Regular"),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.grey.withOpacity(.3),
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Tổng tiền hàng ",
                                            style: TextStyle(
                                                fontFamily:
                                                    "LibreBaskerville-Regular",
                                                fontSize: 15,
                                                color: Color(0xff757575)),
                                          ),
                                          Text(
                                            widget.data["price"]+"₫",
                                            style: const TextStyle(
                                                fontFamily:
                                                    "LibreBaskerville-Regular",
                                                fontSize: 15,
                                                color: Color(0xff757575)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                       Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Phí vận chuyển",
                                            style: TextStyle(
                                                fontFamily:
                                                    "LibreBaskerville-Regular",
                                                fontSize: 15,
                                                color: Color(0xff757575)),
                                          ),
                                          Text("$transport₫",
                                              style: const TextStyle(
                                                  fontFamily:
                                                      "LibreBaskerville-Regular",
                                                  fontSize: 15,
                                                  color: Color(0xff757575)))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Giảm giá phí vận chuyển",
                                            style: TextStyle(
                                                fontFamily:
                                                    "LibreBaskerville-Regular",
                                                fontSize: 15,
                                                color: Color(0xff757575)),
                                          ),
                                          Text("${"- "+widget.data["transportFee"]}₫",
                                              style: const TextStyle(
                                                  fontFamily:
                                                      "LibreBaskerville-Regular",
                                                  fontSize: 15,
                                                  color: Color(0xff757575)))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                         Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Thành tiền: ",
                                            style: TextStyle(
                                                fontFamily:
                                                    "LibreBaskerville-Regular",
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.data["totalPrice"]+"₫",
                                              style: const TextStyle(
                                                  fontFamily:
                                                      "LibreBaskerville-Regular",
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      RichText(
                                          text: TextSpan(children: [
                                        const TextSpan(
                                            text: "Vui lòng thanh toán ",
                                            style: TextStyle(
                                                color: Color(0xff757575))),
                                        TextSpan(
                                            text: widget.data["totalPrice"]+"₫",
                                            style: const TextStyle(color: Colors.red)),
                                        const TextSpan(
                                            text: " khi nhận hàng ",
                                            style: TextStyle(
                                                color: Color(0xff757575))),
                                      ]))
                                    ],
                                  ),
                                ],
                              )),
                          Container(
                            height: 10,
                            color: const Color(0xffececec),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phương thức thanh toán",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "LibreBaskerville-Regular"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Thanh toán khi nhận hàng",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "LibreBaskerville-Regular",
                                      color: Color(0xff757575)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 10,
                            color: const Color(0xffececec),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Mã đơn hàng ",
                                      style: TextStyle(
                                          fontFamily:
                                          "LibreBaskerville-Regular",
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(widget.data["productKey"],
                                        style: const TextStyle(
                                            fontFamily:
                                            "LibreBaskerville-Regular",
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Thời gian đặt hàng ",
                                      style: TextStyle(
                                          fontFamily:
                                          "LibreBaskerville-Regular",
                                          fontSize: 13,
                                          color: Color(0xff757575)),
                                    ),
                                    Text(
                                      widget.data["createAt"],
                                      style: const TextStyle(
                                          fontFamily:
                                          "LibreBaskerville-Regular",
                                          fontSize: 13,
                                          color: Color(0xff757575)),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ]),
                ),
              ),
              if(widget.data['orderStatus']!="Đã nhận")
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF6900)
                  ),
                  onPressed: null,
                  child: const Text("Đã nhận",style: TextStyle(fontSize: 18,fontFamily: "LibreBodoni-Medium"),),
                ),
              )
            ],
          ),
        ),
    );
  }
}
