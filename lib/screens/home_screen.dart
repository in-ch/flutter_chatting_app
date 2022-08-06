import 'package:chatting_app/helper/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chatting_app/pages/pages.dart';
import 'package:chatting_app/widgets/widgets.dart';
import 'package:chatting_app/style/theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage(),
  ];

  final pageTitles = const ['Messages', 'Notifications', 'Calls', 'Contacts'];

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    pageIndex.addListener(() {});

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Text(value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
          },
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
              icon: Icons.search,
              onTap: () {
                print('TODO search');
              }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Avatar.small(url: Helpers.randomPictureUrl()),
          )
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          }),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavigationBarItems(
              index: 0,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 0),
              lable: 'Messages',
              icon: CupertinoIcons.bubble_left_bubble_right_fill),
          _NavigationBarItems(
              index: 1,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 1),
              lable: 'Notifications',
              icon: CupertinoIcons.bell_solid),
          _NavigationBarItems(
              index: 2,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 2),
              lable: 'Calls',
              icon: CupertinoIcons.phone_fill),
          _NavigationBarItems(
              index: 3,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 3),
              lable: 'Contacts',
              icon: CupertinoIcons.person_2_fill),
        ],
      ),
    );
  }
}

class _NavigationBarItems extends StatelessWidget {
  const _NavigationBarItems(
      {Key? key,
      required this.lable,
      required this.icon,
      required this.index,
      this.isSelected = false,
      required this.onTap})
      : super(key: key);

  final String lable;
  final IconData icon;
  final int index;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        height: 70.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 20, color: isSelected ? AppColors.secondary : null),
            const SizedBox(height: 8),
            Text(lable,
                style: isSelected
                    ? const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary)
                    : const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
