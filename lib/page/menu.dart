import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab5/cartItem/productPortfolio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../changeNotifier/Categories.dart';

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  viewMenu createState() => viewMenu();
}
class viewMenu extends State<menu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<categoryProducts>(context,listen: false).getCategoriesProducts();
    isLoading();
  }
  bool checkLoading=true;
  void isLoading() async{
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      checkLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final itemProduct = Provider.of<categoryProducts>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 10, top: 15),
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
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 5,
                  color: const Color(0xffe7e6e6),
                ),
            const SizedBox(height: 30,),
            Stack(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: Color(0xffee683f),
                    ),
                    width: 120,
                    height: itemProduct.result.length*130),
                checkLoading || itemProduct.isLoading ? SizedBox(
                  height: MediaQuery.of(context).size.height-96,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: LoadingAnimationWidget.waveDots(color: Colors.red, size: 40),
                  ),
                ):
                    itemProduct.result.isNotEmpty ?
                Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final getIndex = itemProduct.result[index];
                        final itemData = getIndex["categoryData"];
                        return Card(
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => productPortfolio(data: getIndex["productsData"],Name:itemData["name"],keyID:getIndex["categoryKey"], ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.all(10),
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
                                          margin: const EdgeInsets.only(top: 20),
                                          child: Text(
                                          itemData["name"],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontFamily: "LibreBodoni-Medium",
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${itemProduct.result[index]["productsData"].length}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: "LibreBodoni-Medium",
                                              ),
                                            ),
                                            const Text(
                                              " Sản phẩm",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "LibreBodoni-Medium",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  "assets/image/arrowhead.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: itemProduct.result.length,
                    )):SizedBox(
                      height: MediaQuery.of(context).size.height-96,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: LoadingAnimationWidget.waveDots(color: Colors.red, size: 40),
                      ),)
              ],
            )
          ]),
        ),
      ),
    );
  }
}
