
class Product{
  String name;
  //String description;
  double price;
  //int stock;

  Product(this.name,  this.price);

  bool CheckIfExist(List<Product> products){
    for(Product pr in products) {
      if(pr.name == name && pr.price == price) {
        return true;
      }
    }
    return false;
  }


}