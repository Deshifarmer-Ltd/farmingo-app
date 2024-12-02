import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final ProductModel item;
  const ItemCard({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                height: 120,
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
              const Text('৳ 22 /1 kg'),
              SizedBox(
                  height: 32,
                  child: TextButton(
                    // style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20))),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "ADD",
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
