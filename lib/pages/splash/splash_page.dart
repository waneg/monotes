import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monotes/routes/app_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(33, 33, 33, 1),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
              top: 200,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: SvgPicture.asset(
                      "assets/logo/logo.svg",
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "记账全能王",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 28),
                  ),
                  const Text(
                    "全能智能记账引领者",
                    style: TextStyle(
                        color: Color.fromRGBO(239, 239, 239, 1),
                        decoration: TextDecoration.none,
                        fontSize: 18),
                  )
                ],
              )),
          Positioned(
              bottom: 100,
              child: CupertinoButton(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
                child: const Text("点击进入"),
                onPressed: () {
                  Get.toNamed(Routes.HOME);
                },
              ))
        ],
      ),
    );
  }
}
