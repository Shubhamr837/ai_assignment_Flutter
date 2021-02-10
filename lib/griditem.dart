import 'package:flutter/material.dart';

class GridItem extends StatefulWidget {
  @override
  _GridItemState createState() => _GridItemState();
  var color;
  GridItem({@required this.color});
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.10),
      child: Container(height: 3,width: 3,color: widget.color,),
    );
  }
}
