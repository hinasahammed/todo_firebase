import 'package:flutter/material.dart';

class Testt extends StatefulWidget {
  const Testt({super.key});

  @override
  State<Testt> createState() => _TesttState();
}

class _TesttState extends State<Testt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                image: DecorationImage(
                    image: const AssetImage(
                        "assets/images/task_item_container.png"),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      Colors.deepPurple.withOpacity(.8),
                      BlendMode.srcATop,
                    )),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Text("Ongoing"),
                      Icon(Icons.add_circle),
                      Spacer(),
                      Text(
                        "Ongoing",
                        style: TextStyle(color: Colors.black),
                      ),
                      Icon(
                        Icons.add_circle,
                        color: Colors.black,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 400,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 70,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.lerp(
                        BorderRadius.circular(10),
                        BorderRadius.circular(10),
                        20,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
