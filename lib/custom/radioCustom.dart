import 'package:flutter/material.dart';

class CusTomRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final Widget text;
  final ValueChanged<T?> onChanged;

  const CusTomRadio({super.key, required this.value,required this.groupValue,required this.text,required this.onChanged});


  Widget _buildRadio(){
    final bool isSelect = value == groupValue;
    return Container(
      width: 20,height: 20,
      child: isSelect? Image.asset("assets/image/radio.png",height: 20,width: 20,):Image.asset("assets/image/radio-button.png",height: 20,width: 20,)
    );
  }
  Widget _buildTitle(){
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: ()=>onChanged(value),
        child: Row(
          children: [
            _buildRadio(),
            SizedBox(height: 10,),
            _buildTitle()
          ],
        ),
      )
    );
  }
}