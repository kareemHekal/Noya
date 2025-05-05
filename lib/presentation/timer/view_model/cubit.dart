import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/presentation/timer/view_model/state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial());

  Future<void> initTimer() async {
    emit(TimerLoading());
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getInt('end_time');
    final now = DateTime.now();

    if (saved != null) {
      final endTime = DateTime.fromMillisecondsSinceEpoch(saved);
      if (now.isAfter(endTime)) {
        emit(TimerFinished());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          toastMessage(
            message: AppStrings.theyResivedYourConsultationSuccessfully,
            tybeMessage: TybeMessage.positive,
          );
        });
        await clearTimer();
      } else {
        emit(TimerRunning(endTime));
        startTimer();
      }
    } else {
      final newEndTime = now.add(const Duration(seconds: 60));
      await prefs.setInt('end_time', newEndTime.millisecondsSinceEpoch);
      emit(TimerRunning(newEndTime));
      startTimer();
    }
  }

  Future<void> clearTimer() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('end_time');
  }

  void startTimer() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getInt('end_time');

    if (saved != null) {
      final now = DateTime.now();
      final endTime = DateTime.fromMillisecondsSinceEpoch(saved);
      final remaining = endTime.difference(now);

      if (remaining.isNegative) {
        await clearTimer();
        toastMessage(
          message: AppStrings.theyResivedYourConsultationSuccessfully,
          tybeMessage: TybeMessage.positive,
        );
        emit(TimerFinished());
      } else {
        Future.delayed(remaining, () {
          toastMessage(
            message: AppStrings.theyResivedYourConsultationSuccessfully,
            tybeMessage: TybeMessage.positive,
          );
          clearTimer();
          emit(TimerFinished());
        });
      }
    }
  }
}
