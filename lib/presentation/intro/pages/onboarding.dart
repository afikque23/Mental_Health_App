import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mental_health_app/presentation/auth/pages/login_page.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
          color: Colors.white),
      titlePadding: EdgeInsets.only(top: 95, bottom: 40),
    );
    return IntroductionScreen(
      globalBackgroundColor: const Color(0xff68B39F),
      pages: [
        PageViewModel(
          title: "Selamat datang di [MentalHealth.care]! ",
          bodyWidget: _buildBody(
            AppImages.onboarding1,
            'Kami disini mendukung dan menjaga kesehatan mental anda.',
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Jadikan Membaca Sebagai Kebiasaan",
          bodyWidget: _buildBody(
            AppImages.onboarding2,
            'Dengan membaca, Anda akan menemukan cara baru memahami dan mengelola perasaan.',
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Berpikir Positif",
          bodyWidget: _buildBody(
            AppImages.onboarding3,
            'Pikiran yang positif, akan membuat perubahan suasana hati dan cara menghadapi tantangan.',
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      showSkipButton: false,
      showNextButton: true,
      showDoneButton: true,
      showBackButton: true,
      back: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Center(
              child: Icon(Icons.arrow_back_ios,
                  color: Color(0xff68B39F), size: 24)),
        ),
      ),
      next: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Center(
            child: Icon(Icons.arrow_forward_ios,
                color: Color(0xff68B39F), size: 24)),
      ),
      skip: Container(
          width: 95,
          height: 35,
          padding: const EdgeInsets.symmetric(),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff68B39F), width: 1),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: const Center(
            child: Text('Lewati',
                style: TextStyle(
                  color: Color(0xff68B39F),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                )),
          )),
      done: Container(
          width: 95,
          height: 35,
          padding: const EdgeInsets.symmetric(),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff68B39F), width: 1),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: const Center(
            child: Text('Selesai',
                style: TextStyle(
                  color: Color(0xff68B39F),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                )),
          )),
      dotsDecorator: const DotsDecorator(
          size: Size(10, 10),
          color: Color(0xffD9D9D9),
          activeSize: Size(22, 10),
          activeColor: Color(0xff2D6974),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)))),
    );
  }
}

_buildBody(String image, String text) {
  return Column(children: [
    Image.asset(image, width: 350),
    const SizedBox(
      height: 20,
    ),
    Text(
      text,
      style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          color: Colors.white),
      textAlign: TextAlign.center,
    )
  ]);
}