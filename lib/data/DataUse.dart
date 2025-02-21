// ignore_for_file: file_names

class Searchdata {
  String name;
  double price;
  String img;
  Searchdata(this.img, this.price, this.name);
}

class MyCartItems {
  final String img;
  final bool hasOffer;
  final String name;
  final double price;
  final double sale;
  final bool available;
  int quantity; // ✨ إضافة عدد العناصر لكل منتج

  MyCartItems(this.img, this.hasOffer, this.name, this.price, this.sale,
      this.available, this.quantity);
}
