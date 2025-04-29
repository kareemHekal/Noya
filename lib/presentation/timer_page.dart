import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/core/utils/text_style_manager.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late DateTime endTime;

  @override
  void initState() {
    super.initState();
    endTime = DateTime.now().add(const Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: Text(
          AppStrings.timer,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),

        ),
        backgroundColor: ColorManager.white,
        elevation: 0,
      ),
      body: Center(
        child: Card(
          color: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer, size: 48, color: ColorManager.brown),
                const SizedBox(height: 20),
                Text(
                  AppStrings.theyWillReciveYourConsultationIn,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.medium14.copyWith(color: ColorManager.black),
                ),
                const SizedBox(height: 20),
                TimerCountdown(
                  colonsTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  timeTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  format: CountDownTimerFormat.secondsOnly,
                  endTime: endTime,
                  onEnd: () {
                    Navigator.pop(context);
                    toastMessage(
                      message: AppStrings.theyResivedYourConsultationSuccessfully,
                      tybeMessage: TybeMessage.positive,
                    );
                  },
                ),
                const SizedBox(height: 10),
                const CircularProgressIndicator(color: ColorManager.ligthBrown),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
