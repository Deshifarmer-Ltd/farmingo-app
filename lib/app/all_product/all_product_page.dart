import 'package:farmingo/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';


class AllProductPage extends StatelessWidget {
  const AllProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const CustomAppbar(),
          Expanded(
            child: GridView.builder(
                itemCount: 20,
                shrinkWrap: true,
                gridDelegate:
                    //mainAxisExtent means height of the title
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisExtent: 230),
                itemBuilder: (ctx, i) {
                  // return const ItemCard();
                  return const Text('sgvbs');
                }),
          ),
        ],
      )),
    );
  }
}
