import 'package:flutter/material.dart';

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
        title: Text("E-commerce App"),
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: null
          ),
          IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: null
          )
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
          )
        ],
      )
    );
  }
}
