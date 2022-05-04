import 'package:flutter/material.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeSection extends StatefulWidget {
  final String icon;
  final String title;
  Widget content;

  HomeSection({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
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
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(
        top: normalize(12),
        left: normalize(8),
        right: normalize(8),
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(
          Radius.circular(normalize(12)),
        ),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: normalize(6),
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: normalize(48),
            padding: EdgeInsets.symmetric(horizontal: normalize(12)),
            child: Row(
              children: [
                SvgPicture.asset(
                  widget.icon,
                  height: normalize(24),
                  width: normalize(24),
                ),
                Container(
                  margin: EdgeInsets.only(left: normalize(8)),
                  child: Text(
                    widget.title,
                    maxLines: 1,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: normalize(18),
                      height: 24 / 18,
                      fontWeight: FontWeight.bold,
                      color: black33,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            color: greyF1,
          ),
          Container(
            child: widget.content,
          )
        ],
      ),
    );
  }
}
