import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab5/changeNotifier/ProfileUser.dart';
import 'package:lab5/custom/radioCustom.dart';
import 'package:lab5/user/address.dart';
import 'package:provider/provider.dart';
class addressPay extends StatefulWidget {
  viewaddressPay createState() => viewaddressPay();
}
class viewaddressPay extends State<addressPay> {
  int? val ;
  final _firestore = FirebaseFirestore.instance;
  List<MapEntry<String, dynamic>> listAddress = [];
  void showDialogAddress({Item? itemEdit}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialogshow(
            onAdd:(Item item){
              if(itemEdit ==null){
                addAddress(item);
              }else(
                  updateAddress(item,itemEdit.key)
              );
            },
            itemToEdit: itemEdit,
            isEditing: itemEdit !=null,
          );

        });
  }
  void updateAddress(Item item,String id) async {
    final item1 = Provider.of<getProflieUser>(context,listen: false);
    final snapshot = await _firestore.collection("User").doc(item1.data[0]["key"]).get();
    final addressData = snapshot.data()?["address"] ?? {};
    bool isDefault = false;
    if (addressData.containsKey(id)) {
      isDefault = addressData[id]["isDefault"];
    }
    final Map<String, dynamic> updatedAddress = {
      "username": item.name,
      "phone": item.phone,
      "note": item.note,
      "address": item.address,
      "isDefault": isDefault,
    };
    final Map<String, dynamic> updateData = {
      "address.$id": updatedAddress,
    };
    await _firestore.collection("User").doc(item1.data[0]["key"]).update(updateData);
    await _fetchAddresses();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAddresses();
    val=0;
  }
  void addAddress(Item item) async {
    final item1 = Provider.of<getProflieUser>(context,listen: false);
    final snapshot = await _firestore.collection("User").doc(item1.data[0]["key"]).get();
    final address = snapshot.data()?["address"] ?? {};
    int keyid = address.isEmpty ? 0 : address.length+1;
    Map<String, dynamic> newAddress = {
      "username": item.name,
      "phone": item.phone,
      "note": item.note,
      "address": item.address,
      "isDefault": keyid ==0 ?true:false,
    };
    Map<String, dynamic> addAddress = {
      "address.$keyid": newAddress,
    };
    await _firestore.collection("User").doc(item1.data[0]["key"]).update(addAddress);
    await _fetchAddresses();
  }
  Future<void> _fetchAddresses() async {
    final item1 = Provider.of<getProflieUser>(context,listen: false);
    final snapshot = await _firestore.collection("User").doc(item1.data[0]["key"]).get();
    final data = snapshot.data();
    if (data != null && data["address"] != null) {
      final addressMap = data["address"] as Map<String, dynamic>;
      final entries1 = addressMap.entries.toList();
      setState(() {
        listAddress = entries1;
      });
    }
    print(listAddress);
  }
  void updateDefaultAddressInFirestore(int addressIndex) {
    final item = Provider.of<getProflieUser>(context,listen: false);
    item.fetchData();
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection('User');
    collection.doc(item.data[0]["key"]).get().then((userDoc) {
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final addresses = userData['address']as Map<String, dynamic>;
        addresses.forEach((key, address) {
          if (key == addressIndex.toString()) {
            address['isDefault'] = true;
          } else {
            address['isDefault'] = false;
          }
        });
          userDoc.reference.update({'address': addresses});
        }
      });
  }
  @override
  Widget build(BuildContext context) {
    final itemUser =Provider.of<getProflieUser>(context);
    itemUser.fetchData();
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
                    ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: itemUser.addresses.length,
                          itemBuilder: (context, index) {
                            final getLength =itemUser.addresses[index];
                            final getItem = getLength.value;
                            final getKey = getLength.key;
                            return Stack(
                              children: [
                                CusTomRadio(
                                  onChanged: (value) async {
                                    setState(() {
                                      val = value;
                                    });
                                    updateDefaultAddressInFirestore(int.parse(getLength.key));
                                    Navigator.pop(context);
                                  },
                                  value: index, groupValue:val, text: Card(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width-30,
                                      padding:
                                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                getItem["username"],
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
                                                getItem["phone"],
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
                                                getItem['note'],
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
                                                getItem["address"],
                                                style: const TextStyle(
                                                    fontFamily: "LibreBodoni-Medium",
                                                    color: Color(0xffAEAEAE)),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                                ) ,
                                Positioned(right: 20,top:20, child: InkWell( onTap: (){showDialogAddress(itemEdit: Item(getItem["username"], getItem["phone"] , getItem["note"] , getItem["address"],getKey));},
                                    child: Text("Sửa",style: TextStyle(color: Colors.red,fontFamily: "LibreBodoni-Medium",fontSize: 16),))),
                              ],
                            );
                          },),
                    TextButton.icon(onPressed: (){
                      showDialogAddress();
                    }, icon: Icon(CupertinoIcons.add_circled,color: Colors.red,),
                    label: Text("Thêm địa chỉ",style: TextStyle(color: Colors.red,fontFamily: "LibreBodoni-Medium",fontSize: 18),))
                  ],
                ),
              ),
            ),
    );
  }
}
