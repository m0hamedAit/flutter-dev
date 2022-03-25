import 'package:flutter/material.dart';
import 'models/Product.dart';
import 'widgets/TextEdit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Product> products = [];
  final prodNameController = TextEditingController();
  final prodPriceController = TextEditingController();

  void deleteProduct(int index) {
    products.removeAt(index);
  }

  void addProduct(){
    Product product = Product(prodNameController.text, double.parse(prodPriceController.text));
    if(!product.CheckIfExist(products)) {
      products.add(product);
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Products")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextEdit("Name ", prodNameController),
                TextEdit("Price ", prodPriceController),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: MaterialButton(
                    color: Colors.lightBlue,
                    child: const Icon(Icons.add, color: Colors.white,),
                    onPressed: () {
                      setState(() {
                        addProduct();
                      });
                    }),
                ),
                Expanded(child:ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder:(BuildContext context,int index){
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(child: Text(products[index].name.substring(0,1))),
                          trailing: IconButton(
                              icon:const Icon(Icons.delete),
                              onPressed: (){
                                setState(() {
                                  deleteProduct(index);
                                });
                              }),
                          title: Text(products[index].name),
                          subtitle: Text("${products[index].price}\$"),
                        ),);
                    }
                ) )

              ]
          ),

        ) ,
      ),
    );
  }
}

