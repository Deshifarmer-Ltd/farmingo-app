import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final ProductModel item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (ctx, constrain) {
          return Container(
            width: constrain.maxHeight*0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.network(
                    height: constrain.maxHeight * 0.4,
                    // height: MediaQuery.of(context).size.height*0.2,
                    item.image,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '৳ ${item.price.toString()}',
                          // The first part with special styling
                          style: const TextStyle(
                            fontSize: 18, // Example: larger font size
                            fontWeight: FontWeight.bold, // Bold text
                            color: Colors.green, // Custom color
                          ),
                        ),
                        TextSpan(
                          text: ' /${item.unit}', // The second part
                          style: const TextStyle(
                            fontSize: 14, // Smaller font size
                            fontWeight: FontWeight.normal, // Regular weight
                            color: Colors.grey, // A different color
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Obx(builder)

                  // SizedBox(
                  //     height:constrain.maxHeight*0.2,
                  //     child: TextButton(
                  //       // style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20))),
                  //       onPressed: () {},
                  //       child: const Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 20.0),
                  //         child: Text(
                  //           "ADD",
                  //         ),
                  //       ),
                  //     )),
                  Container(
                    height: 50,
                    width: 120,
                    decoration: const BoxDecoration(
                        color: Color(0xFF16A34A),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: (){}, icon: const Icon(Icons.remove,color: Colors.white,)),
                        const Text('10',style: TextStyle(color: Colors.white)),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.add,color: Colors.white,)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
