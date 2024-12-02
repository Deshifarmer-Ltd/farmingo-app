import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.deepPurple.shade100,body: SafeArea(child:

        CustomScrollView(slivers: [

          SliverAppBar(
          backgroundColor: Colors.deepPurple,
          leading: Icon(Icons.menu),
          title: Text('Farmingo'),
          flexibleSpace: FlexibleSpaceBar(background:  const CustomAppbar()),
          expandedHeight: 150,
            floating: false,
            pinned: true,



        ),

          // SliverToBoxAdapter(child: const CategoryListSection(title: 'Vegetables (সবজি)',),),
          // SliverToBoxAdapter(child: const CategoryListSection(title: 'Vegetables (সবজি)',),),
          // SliverToBoxAdapter(child: const CategoryListSection(title: 'Vegetables (সবজি)',),),
          // SliverToBoxAdapter(child: const CategoryListSection(title: 'Vegetables (সবজি)',),),
          // SliverToBoxAdapter(child: const CategoryListSection(title: 'Vegetables (সবজি)',),),
          // SliverToBoxAdapter(child: const CategoryListSection(title: 'Vegetables (সবজি)',),)

          // const CategoryListSection(title:'Leafy Green(শাক)' ,),
          // const CategoryListSection(title:'Dry vegetables (শুকনো সবজি)' ,),
          // const CategoryListSection(title:'Dry vegetables (শুকনো সবজি)' ,),

        ],)


    ),);
  }
}
