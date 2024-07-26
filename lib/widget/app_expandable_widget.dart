/*
 * *
 *  * app_expandable_widget.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/26/2024, 19:05
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/26/2024, 19:05
 *
 */

import 'dart:math';

import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:quranku/common/styles.dart';

class AppExpandableWidget extends StatelessWidget {
  const AppExpandableWidget({
    super.key,
    required this.title,
    required this.headerColor,
    this.backgroundColor,
    required this.child,
    this.initiallyExpanded,
  });

  final String title;
  final Color headerColor;
  final Color? backgroundColor;
  final Widget child;
  final bool? initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    dynamic Function({bool animated})? onTap;
    return Card(
      // color: backgroundColor ?? AppColor.silver.w10,
      color: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        splashColor: AppColor.secondary,
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          if (onTap != null) {
            onTap!(animated: true);
          }
        },
        child: ExpansionWidget(
          initiallyExpanded: initiallyExpanded ?? false,
          titleBuilder: (animVal, _, expanded, toggle) {
            onTap = toggle;
            return Stack(
              children: [
                Positioned.fill(
                  // child: Opacity(
                  //   opacity: 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: headerColor,
                      borderRadius: BorderRadius.vertical(
                        top: const Radius.circular(16),
                        bottom:
                            expanded ? Radius.zero : const Radius.circular(16),
                      ),
                    ),
                  ),
                  // ),
                ),
                if (expanded) const SizedBox(height: 64),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  color: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(12, 24, 12, expanded ? 0 : 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle: pi * animVal,
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          content: child,
        ),
      ),
    );
  }
}
