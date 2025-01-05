import 'package:storeapp/helper/API.dart';
import 'package:storeapp/models/productModel.dart';

class Addproduct {
  Future<Productmodel> AddProduct(
      {required String title,
      required String price,
      required String desc,
      required String image,
      required String category}) async {
    Map<String, dynamic> data = await Api().post(
      Url: 'https://fakestoreapi.com/products',
      body: {
        'title': title,
        'price': price,
        'description': desc,
        'image': image,
        'category': category
      }, token: '',
    );
    return Productmodel.fromJson(data);
  }
}
