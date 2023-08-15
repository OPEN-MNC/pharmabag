// class AllCategoriesModel {
//   List<Result>? result;

//   AllCategoriesModel({this.result});

//   AllCategoriesModel.fromJson(Map<String, dynamic> json) {
//     if (json['result'] != null) {
//       result = <Result>[];
//       json['result'].forEach((v) {
//         result!.add(Result.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (result != null) {
//       data['result'] = result!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Result {
//   String? name;
//   List<String>? list;

//   Result({this.name, this.list});

//   Result.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     list = json['list'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['list'] = list;
//     return data;
//   }
// }

// var js = {
//   "result": [
//     {
//       "name": "Ethical",
//       "list": [
//         "Syrups",
//         "Capsules",
//         "Creams",
//         "Lotions",
//         "Ointments",
//         "Suppositories",
//         "Drops",
//         "Inhalers",
//         "Injections",
//         "Tablets",
//         "Powders/Granules"
//       ]
//     },
//     {
//       "name": "Generic",
//       "list": [
//         "Syrups",
//         "Capsules",
//         "Creams",
//         "Lotions",
//         "Ointments",
//         "Suppositories",
//         "Drops",
//         "Inhalers",
//         "Injections",
//         "Tablets",
//         "Powders/Granules"
//       ]
//     },
//     {
//       "name": "OTC",
//       "list": [
//         "Syrups",
//         "Capsules",
//         "Creams",
//         "Lotions",
//         "Ointments",
//         "Suppositories",
//         "Drops",
//         "Inhalers",
//         "Injections",
//         "Tablets",
//         "Powders/Granules"
//       ]
//     },
//     {
//       "name": "Ayurvedic",
//       "list": [
//         "Syrups",
//         "Capsules",
//         "Creams",
//         "Lotions",
//         "Ointments",
//         "Suppositories",
//         "Drops",
//         "Inhalers",
//         "Injections",
//         "Tablets",
//         "Powders/Granules"
//       ]
//     },
//     {
//       "name": "Surgical",
//       "list": [
//         "Syrups",
//         "Capsules",
//         "Creams",
//         "Lotions",
//         "Ointments",
//         "Suppositories",
//         "Drops",
//         "Inhalers",
//         "Injections",
//         "Tablets",
//         "Powders/Granules"
//       ]
//     },
//     {
//       "name": "Critical Care",
//       "list": ["Intensive Care Medicine", "Clinical Nutrition", "Shock"]
//     },
//     {
//       "name": "Others",
//       "list": ["Syrups", "Capsules"]
//     }
//   ]
// };
class categories {
  late String sId;
  late String categoryName;
  late int iV;

  categories({required this.sId, required this.categoryName, required this.iV});

  categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['category_name'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['category_name'] = categoryName;
    data['__v'] = iV;
    return data;
  }
}

class subcategories {
  late String sId;
  late String subcategoryName;
  late String parent;
  late int iV;

  subcategories(
      {required this.sId,
      required this.subcategoryName,
      required this.parent,
      required this.iV});

  subcategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    subcategoryName = json['subcategory_name'];
    parent = json['parent'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['subcategory_name'] = subcategoryName;
    data['parent'] = parent;
    data['__v'] = iV;
    return data;
  }
}

class Products {
  int? status;
  String? message;
  List<ResultProducts>? resultProducts;

  Products({this.status, this.message, this.resultProducts});

  Products.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result_products'] != null) {
      resultProducts = <ResultProducts>[];
      json['result_products'].forEach((v) {
        resultProducts!.add(ResultProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (resultProducts != null) {
      data['result_products'] = resultProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultProducts {
  String? sId;
  String? sellerId;
  List<String>? imageList;
  String? productName;
  int? productPrice;
  String? companyName;
  String? minOrderQty;
  String? maxOrderQty;
  String? expireDate;
  DiscountDetails? discountDetails;
  DiscountFormDetails? discountFormDetails;
  int? stock;
  bool? bulk;
  List<String>? extraFields;
  Categories? categories;
  String? chemicalCombination;
  String? date;
  int? status;
  int? iV;

  ResultProducts(
      {this.sId,
      this.sellerId,
      this.imageList,
      this.productName,
      this.productPrice,
      this.companyName,
      this.minOrderQty,
      this.maxOrderQty,
      this.expireDate,
      this.discountDetails,
      this.discountFormDetails,
      this.stock,
      this.bulk,
      this.extraFields,
      this.categories,
      this.chemicalCombination,
      this.date,
      this.status,
      this.iV});

  ResultProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sellerId = json['seller_id'];
    imageList = json['image_list'].cast<String>();
    productName = json['product_name'];
    productPrice = json['product_price'];
    companyName = json['company_name'];
    minOrderQty = json['min_order_qty'].toString();
    maxOrderQty = json['max_order_qty'].toString();
    expireDate = json['expire_date'];
    discountDetails = json['discount_details'] != null
        ? DiscountDetails.fromJson(json['discount_details'])
        : null;
    discountFormDetails = json['discount_form_details'] != null
        ? DiscountFormDetails.fromJson(json['discount_form_details'])
        : null;
    stock = json['stock'];
    bulk = json['bulk'];
    extraFields = json['extra_fields'].cast<String>();
    categories = json['categories'] != null
        ? Categories.fromJson(json['categories'])
        : null;
    chemicalCombination = json['chemical_combination'];
    date = json['date'];
    status = json['status'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['seller_id'] = sellerId;
    data['image_list'] = imageList;
    data['product_name'] = productName;
    data['product_price'] = productPrice;
    data['company_name'] = companyName;
    data['min_order_qty'] = minOrderQty;
    data['max_order_qty'] = maxOrderQty;
    data['expire_date'] = expireDate;
    if (discountDetails != null) {
      data['discount_details'] = discountDetails!.toJson();
    }
    if (discountFormDetails != null) {
      data['discount_form_details'] = discountFormDetails!.toJson();
    }
    data['stock'] = stock;
    data['bulk'] = bulk;
    data['extra_fields'] = extraFields;
    if (categories != null) {
      data['categories'] = categories!.toJson();
    }
    data['chemical_combination'] = chemicalCombination;
    data['date'] = date;
    data['status'] = status;
    data['__v'] = iV;
    return data;
  }
}

class DiscountDetails {
  bool? status;
  String? type;
  String? finalPtr;
  String? discount;
  String? discountValue;
  String? ptr;
  String? perPtr;
  String? gst;
  String? gstValue;
  String? retailPercentage;
  String? finalUserBuy;
  String? finalOrderValue;
  String? message;
  int? bonus;

  DiscountDetails(
      {this.status,
      this.type,
      this.finalPtr,
      this.discount,
      this.discountValue,
      this.ptr,
      this.perPtr,
      this.gst,
      this.gstValue,
      this.retailPercentage,
      this.finalUserBuy,
      this.finalOrderValue,
      this.message,
      this.bonus});

  DiscountDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    finalPtr = json['final_ptr'];
    discount = json['discount'];
    discountValue = json['discount_value'];
    ptr = json['ptr'];
    perPtr = json['per_ptr'];
    gst = json['gst'];
    gstValue = json['gst_value'];
    retailPercentage = json['retail_percentage'];
    finalUserBuy = json['final_user_buy'];
    finalOrderValue = json['final_order_value'];
    message = json['message'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['type'] = type;
    data['final_ptr'] = finalPtr;
    data['discount'] = discount;
    data['discount_value'] = discountValue;
    data['ptr'] = ptr;
    data['per_ptr'] = perPtr;
    data['gst'] = gst;
    data['gst_value'] = gstValue;
    data['retail_percentage'] = retailPercentage;
    data['final_user_buy'] = finalUserBuy;
    data['final_order_value'] = finalOrderValue;
    data['message'] = message;
    data['bonus'] = bonus;
    return data;
  }
}

class DiscountFormDetails {
  String? gstPercentage;
  String? mrp;
  String? buy;
  String? get;
  String? producName;
  String? maxQtySale;
  String? minQtySale;
  String? discountOnPtrOnlyPercenatge;
  String? userBuy;

  DiscountFormDetails(
      {this.gstPercentage,
      this.mrp,
      this.buy,
      this.get,
      this.producName,
      this.maxQtySale,
      this.minQtySale,
      this.discountOnPtrOnlyPercenatge,
      this.userBuy});

  DiscountFormDetails.fromJson(Map<String, dynamic> json) {
    gstPercentage = json['gstPercentage'];
    mrp = json['mrp'];
    buy = json['buy'];
    get = json['get'];
    producName = json['producName'];
    maxQtySale = (json['maxQtySale']).toString();
    minQtySale = (json['minQtySale']).toString();
    discountOnPtrOnlyPercenatge = json['discountOnPtrOnlyPercenatge'];
    userBuy = json['userBuy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['gstPercentage'] = gstPercentage;
    data['mrp'] = mrp;
    data['buy'] = buy;
    data['get'] = get;
    data['producName'] = producName;
    data['maxQtySale'] = maxQtySale;
    data['minQtySale'] = minQtySale;
    data['discountOnPtrOnlyPercenatge'] = discountOnPtrOnlyPercenatge;
    data['userBuy'] = userBuy;
    return data;
  }
}

class Categories {
  String? categoryName;
  String? subCategoryName;

  Categories({this.categoryName, this.subCategoryName});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category_name'] = categoryName;
    data['sub_category_name'] = subCategoryName;
    return data;
  }
}
