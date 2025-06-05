import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        child: Icon(Icons.shopping_bag, color: Colors.white),
      ),
      title: Text('Uniqlo', style: TextStyle(fontSize: 18)),
      subtitle: Text(
        'Gangnam Branch',
        style: TextStyle(color: Colors.grey.shade800),
      ),
      trailing: Text(
        '\$452,895',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
