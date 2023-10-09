String validateName (String text){
  if(text.isEmpty){
    return "Tên người dùng không được để trống";
  }
  return "";
}
String validatePhone (String text){
  if(text.isEmpty){
    return "Số điện thoại không được để trống";
  }
  final check = RegExp(r'^(09|03)+[0-9]{8}$');
  if(!check.hasMatch(text)){
    return "Số điện thoại không đúng định dạng";
  }
  return "";
}
String validateAddres (String text){
  if(text.isEmpty){
    return "Địa chỉ không được để trống";
  }
  return "";
}
String validatePassOld (String text){
  if(text.isEmpty){
    return "Mật khẩu cũ không được để trống";
  }
  return "";
}
String validatePassNew (String text){
  if(text.isEmpty){
    return "Mật khẩu mới không được để trống";
  }
  if(text.toString().trim().length< 6){
    return "Mật khẩu lớn hơn 6 kí tự";
  }
  return "";
}
