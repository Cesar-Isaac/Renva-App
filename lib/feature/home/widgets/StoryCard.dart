import 'package:flutter/material.dart';


import '../../../core/demo/media.dart';
import '../../../core/style/repo.dart';
import '../../../core/widgets/image.dart';

class StoryCard extends StatelessWidget {
  final int index;

  const StoryCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final imagePath = DemoMedia.getRandomImage4(index); 

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 250,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AppImage(
                path: imagePath,
                width: double.infinity,
                height: double.infinity,
                type: ImageType.CachedNetwork,
                fit: BoxFit.cover,
                errorWidget: Image.asset(
                  'assets/image/noInternet.png',
                  width: 24,
                  height: 24,
                  color: StyleRepo.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

