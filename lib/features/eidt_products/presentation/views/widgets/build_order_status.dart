import 'package:flutter/material.dart';

class BuildOrderStatus extends StatelessWidget {
  final String title;
   final int count;
   final bool isSelected;
   final void Function()? onTap;
  const BuildOrderStatus({super.key, required this.title, required this.count, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).scaffoldBackgroundColor : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
                ),
              ),
              if (isSelected) ...[
                const SizedBox(height: 4),
                Text(
                  '($count)',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      )
    ;
  }
}

