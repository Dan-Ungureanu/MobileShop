import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsText extends StatefulWidget {
  final String details;

  const ProductDetailsText({super.key, required this.details});

  @override
  State<ProductDetailsText> createState() => _ProductDetailsTextState();
}

class _ProductDetailsTextState extends State<ProductDetailsText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final hasDetails = widget.details.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hasDetails ? widget.details : 'No description available.',
          maxLines: _expanded ? null : 2,
          overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 4.h),
        if (hasDetails)
          GestureDetector(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Text(
              _expanded ? 'Read less' : 'Read more',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.green[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
