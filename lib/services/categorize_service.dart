import 'package:storeapp/helper/API.dart';
import 'package:storeapp/models/productModel.dart';

class CategorizeService {
  Future<List<Productmodel>> getProducts({required String catgoryname}) async {
    List<dynamic> data = await Api()
        .get(URl: 'https://fakestoreapi.com/products/category/$catgoryname', token: '');

    List<Productmodel> productlist = [];
    for (int i = 0; i < data.length; i++) {
      productlist.add(Productmodel.fromJson(data[i]));
    }
    return productlist;
  }
}
