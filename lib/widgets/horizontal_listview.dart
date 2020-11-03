import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Category(
            imageLocation: 'images/camisa.jpg',
            imageCaption: 'Camisas',
          ),
          Category(
            imageLocation: 'images/jeans.jfif',
            imageCaption: 'Jeans',
          ),
          Category(
            imageLocation: 'images/jeans2.jfif',
            imageCaption: 'Jeans2',
          ),
          Category(
            imageLocation: 'images/vestidos.jpg',
            imageCaption: 'Vestido',
          ),
          Category(
            imageLocation: 'images/camisa.jpg',
            imageCaption: 'Camisas',
          )
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;

  Category({
    this.imageLocation,
    this.imageCaption
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(2),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 80,
          child: ListTile(
            title: Image.asset(
              imageLocation,
              width: 40,
              height: 40,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              height: 100,
              child: Text(
                imageCaption,
                style: TextStyle(
                  fontSize: 12
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}