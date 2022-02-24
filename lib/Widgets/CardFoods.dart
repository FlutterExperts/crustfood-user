import 'package:flutter/material.dart';

class CardFoods extends StatelessWidget {
  final String image;
  final String title;
  final String typeFood;
  final String price;

  const CardFoods(this.image, this.title, this.typeFood, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                blurRadius: 8, color: const Color(0xffFFDB84).withOpacity(0.3))
          ],
          color: const Color(0xffFFFDF7)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              image,
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff544646),
                  fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              typeFood,
              style: const TextStyle(color: const Color(0xff707070)),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              "\$$price",
              style: const TextStyle(color: Color(0xff0A9400), fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
