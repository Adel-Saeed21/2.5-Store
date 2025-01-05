class Productmodel {
  final int id;
  final String title, description, image;
  final double price;
  final RatingModel rating;

  Productmodel(
      {required this.id,
      required this.rating,
      required this.title,
      required this.description,
      required this.image,
      required this.price});

  factory Productmodel.fromJson(jsondata) {
    return Productmodel(
        id: jsondata['id'],
        rating: RatingModel.fromJson(jsondata['rating']),
        title: jsondata['title'],
        description: jsondata['description'],
        image: jsondata['image'],
        price: (jsondata['price']as num).toDouble());
  }
}

class RatingModel {
  final double rate;
  final double count;

  factory RatingModel.fromJson(jsonRate) {
    return RatingModel(rate:( jsonRate['rate']as num).toDouble(), count: (jsonRate['count']as num).toDouble());
  }

  RatingModel({required this.rate, required this.count});
}
