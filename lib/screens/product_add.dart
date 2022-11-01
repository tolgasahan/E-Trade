import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_flutter_demo/data/dbHelper.dart';
import 'package:sqflite_flutter_demo/models/product.dart';

class ProductAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }

}

class ProductAddState extends State{
  var dbHelper = DbHelper();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            buildField(txtName,"Product Name"),
            buildField(txtDescription, "Product Description"),
            buildField(txtUnitPrice, "Unit Price"),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

 Widget buildField(TextEditingController txt, labelText) {
    return TextField(
      decoration: InputDecoration(labelText: labelText),
      controller: txt,
    );
  }

 Widget buildSaveButton() {
    return TextButton(
      child: Text("Insert"),
      onPressed: (){
        addProduct();
      } ,
    );

  }

  void addProduct() async{
    var result = await dbHelper.insert(Product(txtName.text, txtDescription.text,double.parse(txtUnitPrice.text) ));
    Navigator.pop(context,true);
  }



}