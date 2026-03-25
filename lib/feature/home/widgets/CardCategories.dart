import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/style/repo.dart';

class Cardcategories extends StatelessWidget {
  final String service;
  final String explain_service;
  final String iconPath;
  Cardcategories({
    super.key,
    required this.service,
    required this.explain_service,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 10),
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
              SvgPicture.asset(
                iconPath,
                width: 36,
                height: 36,

              ),


              const SizedBox(height: 20),
              Text(
                service,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    explain_service,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
