import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab5/cartItem/productDetails.dart';
import 'package:lab5/changeNotifier/Categories.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class searchProducts extends StatefulWidget {
  final String searchKeyword;

  const searchProducts({super.key, required this.searchKeyword});
  @override
  viewSerchProducts createState() => viewSerchProducts();
}

class viewSerchProducts extends State<searchProducts> with AutomaticKeepAliveClientMixin<searchProducts> {
  final containerSearch = TextEditingController();
  bool show = false;
  String? price;
  List<Map<String, dynamic>> allProducts = [];
  List<String> keys = [];
  bool isSorting = false;

  Future<void> getProducts() async {
    final itemCa = Provider.of<categoryProducts>(context,listen: false);
    await itemCa.searchProducts(containerSearch.text);
    allProducts.clear();
    setState(() {
      check(itemCa);
    });
  }
  @override
  void initState() {
    super.initState();
    containerSearch.text = widget.searchKeyword;
    getProducts();
  }

  @override
  void dispose() {
    super.dispose();
    containerSearch.clear();
  }

  void sortProductsAZ() async{
    setState(() { isSorting = true; });
    allProducts.clear();
    final itemCa = Provider.of<categoryProducts>(context, listen: false);
    await itemCa.searchProducts(containerSearch.text);
    setState(() {
      check(itemCa);
      allProducts.sort((a, b) {
        final productNameA = a["data"]["data"]["ProductName"];
        final productNameB = b["data"]["data"]["ProductName"];
        return productNameA.compareTo(productNameB);
      });
      isSorting = false;
    });
  }

  void sortProductsZA() async{
    setState(() { isSorting = true; });
    allProducts.clear();
    final itemCa = Provider.of<categoryProducts>(context, listen: false);
    await itemCa.searchProducts(containerSearch.text);
    setState(() {
      check(itemCa);
      allProducts.sort((a, b) {
        final productNameA = a["data"]["data"]["ProductName"];
        final productNameB = b["data"]["data"]["ProductName"];
        return productNameB.compareTo(productNameA);
      });
      isSorting = false;
    });
  }

  void sortProductsPriceAZ() async{
    setState(() { isSorting = true; });
    allProducts.clear();
    final itemCa = Provider.of<categoryProducts>(context, listen: false);
    await itemCa.searchProducts(containerSearch.text);
    setState(() {
      check(itemCa);
      allProducts.sort((a, b) {
        final productNameA = a["data"]["data"]["Price  "];
        final productNameB = b["data"]["data"]["Price  "];
        return productNameA.compareTo(productNameB);
      });
      isSorting = false;
    });
  }

  void sortProductsPriceZA() async{
    setState(() { isSorting = true; });
    allProducts.clear();
    final itemCa = Provider.of<categoryProducts>(context, listen: false);
    await itemCa.searchProducts(containerSearch.text);
    setState(() {
      check(itemCa);
      allProducts.sort((a, b) {
        final productNameA = a["data"]["data"]["Price  "];
        final productNameB = b["data"]["data"]["Price  "];
        return productNameB.compareTo(productNameA);
      });
      isSorting = false;
    });
  }
  void sortStar() async{
    setState(() { isSorting = true; });
    allProducts.clear();
    final itemCa = Provider.of<categoryProducts>(context, listen: false);
    await itemCa.searchProducts(containerSearch.text);
    setState(() {
      check(itemCa);
      allProducts.sort((a, b) {
        final productNameA = a["data"]["data"]["sumStart"];
        final productNameB = b["data"]["data"]["sumStart"];
        return productNameB.compareTo(productNameA);
      });
      isSorting = false;
    });
  }
  void check(final itemCa){
    for (final item in itemCa.data) {
      if (item["productsData"] != null) {
        List<Map<String, dynamic>> productsList = item["productsData"];
        for (var product in productsList) {
          allProducts.add({
            "categoryKey": item["categoryKey"],
            "data": product,
          });
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final itemCa = Provider.of<categoryProducts>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        allProducts.clear();
                      });
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                      onSubmitted: (value)async{
                        if (value.isNotEmpty) {
                          allProducts.clear();
                          itemCa.searchProducts(value);
                          getProducts();
                        }
                      },
                      controller: containerSearch,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        hintText: "Search...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              containerSearch.clear();
                            });
                          },
                          child: const Icon(Icons.clear),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed:itemCa.data.isNotEmpty? () {
                        setState(() {
                          show = !show;
                        });
                      }:null,
                      icon: Image.asset("assets/image/edit.png")),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              show
                  ? Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  sortProductsAZ();
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xffd9d9d9),
                                    foregroundColor: const Color(0xff3a3030),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Text(
                                  "Theo tên từ A-Z",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  sortProductsZA();
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xffd9d9d9),
                                    foregroundColor: const Color(0xff3a3030),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Text("Theo tên từ Z-A",
                                    style: TextStyle(fontSize: 13)),
                              ),
                              TextButton(
                                onPressed: () {sortStar();},
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xffd9d9d9),
                                    foregroundColor: const Color(0xff3a3030),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Text("Theo đánh giá",
                                    style: TextStyle(fontSize: 13)),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  sortProductsPriceAZ();
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xffd9d9d9),
                                    foregroundColor: const Color(0xff3a3030),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Text("Theo giá từ thấp đến cao",
                                    style: TextStyle(fontSize: 13)),
                              ),
                              TextButton(
                                onPressed: () {
                                  sortProductsPriceZA();
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xffd9d9d9),
                                    foregroundColor: const Color(0xff3a3030),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Text("Theo giá từ cao đến thấp",
                                    style: TextStyle(fontSize: 13)),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey.withOpacity(.2),
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              itemCa.isLoading || isSorting
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 96,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: LoadingAnimationWidget.waveDots(
                            color: Colors.red, size: 40),
                      ),
                    )
                  : itemCa.data.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: allProducts.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 370,
                              ),
                              itemBuilder: (context, productIndex) {
                                final itemKeyCa = allProducts[productIndex]["categoryKey"];
                                final item = allProducts[productIndex]["data"];
                                final itemData = item["data"];
                                final itemKey = item["key"];
                                String fomatPrice =
                                    NumberFormat.decimalPattern("vi")
                                        .format(itemData["Price  "]);
                                price =
                                    fomatPrice.toString().replaceAll(",", ".");
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => productDetails(
                                            data: itemData,
                                            keyId: itemKey,
                                            keyIdCa: itemKeyCa,
                                            start: itemData['sumStart']),
                                      ),
                                    );
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
                                              height: 200),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child:
                                              itemData["Listimages "] != null &&
                                                      itemData["Listimages "]
                                                          .isNotEmpty
                                                  ? Image.network(
                                                      itemData["Listimages "],
                                                      height: 30)
                                                  : null,
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            itemData["ProductName"],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily:
                                                    "LibreBaskerville-Regular"),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    price!,
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          "LibreBodoni-Medium",
                                                      fontSize: 17,
                                                      color: Color(0xffd0021c),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: const Text("₫",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffd0021c),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                color: const Color(0xfffff0e9),
                                                child: itemData["discount"] !=
                                                            null &&
                                                        itemData["discount"]
                                                            .isNotEmpty
                                                    ? Text(
                                                        "${"-" + itemData["discount"]}%",
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xffeb5757)),
                                                      )
                                                    : null,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${itemData["sumStart"]}",
                                                style: TextStyle(
                                                    color: Color(0xfffb6e2e)),
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color(0xfffb6e2e),
                                                size: 18,
                                              ),
                                              SizedBox(width: 10),
                                              Text("("
                                                  "${itemData["sumComment"]}"
                                                  ")")
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text:
                                          "Rất tiếc, Chúng tôi không tìm thấy kết quả nào phù hợp với từ khóa ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    TextSpan(
                                      text: "\"${widget.searchKeyword}\"",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: const TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          "Để tìm được kết quả chính xác hơn, bạn vui lòng:",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    TextSpan(
                                      text:
                                          "\n -Kiểm tra lỗi chính tả của từ khóa đã nhập.\n -Thử lại bằng từ khóa khác.\n -Thử lại bằng những từ khóa tổng quát hơn.\n -Thử lại bằng những từ khóa ngắn gọn hơn.",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
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
