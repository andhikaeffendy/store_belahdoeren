import 'package:store_belahdoeren/model/produk.dart';

class Category {
  int id;
  String name;
  String description;
  List<Produk> menus = [];

  Category({this.id, this.name, this.description});

  Category.fromJson(Map<String, dynamic> json):
      id = json.containsKey("id") ? json["id"] : null,
      name = json.containsKey("name") ? json["name"] : null,
      description = json.containsKey("description") ? json["description"] : null;

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "description" : description
  };
}