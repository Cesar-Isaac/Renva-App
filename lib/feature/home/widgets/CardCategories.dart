import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/style/repo.dart';

class Cardcategories extends StatelessWidget {
  final String service;
  final String explain_service;
  final Widget pictureSvg;
  Cardcategories({
    super.key,
    required this.service,
    required this.explain_service,
    required this.pictureSvg,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25.8, sigmaY: 25.8),
        child: Container(
          height: 80,
          width: 160,
          decoration: BoxDecoration(
            color: StyleRepo.blue,
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFF),
                Color(0x26FFFFFF),
                Color(0x26FFFFFF),
                Color(0xFFFFFF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              pictureSvg,
         

              const SizedBox(height: 10),
              Expanded(
                child: Text(
                  service,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  explain_service,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
