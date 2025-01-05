

import 'package:storeapp/helper/API.dart';
import 'package:storeapp/models/productModel.dart';

class Updateproduct {
  Future<Productmodel> updateProduct(
      {required String title,
      required String price,
      required String desc,
      required String image,
      required String category}) async {
    // ignore: missing_required_param
    Map<String, dynamic> data = await Api().post(
      Url: 'https://fakestoreapi.com/products',
      body: {
        'title': title,
        'price': price,
        'description': desc,
        'image': image,
        'category': category
      },
    );
    return Productmodel.fromJson(data);
  }
}