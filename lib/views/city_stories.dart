import 'package:flutter/material.dart';

class CityStories extends StatelessWidget {
  const CityStories({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 8,
            child: Image.asset('name'),
          ),
          Text('Eldoret'),
        ],
      ),
    );
  }
}
