// ignore_for_file: file_names

class Searchdata {
  String name;
  double price;
  String img;
  Searchdata(this.img, this.price, this.name);
}

class MyCartItems {
  String name;
  double price;
  double sale;
  bool hasOffer;
  bool isClothes;
  String Img;
  MyCartItems(this.Img, this.isClothes, this.name, this.price, this.sale,
      this.hasOffer);
}
