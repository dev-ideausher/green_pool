import 'package:flutter/material.dart';

/// FloatingNavBarItem
///
/// [FloatingNavbarItem] Base class for the bottom navigation bar items
class FloatingNavBarItem {
  /// IconData to display on the navbar e.g. Icons.home
  String? svg;

  /// Title can used instead of the dot indicator
  String title;

  bool useImageIcon;

  ImageIcon? icon;
  final GestureTapCallback? onTap;

  /// The page that corresponds to this item
  Widget page;

  FloatingNavBarItem({
    this.svg,
    this.useImageIcon = false,
    this.icon,
    this.onTap,
    required this.title,
    required this.page,
  });
}
