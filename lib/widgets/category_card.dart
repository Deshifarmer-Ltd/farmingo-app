import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  const CategoryCard({super.key,required this.category});
  //TODO: add effects on button press

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {

                // Navigator.push(context, MaterialPageRoute(builder: (_)=>AllProductPage()));

              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                // Optional: For rounded corners
                child: Image.network(
                  category.image,
                  // Replace with your image path
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover, // Makes the image fill the container
                ),
              ),
            ),
             Text(
               category.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
