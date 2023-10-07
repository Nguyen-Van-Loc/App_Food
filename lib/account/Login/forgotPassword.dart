import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../Validate/validateLogin.dart';
class forgotPassword extends StatefulWidget{
  viewforgotPassword createState()=> viewforgotPassword();
}
class viewforgotPassword extends State<forgotPassword> {
  String errrespass="";
  final _resetpassControler=TextEditingController();
  void onSend()async{
    setState(() {
      errrespass=validateSendEmail(_resetpassControler.text);
    });
    if(errrespass.isEmpty){
      EasyLoading.show(status: "loading...");
      await Future.delayed(Duration(seconds: 3));
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Yêu cầu đã gửi đến Email \n Vui lòng làm theo hướng dẫn");
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _resetpassControler.text);
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Image.asset(
                  "assets/image/Group 97.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                )),
            Positioned(
                left: 0,
                right: 0,
                top: -30,
                child: Image.asset(
                  "assets/image/logo.png",
                  height: 300,
                  width: 300,
                )),
           Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                  width: MediaQuery.of(context).size.width-20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),color: Colors.white,
                    boxShadow:[
                      BoxShadow(color: Colors.grey.withOpacity(0.5),offset: Offset(0,4),blurRadius: 4)
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Khôi phục mật khẩu",style: TextStyle(fontSize: 25,fontFamily: "LibreBodoni-Medium"),),
                      Container(height: 1,width: double.infinity,color: Colors.grey.withOpacity(1),margin: EdgeInsets.symmetric(vertical: 10),),
                      SizedBox(height: 10,),
                      Text("Email",style: TextStyle(fontSize: 18,fontFamily: "LibreBodoni-Medium"),),
                      SizedBox(height: 10,),
                      TextField(
                        controller: _resetpassControler,
                        decoration: InputDecoration(
                          errorText: errrespass.isNotEmpty? errrespass: null,
                          hintText: "Nhập Email ",
                          border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            onSend();
                          },
                          child: Text(
                            "Lấy lại",
                            style: TextStyle(
                                fontSize: 16, fontFamily: "LibreBodoni-Medium"),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Color(0xffFF3D00),
                              padding: EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 35)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: InkWell(
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
            ),
          ],
        ),
      ),
    );
  }
}
