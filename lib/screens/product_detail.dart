import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_flutter_demo/data/dbHelper.dart';
import 'package:sqflite_flutter_demo/models/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);
  @override
  State<StatefulWidget> createState() {
    return ProductDetailState(product);
  }
}

enum Options { delete, update }

class ProductDetailState extends State {
  Product? product;
  ProductDetailState(this.product);
  var dbHelper = DbHelper();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtUnitPrice = TextEditingController();

  @override
  void initState() {

    txtName.text = product!.name ;
    txtDescription.text = product!.description ;
    txtUnitPrice.text = product!.unitPrice.toString() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product: ${product?.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Delete"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Update"),
              )
            ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildField(txtName, "Product Name"),
          buildField(txtDescription, "Product Description"),
          buildField(txtUnitPrice, "Unit Price"),
        ],
      ),
    );
  }

  Widget buildField(TextEditingController txt, labelText) {
    return TextField(
      decoration: InputDecoration(labelText: labelText),
      controller: txt,
    );
  }

  void selectProcess(Options value) async {
    switch (value) {
      case Options.delete:
        await dbHelper.delete(int.parse(product!.id.toString()));
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Product.withID(product?.id, txtName.text,
            txtDescription.text, double.parse(txtUnitPrice.text)));
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}
