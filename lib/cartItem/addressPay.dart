import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab5/custom/radioCustom.dart';
import 'package:lab5/main.dart';

class viewaddressPay extends State<addressPay> {
  int? val =1 ;
  @override
  Widget build(BuildContext context) {
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
                    "Địa chỉ nhận hàng",
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
            CusTomRadio(
              onChanged: (value){
                setState(() {
                  val=value;
                });
              },
              value: 1, groupValue:val, text: Card(
                child: Container(
                  width: MediaQuery.of(context).size.width-30,
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
                )),
            ),
            CusTomRadio(
              onChanged: (value){
                setState(() {
                  val=value;
                });
              },
              value: 2, groupValue:val, text: Card(
                child: Container(
                  width: MediaQuery.of(context).size.width-30,
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
                )),
            )
          ],
        ),
      ),
    );
  }
}
