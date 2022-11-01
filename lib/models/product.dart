class Product {
  int id = 0;
  String name = "";
  String description = "";
  double unitPrice = 0.0;

  Product(this.name, this.description, this.unitPrice);
  Product.withID(this.id, this.name, this.description, this.unitPrice);

  Map<String,dynamic?> toMap() {
    var map = Map<String,dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;
    if(id != null){
      map["id"] = id;
    }
    return map;
  }

  Product.fromObject(dynamic o){
    this.id = int.tryParse(o["id"])!;
    this.name = o["name"];
    this.description = o["description"];
    this.unitPrice = double.tryParse(o["unitPrice"])!;

  }
}