class DistrictBranch{
  int id;
  String name;

  DistrictBranch(
      this.id,
      this.name
      );

  DistrictBranch.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        name = json["name"];

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name
  };

}