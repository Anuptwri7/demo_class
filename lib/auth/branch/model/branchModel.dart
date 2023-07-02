class Branch {
  int? count;
  Null? next;
  Null? previous;
  List<Result>? results;

  Branch({this.count, this.next, this.previous, this.results});

  Branch.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((v) {
        results!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? name;
  String? schemaName;
  String? subDomain;
  bool? active;

  Result({this.id, this.name, this.schemaName, this.subDomain, this.active});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    schemaName = json['schemaName'];
    subDomain = json['subDomain'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['schemaName'] = this.schemaName;
    data['subDomain'] = this.subDomain;
    data['active'] = this.active;
    return data;
  }
}