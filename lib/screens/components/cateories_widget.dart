import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  final Function(String category) onSelect;
  CategoriesWidget({Key? key, required this.onSelect}) : super(key: key);
  var built = false;

  @override
  Widget build(BuildContext context) {
    if (!built) {
      built = true;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //...
      ],
    );
  }
}
