import 'package:flutter/material.dart';
import 'package:shop_final/constants/constants.dart';
import 'package:shop_final/functions/fucnctions.dart';
import 'package:shop_final/screens/login_screen.dart';
import 'package:shop_final/reusable_components/reusable_components.dart';
import 'package:shop_final/shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController controller = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 15,
        title: Row(
          children: [
            TextWith2Lan(
              enLan: enLan,
              ar: 'عربي',
              en: 'English',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Switch(
              value: enLan,
              onChanged: (value) {
                setState(() {
                  enLan = value;
                  CasheHelper.SaveData(key: 'enLan', value: value);
                  print(enLan);
                });
              },
            ),
          ],
        ),
        actions: [
          BuildTextButton(
            labelEn: 'Skip',
            labelAr: 'تخطي',
            onPressed: () {
              CasheHelper.SaveData(key: 'onBoarding', value: true)
                  .then((value) {
                if (value) {
                  NavigateAndFinish(LoginScreen(), context);
                }
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == items.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: controller,
                itemBuilder: (context, index) => OnBoardingItem(items[index]),
                itemCount: items.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SmoothPageIndicator(
              controller: controller,
              count: items.length,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isLast == true) {
            CasheHelper.SaveData(key: 'onBoarding', value: true).then((value) {
              if (value) {
                NavigateAndFinish(LoginScreen(), context);
              }
            });
          } else {
            controller.nextPage(
                duration: Duration(milliseconds: 400), curve: Curves.linear);
          }
        },
        child: Icon(
          Icons.arrow_forward_ios_outlined,
        ),
      ),
    );
  }
}

class BoardingModel {
  late String image;

  late String titleEn;

  late String bodyEn;
  late String titleAr;

  late String bodyAr;

  BoardingModel({
    required this.image,
    required this.titleEn,
    required this.bodyEn,
    required this.titleAr,
    required this.bodyAr,
  });
}

List<BoardingModel> items = [
  BoardingModel(
    image: 'assets/135043-bag-smiling-shopping-girl-holding.png',
    titleEn: 'On Boarding Title 1',
    bodyEn: 'On Boarding Body 1',
    titleAr: 'النص العلوي رقم 1',
    bodyAr: 'النص السفلي رقم 1',
  ),
  BoardingModel(
    image:
        'assets/73435-shopping-illustration-cart-stock-free-download-png-hq.png',
    titleEn: 'On Boarding Title 2',
    bodyEn: 'On Boarding Body 2',
    titleAr: 'النص العلوي رقم2 ',
    bodyAr: 'النص السفلي رقم 2',
  ),
  BoardingModel(
    image: 'assets/134899-bag-girl-shopping-holding-online.png',
    titleEn: 'On Boarding Title 3',
    bodyEn: 'On Boarding Body 3',
    titleAr: 'النص العلوي رقم 3',
    bodyAr: 'النص السفلي رقم 3',
  ),
];

OnBoardingItem(BoardingModel model) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset(model.image)),
        SizedBox(
          height: 30,
        ),
        TextWith2Lan(
          enLan: enLan,
          ar: model.titleAr,
          en: model.titleEn,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextWith2Lan(
          enLan: enLan,
          ar: model.bodyAr,
          en: model.bodyEn,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
