String validateUsername(String txt){
  if(txt.isEmpty){
    return "Tên người dùng không được để trống";
  }
  return "";
}
String validateEmail(String txt){
  if(txt.isEmpty){
    return "Email không được để trống";
  }final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  if (!emailRegExp.hasMatch(txt)) {
    return "Email không đúng định dạng";
  }
  return "";
}
String validatePassword(String txt){
  if(txt.isEmpty){
    return "Mật khẩu không được để trống";
  }
  if(txt.length<6){
    return "Mật khẩu không được nhỏ hơn 6 ký tự";
  }
  return "";
}
String validateRePassword(String txt,String txt1){
  if(txt.isEmpty){
    return "Nhập lại mật khẩu không được để trống";
  }
  if(txt!=txt1){
    return "Nhập lại mật khẩu không trùng khớp";
  }
  return "";
}
String validateSendEmail(String txt){
  if(txt.isEmpty){
    return "Email không được để trống";
  }final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  if (!emailRegExp.hasMatch(txt)) {
    return "Email không đúng định dạng";
  }
  return "";
}