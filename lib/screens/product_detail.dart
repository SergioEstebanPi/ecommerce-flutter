import 'package:ecommerceapp/widgets/products.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class ProductDetail extends StatefulWidget {
  final productDetailName;
  final productDetailPrice;
  final productDetailOldPrice;
  final productDetailPicture;

  ProductDetail({
    this.productDetailName,
    this.productDetailPrice,
    this.productDetailOldPrice,
    this.productDetailPicture
  });

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage()
                  )
              );
            },
            child: Text("Product details")
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: null
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.productDetailPicture)
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.productDetailName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                          child: Text("\$${widget.productDetailOldPrice}",
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                            )
                          )
                      ),
                      Expanded(
                          child: Text("\$${widget.productDetailPrice}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red
                            ),
                          )
                      ),
                    ],
                  )
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text('Size'),
                              content: Text('Choose the size'),
                              actions: [
                                MaterialButton(
                                  onPressed: (){
                                    Navigator.of(context).pop((context));
                                  },
                                  child: Text('close'),
                                )
                              ],
                            );
                          }
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.grey,
                    elevation: 0.2,
                    child: Row(
                      children: [
                        Expanded(child: Text('Size')),
                        Expanded(child: Icon(Icons.arrow_drop_down))
                      ],
                    ),
                  )
              ),
              Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text('Color'),
                              content: Text('Choose the color'),
                              actions: [
                                MaterialButton(
                                  onPressed: (){
                                    Navigator.of(context).pop((context));
                                  },
                                  child: Text('close'),
                                )
                              ],
                            );
                          }
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.grey,
                    elevation: 0.2,
                    child: Row(
                      children: [
                        Expanded(child: Text('Color')),
                        Expanded(child: Icon(Icons.arrow_drop_down))
                      ],
                    ),
                  )
              ),
              Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text('Quantity'),
                              content: Text('Choose the quantity'),
                              actions: [
                                MaterialButton(
                                  onPressed: (){
                                    Navigator.of(context).pop((context));
                                  },
                                  child: Text('close'),
                                )
                              ],
                            );
                          }
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.grey,
                    elevation: 0.2,
                    child: Row(
                      children: [
                        Expanded(child: Text('Qty')),
                        Expanded(child: Icon(Icons.arrow_drop_down))
                      ],
                    ),
                  )
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text('Size'),
                            content: Text('Choose the size'),
                            actions: [
                              MaterialButton(
                                  onPressed: (){
                                    Navigator.of(context).pop((context));
                                  },
                                child: Text('close'),
                              )
                            ],
                          );
                        }
                    );
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text('Buy now!'),
                )
              ),
              IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.red,
                  ),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text('Size'),
                            content: Text('Choose the size'),
                            actions: [
                              MaterialButton(
                                onPressed: (){
                                  Navigator.of(context).pop((context));
                                },
                                child: Text('close'),
                              )
                            ],
                          );
                        }
                    );
                  }
                  ),
              IconButton(
                  icon: Icon(
                    Icons.favorite_outline,
                    color: Colors.red,
                  ),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text('Size'),
                            content: Text('Choose the size'),
                            actions: [
                              MaterialButton(
                                onPressed: (){
                                  Navigator.of(context).pop((context));
                                },
                                child: Text('close'),
                              )
                            ],
                          );
                        }
                    );
                  }
              )
            ],
          ),
          Divider(),
          ListTile(
            title: Text('Product details'),
            subtitle: Text('list of product details list of product details list of product details list of product details list of product details'),
          ),
          Divider(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  'Product name',
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(widget.productDetailName),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  'Product brand',
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text("${widget.productDetailPrice}"),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  'Product condition',
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text('${widget.productDetailOldPrice}'),
              )
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8),
              child: Text('Similar products')
          ),
          Container(
            height: 500,
            child: SimilarProducts(
                productName: widget.productDetailName,
                productPicture: widget.productDetailPicture,
                productOldPrice: widget.productDetailOldPrice,
                productPrice: widget.productDetailPrice
            ),
          )
        ],
      )
    );
  }
}

class SimilarProducts extends StatefulWidget {
  final productName;
  final productPicture;
  final productOldPrice;
  final productPrice;

  SimilarProducts({
    this.productName,
    this.productPicture,
    this.productOldPrice,
    this.productPrice
  });
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  var productList = [
    {
      'name': 'camisa',
      'picture': 'images/camisa.jpg',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'camisa1',
      'picture': 'images/jeans.jfif',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'jeans2',
      'picture': 'images/jeans.jfif',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'Vestidos',
      'picture': 'images/vestidos.jpg',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'Vestidos4',
      'picture': 'images/vestidos.jpg',
      'old_price': 25,
      'price': 16
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: productList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
        ),
        itemBuilder: (BuildContext context, int index){
          return Product(
            productName: productList[index]['name'],
            productPicture: productList[index]['picture'],
            productOldPrice: productList[index]['old_price'],
            productPrice: productList[index]['price'],
          );
        }
    );
  }
}

class SimilarProduct extends StatelessWidget {
  final productName;
  final productPicture;
  final productOldPrice;
  final productPrice;

  SimilarProduct({
    this.productName,
    this.productPicture,
    this.productOldPrice,
    this.productPrice
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Hero(
            tag: productName,
            child: Material(
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            ProductDetail(
                              productDetailName: productName,
                              productDetailPrice: productPrice,
                              productDetailOldPrice: productOldPrice,
                              productDetailPicture: productPicture,
                            ))
                    ),
                child: GridTile(
                  child: Image.asset(
                    productPicture,
                    fit: BoxFit.cover,
                  ),
                  footer: Container(
                    color: Colors.white,
                    child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              productName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          Text(
                            '\$$productOldPrice',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                          Text(
                            '\$$productPrice',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
              ),
            )
          ),
        ),
      );
    }
  }