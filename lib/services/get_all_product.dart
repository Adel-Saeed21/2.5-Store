

import 'package:storeapp/helper/API.dart';
import 'package:storeapp/models/productModel.dart';


class GetAllProductService {
  Future<List<Productmodel>> getAllProducts() async {
    List<dynamic> data =
        await Api().get(URl: 'https://fakestoreapi.com/products', token: '');

    List<Productmodel> productlist = [];
    for (int i = 0; i < data.length; i++) {
      productlist.add(Productmodel.fromJson(data[i]));
    }
    return productlist;
  }
}
