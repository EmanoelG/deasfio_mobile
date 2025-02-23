import 'package:flutter/material.dart';

class CategoryTitle extends StatefulWidget {
  const CategoryTitle({
    Key? key,
    required this.category,
    required this.isSelect,
    required this.onPresseds,
  }) : super(key: key);
  final String category;
  final bool isSelect;

  final VoidCallback onPresseds;
  @override
  State<CategoryTitle> createState() => _CategoryTitleState();
}

class _CategoryTitleState extends State<CategoryTitle> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: widget.onPresseds,
        child: Ink(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: widget.isSelect
                    ? Color.fromARGB(255, 15, 15, 15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.category,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: widget.isSelect ? 16 : 14,
                    color: widget.isSelect ? Colors.white : Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
