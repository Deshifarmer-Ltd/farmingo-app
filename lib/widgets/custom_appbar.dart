
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {

              // Navigator.push(context, MaterialPageRoute(builder: (_)=>TestPage()));

            },
            icon: const Icon(
              Icons.person_2_outlined,
            )),
        const Expanded(
          child: SizedBox(
            height: 50,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: SearchBar(
                hintText: 'Search your fresh vegetables',
                trailing: [Icon(Icons.search_rounded)],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Badge(
            label: Text('4'),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}
