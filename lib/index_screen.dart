import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome'),
            FilledButton(
              onPressed: () {
                context.go('/${DateTime.now().year}');
              },
              child: Text('Open Calendar'),
            ),
          ],
        ),
      ),
    );
  }
}
