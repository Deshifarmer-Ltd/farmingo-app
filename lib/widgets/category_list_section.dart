import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:farmingo/widgets/item_card.dart';
import 'package:flutter/material.dart';

class CategoryListSection extends StatelessWidget {
  final String title;
  final List<ProductModel> items;

  const CategoryListSection({super.key, required this.title,required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              TextButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: () {

                  //TODO: add onpress method
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
                label: const Text('SEE MORE'),
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                    foregroundColor: WidgetStatePropertyAll(Colors.green),
                    textStyle: WidgetStatePropertyAll(
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 10 / 6.5,
          child: ListView.builder(
            itemBuilder: (ctx, i) {

              var item = items.elementAt(i);

              return  ItemCard(item: item,);
            },
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
