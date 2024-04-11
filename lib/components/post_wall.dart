import 'package:flutter/material.dart';
import 'package:identicare/components/like_button.dart';

class PostWall extends StatefulWidget {
  final String message;
  final String user;
  const PostWall({
    super.key,
    required this.message,
    required this.user,
  });

  @override
  State<PostWall> createState() => _PostWallState();
}

class _PostWallState extends State<PostWall> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              // pic
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black12),
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.user),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.message),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: LikeButton(
                  isLiked: true,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
