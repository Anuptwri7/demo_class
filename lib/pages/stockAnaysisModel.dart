class StockAnalysisModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  StockAnalysisModel({this.count, this.next, this.previous, this.results});

  StockAnalysisModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
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

class Results {
  int? id;
  double? purchaseCost;
  double? saleCost;
  String? name;
  bool? discountable;
  bool? taxable;
  double? taxRate;
  String? code;
  int? itemCategory;
  double? purchaseQty;
  double? purchaseReturnQty;
  double? saleQty;
  double? saleReturnQty;
  double? pendingCustomerOrderQty;
  double? chalanQty;
  double? chalanReturnQty;
  double? transferQty;
  double? departmentTransferQty;
  double? consumedQty;
  double? reservedTaskQty;
  double? manufacturedQty;
  double? remainingQty;
  String? itemCategoryName;

  Results(
      {this.id,
        this.purchaseCost,
        this.saleCost,
        this.name,
        this.discountable,
        this.taxable,
        this.taxRate,
        this.code,
        this.itemCategory,
        this.purchaseQty,
        this.purchaseReturnQty,
        this.saleQty,
        this.saleReturnQty,
        this.pendingCustomerOrderQty,
        this.chalanQty,
        this.chalanReturnQty,
        this.transferQty,
        this.departmentTransferQty,
        this.consumedQty,
        this.reservedTaskQty,
        this.manufacturedQty,
        this.remainingQty,
        this.itemCategoryName});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purchaseCost = json['purchaseCost'];
    saleCost = json['saleCost'];
    name = json['name'];
    discountable = json['discountable'];
    taxable = json['taxable'];
    taxRate = json['taxRate'];
    code = json['code'];
    itemCategory = json['itemCategory'];
    purchaseQty = json['purchaseQty'];
    purchaseReturnQty = json['purchaseReturnQty'];
    saleQty = json['saleQty'];
    saleReturnQty = json['saleReturnQty'];
    pendingCustomerOrderQty = json['pendingCustomerOrderQty'];
    chalanQty = json['chalanQty'];
    chalanReturnQty = json['chalanReturnQty'];
    transferQty = json['transferQty'];
    departmentTransferQty = json['departmentTransferQty'];
    consumedQty = json['consumedQty'];
    reservedTaskQty = json['reservedTaskQty'];
    manufacturedQty = json['manufacturedQty'];
    remainingQty = json['remainingQty'];
    itemCategoryName = json['itemCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purchaseCost'] = this.purchaseCost;
    data['saleCost'] = this.saleCost;
    data['name'] = this.name;
    data['discountable'] = this.discountable;
    data['taxable'] = this.taxable;
    data['taxRate'] = this.taxRate;
    data['code'] = this.code;
    data['itemCategory'] = this.itemCategory;
    data['purchaseQty'] = this.purchaseQty;
    data['purchaseReturnQty'] = this.purchaseReturnQty;
    data['saleQty'] = this.saleQty;
    data['saleReturnQty'] = this.saleReturnQty;
    data['pendingCustomerOrderQty'] = this.pendingCustomerOrderQty;
    data['chalanQty'] = this.chalanQty;
    data['chalanReturnQty'] = this.chalanReturnQty;
    data['transferQty'] = this.transferQty;
    data['departmentTransferQty'] = this.departmentTransferQty;
    data['consumedQty'] = this.consumedQty;
    data['reservedTaskQty'] = this.reservedTaskQty;
    data['manufacturedQty'] = this.manufacturedQty;
    data['remainingQty'] = this.remainingQty;
    data['itemCategoryName'] = this.itemCategoryName;
    return data;
  }
}