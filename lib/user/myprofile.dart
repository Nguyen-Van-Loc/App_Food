import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:lab5/User/user.dart';
import 'package:lab5/Validate/validateProfile.dart';

class viewMyProfile extends State<myprofile> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int select = 0;
  String errname="",errphone="";
  final  _sexControler = TextEditingController();
  final  _dateControler = TextEditingController();
  final  _usernameControler = TextEditingController();
  final  _phoneControler = TextEditingController();

  void onUpdate()async{
    setState(() {
      errname=validateName(_usernameControler.text);
    });
    if(errname.isEmpty){
      setState(() {
        errphone=validateName(_phoneControler.text);
      });
      if(errphone.isEmpty){
        EasyLoading.show(status: "loading...");
        await Future.delayed(Duration(seconds: 3));
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Cập nhật thành công");
        Update();
      }
    }
  }
  Future<void> Update() async {
    final updateNv = {
      "date": _dateControler.text,
      "phone": _phoneControler.text,
      "sex": _sexControler.text,
      "username": _usernameControler.text,
    };
    firestore.collection("staff").doc(widget.keyId).update(updateNv);
    Navigator.pop(context);
  }
  Widget customRadio(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          select = index;
        });
        _sexControler.text = text;
        Navigator.pop(context);
      },
      child: SizedBox(
          width: double.infinity,
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, fontFamily: "LibreBodoni-Medium"),
          )),
    );
  }
  @override
  void initState() {
    super.initState();
    _usernameControler.text=widget.data["username"];
    _phoneControler.text=widget.data["phone"];
    _sexControler.text=widget.data["sex"];
    _dateControler.text=widget.data["date"];
  }
  void dialogSex() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Giới tính",
                    style: TextStyle(
                        fontSize: 20, fontFamily: "LibreBodoni-Medium"),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: const Color(0xffe7e6e6),
                  ),
                  customRadio("Nam", 1),
                  customRadio("Nữ", 2),
                  customRadio("Khác", 3),
                ],
              ),
            ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _sexControler.clear();
    _phoneControler.clear();
    _dateControler.clear();
    _usernameControler.clear();
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
                      "Hồ sơ của tôi",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "LibreBodoni-BoldItalic"),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 5,
                color: const Color(0xffe7e6e6),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                      padding: const EdgeInsets.only(top: 3),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: Colors.grey.withOpacity(.5),
                      ),
                      width: double.infinity,
                      height: 20,
                      child: const Text(
                        "Ảnh",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ))),
              const SizedBox(
                height: 30,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Tên người dùng",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium", fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _usernameControler,
                        decoration: InputDecoration(
                          errorText:errname.isNotEmpty?errname:null,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          hintText: "Tên người dùng",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {},
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Giới tính",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium", fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () => dialogSex(),
                        child: TextField(
                          controller: _sexControler,
                          enabled: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            hintText: "Giới tính",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Ngày sinh",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium", fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async{
                          var datePicked = await DatePicker.showSimpleDatePicker(
                            context,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2090),
                              dateFormat: "dd-""thg""MM-yyyy",
                            locale: DateTimePickerLocale.en_us,
                            looping: true
                          );
                          String formattedDate = DateFormat("dd-MM-yyyy").format(datePicked!);
                          _dateControler.text= formattedDate;
                        },
                        child: TextField(
                          controller: _dateControler,
                          enabled: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            hintText: "Ngày sinh",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Số điện thoại",
                            style: TextStyle(
                                fontFamily: "LibreBodoni-Medium", fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _phoneControler,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          errorText:errphone.isNotEmpty?errphone:null,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          hintText: "Số điện thoại",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {},
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {onUpdate();},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffff6900),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  "Xác nhận",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "LibreBodoni-MediumItalic",
                      fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
