import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:yao_hariraya/yao_home.dart';

class YaoSp extends StatefulWidget {
  const YaoSp({super.key});

  @override
  State<YaoSp> createState() => _YaoSpState();
}

class _YaoSpState extends State<YaoSp> {
  String myText = "Di hari yang suci ini,";
  String myText2 = "mari kita bersyukur atas karunia dan rahmat Allah.";

  String myText3 =
      "Semoga kerendahan hati dan keikhlasan selalu menyertai kita dalam menjalani hidup.";
  String myText4 =
      "Selamat Hari Raya Idul Fitri 1444H, mohon maaf lahir dan batin";
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(myText,
                    speed: const Duration(milliseconds: 100),
                    textAlign: TextAlign.center,
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 18.0)),
                TypewriterAnimatedText(
                  myText2,
                  speed: const Duration(milliseconds: 100),
                  textAlign: TextAlign.center,
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                TypewriterAnimatedText(
                  myText3,
                  speed: const Duration(milliseconds: 100),
                  textAlign: TextAlign.center,
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                TypewriterAnimatedText(
                  myText4,
                  speed: const Duration(milliseconds: 100),
                  textAlign: TextAlign.center,
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const YaoHome()));
              },
              child: const Text("Get Started"),
            ),
          )
        ],
      ),
    );
  }
}
