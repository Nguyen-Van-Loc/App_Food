import 'package:flutter/material.dart';
import 'package:lab5/User/user.dart';
import 'package:lab5/Validate/validateProfile.dart';

class Item {
  String name, phone, note, address;
  int id;

  Item(this.name, this.phone, this.note, this.address, this.id);
}

int id = 1;
List<Item> list = [];

class viewAddress extends State<myaddress> {
  void showDialogAddress({Item? itemEdit}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialogshow(
            onAdd: (Item item) {
              setState(() {
                if (itemEdit == null) {
                  item.id = id++;
                  list.add(item);
                } else {
                  final index =
                      list.indexWhere((element) => element.id == itemEdit.id);
                  if (index != -1) {
                    list[index] = item;
                  }
                }
              });
            },
            checkEdit: itemEdit != null,
            editItem: itemEdit,
          );
        });
  }
  void _diadelete(BuildContext context, int id) async {
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
                style: TextStyle(fontSize: 18),
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
                          list.removeWhere((element) => element.id==id);
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
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      onTap: () => showDialogAddress(),
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
                itemBuilder: (context, index) => Stack(children: [
                  InkWell(
                    onTap:()=>showDialogAddress(itemEdit: list[index]),
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding:
                            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  list[index].name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "LibreBodoni-Medium"),
                                ),
                                Container(
                                  width: 1,
                                  height: 10,
                                  color: const Color(0xffD3D3D3),
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                ),
                                Text(
                                  list[index].phone,
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
                                  list[index].note,
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
                                  list[index].address,
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
                        onTap: ()=>_diadelete(context,list[index].id),
                        child: Image.asset(
                          "assets/image/close.png",
                          height: 30,
                          width: 30,
                        ),
                      )),
                ]),
                itemCount: list.length,
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
  final Item? editItem;
  final bool checkEdit;

  const Dialogshow(
      {super.key,
      required this.onAdd,
      required this.editItem,
      required this.checkEdit});

  @override
  ShowDialogAddandUpdate createState() => ShowDialogAddandUpdate();
}
class ShowDialogAddandUpdate extends State<Dialogshow> {
  final TextEditingController _nameControler = TextEditingController();
  final TextEditingController _phoneControler = TextEditingController();
  final TextEditingController _noteControler = TextEditingController();
  final TextEditingController _addresControler = TextEditingController();
  String errname = "", errphone = "", erraddres = "";
  void onAdd() {
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
          Item item = Item(
              _nameControler.text,
              _phoneControler.text,
              _noteControler.text,
              _addresControler.text,
              widget.checkEdit ? widget.editItem!.id : -1);
          widget.onAdd(item);
          Navigator.pop(context);
        }
      }
    }
  }
  @override
  void initState() {
    super.initState();
    if (widget.editItem != null) {
      _nameControler.text = widget.editItem!.name;
      _phoneControler.text = widget.editItem!.phone;
      _noteControler.text = widget.editItem!.note;
      _addresControler.text = widget.editItem!.address;
    }
  }
  @override
  Widget build(BuildContext context) {
    final text = widget.checkEdit ? "Cập nhật" : "Thêm";
    return AlertDialog(
      title: Center(
          child: Text(widget.checkEdit ? "Cập nhật Địa Chỉ" : "Thêm Địa Chỉ",
              style: const TextStyle(fontFamily: "LibreBodoni-Medium"))),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
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
                    suffixIcon: InkWell(
                      child: const Icon(Icons.clear),
                      onTap: () {
                        _nameControler.clear();
                      },
                    ),
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
                    suffixIcon: InkWell(
                      child: const Icon(Icons.clear),
                      onTap: () {
                        _phoneControler.clear();
                      },
                    ),
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
                    suffixIcon: InkWell(
                      child: const Icon(Icons.clear),
                      onTap: () {
                        _noteControler.clear();
                      },
                    ),
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
                    suffixIcon: InkWell(
                      child: const Icon(Icons.clear),
                      onTap: () {
                        _addresControler.clear();
                      },
                    ),
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
                  text,
                  style:
                      const TextStyle(fontSize: 18, fontFamily: "LibreBodoni-Italic"),
                ),
              )
            ],
          ),
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
