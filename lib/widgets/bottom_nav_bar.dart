import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> icons = [
      'assets/icons/home.png',
      'assets/icons/market.png',
      '', // handled separately
      'assets/icons/mutation.png',
      'assets/icons/menu.png',
    ];

    List<String> labels = ['Home', 'Market', '', 'Mutation', 'Menu'];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFA726).withOpacity(0.6),
            const Color(0xFF6D4C41),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 12.sp),
        items: List.generate(icons.length, (index) {
          // Center Add Icon
          if (index == 2) {
            return BottomNavigationBarItem(
              icon: Transform.translate(
                offset: Offset(0, 6.h),
                child: Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber,
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 30.sp),
                ),
              ),
              label: '',
            );
          }

          // All other icons including Mutation & Menu
          return BottomNavigationBarItem(
            icon: Image.asset(
              icons[index],
              height: 26.h, // Consistent height for all icons
              color: currentIndex == index
                  ? Colors.lightBlueAccent
                  : Colors.white,
            ),
            label: labels[index],
          );
        }),
      ),
    );
  }
}
