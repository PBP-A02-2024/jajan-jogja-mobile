import "package:flutter/material.dart";
import "package:jajan_jogja_mobile/widgets/navbar.dart";

class FoodPlans extends StatelessWidget {
  const FoodPlans({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navbar(context),
      body: Container(
        color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              'Food Plans',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              child: const Text('Create Food Plan'),
            ),
          ],
        ),
      ),
    );
  }
}