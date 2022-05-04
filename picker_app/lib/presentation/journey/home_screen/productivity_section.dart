import 'package:flutter/material.dart';
import 'package:picker/utils/normalize.dart';
import 'productivity_table.dart';

class ProductivitySection extends StatefulWidget {
  ProductivitySection({Key? key}) : super(key: key);

  @override
  _ProductivitySectionState createState() => _ProductivitySectionState();
}

class _ProductivitySectionState extends State<ProductivitySection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: normalize(16),
        bottom: normalize(12),
      ),
      height: normalize(48),
      child: ProductivityTable(),
    );
  }
}
