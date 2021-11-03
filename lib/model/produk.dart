class Produk {
  int id;
  String name;
  String description;
  int price;
  int active_status;
  int featured;
  int stock_status;
  String image_url;

  Produk({this.id, this.name, this.description, this.price, this.active_status,
      this.featured, this.stock_status, this.image_url});

  Produk.fromJson(Map<String, dynamic> json):
      id = json.containsKey("id") ? json["id"] : null,
      name = json.containsKey("name") ? json["name"] : "",
      description = json.containsKey("description") ? json["description"] : "",
      price = json.containsKey("price") ? json["price"] : 0,
      active_status = json.containsKey("active_status") ? json["active_status"] : 0,
      featured = json.containsKey("featured") ? json["featured"] : null,
      stock_status = json.containsKey("stock_status") ? json["stock_status"] : null,
      image_url = json.containsKey("image_url") ? json["image_url"] : null;

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "description" : description,
    "price" : price,
    "active_status" : active_status,
    "featured" : featured,
    "stock_status" : stock_status,
    "image_url" : image_url,
  };

  bool getActiveStatus() => stock_status == null ? false : stock_status == 1 ? true : false;
}