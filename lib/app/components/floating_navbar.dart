library floating_navbar;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../services/text_style_util.dart';
import 'floating_navbar_item.dart';

// ignore: must_be_immutable
class FloatingNavBar extends StatefulWidget {
  /// FloatingNavBar
  ///
  /// [FloatingNavbar] Base class for the bottom navigation bar

  /// The current page index
  int index;

  /// The items to be displayed on the navbar
  List<FloatingNavBarItem> items;

  /// The color of the navbar card
  Color color;

  /// The color of unselected page icons
  Color unselectedIconColor;

  /// The color of selected page icons
  Color selectedIconColor;

  /// The horizontal padding between the navbar card and the page
  double horizontalPadding;

  /// Allow haptic feedback on page change
  bool hapticFeedback;

  /// The border radius of the navbar card
  double borderRadius;

  /// The width of the navbar card
  double? cardWidth;

  /// Make use of titles/labels instead of the dot indicator
  bool showTitle;

  bool resizeToAvoidBottomInset;
  PageController pageController;

  FloatingNavBar({
    super.key,
    this.index = 0,
    this.borderRadius = 15.0,
    this.cardWidth,
    this.showTitle = false,
    this.selectedIconColor = Colors.white,
    this.unselectedIconColor = Colors.white,
    this.resizeToAvoidBottomInset = false,
    required this.pageController,
    required this.horizontalPadding,
    required this.items,
    required this.color,
    required this.hapticFeedback,
  })  : assert(items.length > 1),
        assert(items.length <= 5);

  @override
  _FloatingNavBarState createState() {
    return _FloatingNavBarState();
  }

  PageController getCurrentState() {
    return pageController;
  }
}

class _FloatingNavBarState extends State<FloatingNavBar> {
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = widget.pageController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: widget.items.map((item) => item.page).toList(),
        onPageChanged: (index) => _changePage(index),
      ),
      bottomSheet: Container(
        color: ColorUtil.kWhiteColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(thickness: 0.2.kh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _widgetsBuilder(widget.items, widget.hapticFeedback),
            ),
            24.kheightBox,
          ],
        ),
      ),
    );
  }

  /// [_floatingNavBarItem] will build and return a [FloatingNavBar] item widget
  Widget _floatingNavBarItem(
      FloatingNavBarItem item, int index, bool hapticFeedback) {
    // If showTitle is set to true then no [FloatingNavBarItem] can have no title
    if (widget.showTitle && item.title.isEmpty) {
      throw Exception(
          'Show title set to true: Missing FloatingNavBarItem title!');
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          radius: 24.kh,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            // If haptic feedback is set to true then use mediumImpact on FloatingNavBarItem tap
            if (hapticFeedback == true) {
              HapticFeedback.mediumImpact();
            }
            _changePage(index);
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            width: 50,
            child: item.useImageIcon
                ? item.icon
                : widget.index == index
                    ? SvgPicture.asset(
                        item.svg!,
                        height: 24.kh,
                        width: 24.kh,
                        color: widget.index == index
                            ? widget.selectedIconColor
                            : widget.unselectedIconColor,
                      )
                    : SvgPicture.asset(
                        item.svg!,
                        height: 24.kh,
                        width: 24.kh,
                        color: widget.index == index
                            ? widget.selectedIconColor
                            : widget.unselectedIconColor,
                      ),
          ),
        ),
        AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            child: /*widget.index == index
              ? */
                Text(
              item.title,
              style: TextStyleUtil.k12Regular(
                fontWeight: FontWeight.w500,
                color: widget.index == index
                    ? ColorUtil.kPrimary01
                    : ColorUtil.kSecondary01,
              ),
            )
            /* : const SizedBox.shrink(),*/
            )
      ],
    );
  }

  /// [_widgetsBuilder] adds widgets from [_floatingNavBarItem] into a List<Widget> and returns the list
  List<Widget> _widgetsBuilder(
      List<FloatingNavBarItem> items, bool hapticFeedback) {
    List<Widget> floatingNavBarItems = [];
    for (int i = 0; i < items.length; i++) {
      Widget item = _floatingNavBarItem(items[i], i, hapticFeedback);
      floatingNavBarItems.add(item);
    }
    return floatingNavBarItems;
  }

  /// [_changePage] changes selected page index so as to change the page being currently viewed by the user
  _changePage(index) {
    FocusScope.of(context).unfocus();
    _pageController!.jumpToPage(index);
    setState(() {
      widget.index = index;
    });
  }
}
