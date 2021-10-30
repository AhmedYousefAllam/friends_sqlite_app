import 'package:flutter/material.dart';

class SaveUpdatesButton extends StatelessWidget{
  Function function ;
  SaveUpdatesButton(this.function);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
      ),
      child:Container(
        child: Text('Save Updates'),
      ),
      onPressed: (){
        function();
      },
    );
  }

}