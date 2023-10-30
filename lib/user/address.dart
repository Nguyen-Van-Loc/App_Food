import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lab5/User/user.dart';
import 'package:lab5/Validate/validateProfile.dart';
class Item {
  String name, phone, note, address,key;
  Item( this.name,  this.phone,  this.note,  this.address,this.key);
}
class myaddress extends StatefulWidget {
  viewAddress createState() => viewAddress();
  final Map<String, dynamic> data;
  final String keyId;
  myaddress({required this.data, required this.keyId});
}
class viewAddress extends State<myaddress> {
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
      final Map<String, dynamic> updatedAddress = {
        "username": item.name,
        "phone": item.phone,
        "note": item.note,
        "address": item.address,
      };
      final Map<String, dynamic> updateData = {
        "address.$id": updatedAddress,
      };
      await _firestore.collection("User").doc(widget.keyId).update(updateData);
      await _fetchAddresses();
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAddresses();
  }
  void _diadelete(BuildContext context,String index) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text(
                "Thông báo",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.left,
              ),
              content: const Text(
                "Bạn có chắc chắn muốn xóa không ?",
                style: TextStyle(fontSize: 17),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Hủy"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 30),
                          backgroundColor: const Color(0xffff6900),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        setState(() {
                          delete(index);
                          EasyLoading.showSuccess("Thành công");
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Xác nhận"),
                    )
                  ],
                ),
              ]);
        });
  }
  void addAddress(Item item) async {
    final snapshot = await _firestore.collection("User").doc(widget.keyId).get();
    final address = snapshot.data()?["address"] ?? {};
    int keyid = address.isEmpty ? 0 : address.length+1;
    Map<String, dynamic> newAddress = {
      "username": item.name,
      "phone": item.phone,
      "note": item.note,
      "address": item.address,
      "isDefault": keyid == 0 ?true:false,
    };
    Map<String, dynamic> addAddress = {
      "address.$keyid": newAddress,
    };
    await _firestore.collection("User").doc(widget.keyId).update(addAddress);
    await _fetchAddresses();
  }
  Future<void> _fetchAddresses() async {
    final snapshot = await _firestore.collection("User").doc(widget.keyId).get();
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
  void delete(String index) async{
    await _firestore.collection("User").doc(widget.keyId).update({
      "address.$index": FieldValue.delete(),
    });
    await _fetchAddresses();
  }
  @override
  Widget build(BuildContext context) {
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
                      "Địa Chỉ",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "LibreBodoni-BoldItalic"),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Địa chỉ",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "LibreBodoni-Medium",
                          color: Color(0xff686868)),
                    ),
                    InkWell(
                      onTap: () {
                        showDialogAddress();
                      },
                      child: Image.asset(
                        "assets/image/more.png",
                        height: 25,
                        width: 25,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: 5,
                color: const Color(0xffe7e6e6),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final address = listAddress[index];
                  final key =address.key;
                  final value =address.value;
                  return Stack(children: [
                    InkWell(
                        onTap: () => {showDialogAddress(itemEdit: Item(value["username"], value["phone"] , value["note"] , value["address"],key
                      ))},
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(value["username"]??"",
                                    style: TextStyle(
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
                                    value["phone"]??"",
                                    style: const TextStyle(
                                        fontFamily: "LibreBodoni-Medium",
                                        color: Color(0xffAEAEAE)),
                                  )
                                ],
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
                                    value["note"]??"",
                                    style: const TextStyle(
                                        fontFamily: "LibreBodoni-Medium",
                                        color: Color(0xffAEAEAE)),
                                  )
                                ],
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
                                    value["address"]??"",
                                    style: const TextStyle(
                                        fontFamily: "LibreBodoni-Medium",
                                        color: Color(0xffAEAEAE)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        right: 10,
                        child: InkWell(
                          onTap: () {_diadelete(context,key);},
                          child: Image.asset(
                            "assets/image/close.png",
                            height: 30,
                            width: 30,
                          ),
                        )),
                  ]);
                },
                itemCount:listAddress.length ,
              )
            ],
          ),
        ),
      ),
    );
  }
}
class Dialogshow extends StatefulWidget {
  final Function(Item) onAdd;
  final Item? itemToEdit;
  final bool isEditing;
  Dialogshow(
      {super.key,
      required this.onAdd,required this.itemToEdit,required this.isEditing});
  @override
  ShowDialogAdd createState() => ShowDialogAdd();
}
class ShowDialogAdd extends State<Dialogshow> {
  final TextEditingController _nameControler = TextEditingController();
  final TextEditingController _phoneControler = TextEditingController();
  final TextEditingController _noteControler = TextEditingController();
  final TextEditingController _addresControler = TextEditingController();
  String errname = "", errphone = "", erraddres = "";
  int check=-1;
  void onAdd() async{
    setState(() {
      errname = validateName(_nameControler.text);
    });
    if (errname.isEmpty) {
      setState(() {
        errphone = validatePhone(_phoneControler.text);
      });
      if (errphone.isEmpty) {
        setState(() {
          erraddres = validateAddres(_addresControler.text);
        });
        if (erraddres.isEmpty) {
          Item user= Item(_nameControler.text, _phoneControler.text, _noteControler.text, _addresControler.text, widget.isEditing ? widget.itemToEdit!.key :check.toString());
          EasyLoading.show(status: "loading...");
          await Future.delayed(Duration(seconds: 2));
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Thành công");
          widget.onAdd(user);
          Navigator.pop(context);
        }
      }
    }
  }
  @override
  void initState() {
    super.initState();
    if (widget.itemToEdit != null) {
      _nameControler.text = widget.itemToEdit!.name;
      _phoneControler.text = widget.itemToEdit!.phone;
      _noteControler.text = widget.itemToEdit!.note;
      _addresControler.text = widget.itemToEdit!.address;
    }
  }
  @override
  Widget build(BuildContext context) {
    final isEditing = widget.itemToEdit != null;
    final buttonText = isEditing ? 'Cập Nhật' : 'Thêm';
    final text = isEditing ? 'Cập nhật địa chỉ' : 'Thêm địa chỉ';
    return AlertDialog(
      title: Center(
          child: Text(text,
              style: const TextStyle(fontFamily: "LibreBodoni-Medium"))),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text("Tên người dùng",
                    style: TextStyle(fontFamily: "LibreBodoni-Medium"))),
            TextField(
              controller: _nameControler,
              decoration: InputDecoration(
                  errorText: errname.isNotEmpty ? errname : null,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  hintText: "Tên người dùng",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text("Số điện thoại",
                    style: TextStyle(fontFamily: "LibreBodoni-Medium"))),
            TextField(
              keyboardType: TextInputType.number,
              controller: _phoneControler,
              decoration: InputDecoration(
                  errorText: errphone.isNotEmpty ? errphone : null,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  hintText: "Số điện thoại",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text("Ghi chú",
                    style: TextStyle(fontFamily: "LibreBodoni-Medium"))),
            TextField(
              controller: _noteControler,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  hintText: "Ghi chú",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "Địa chỉ",
                style: TextStyle(fontFamily: "LibreBodoni-Medium"),
              ),
            ),
            TextField(
              controller: _addresControler,
              decoration: InputDecoration(
                  errorText: erraddres.isNotEmpty ? erraddres : null,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  hintText: "Địa chỉ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                onAdd();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffff6900),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30)),
              child: Text(
                buttonText,
                style: const TextStyle(
                    fontSize: 18, fontFamily: "LibreBodoni-Italic"),
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _nameControler.dispose();
    _addresControler.dispose();
    _phoneControler.dispose();
    _noteControler.dispose();
    super.dispose();
  }
}
