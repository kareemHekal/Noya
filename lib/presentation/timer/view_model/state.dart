abstract class TimerState {}

class TimerInitial extends TimerState {}

class TimerLoading extends TimerState {}

class TimerRunning extends TimerState {
  final DateTime endTime;
  TimerRunning(this.endTime);
}

class TimerFinished extends TimerState {}
class TimerIdle extends TimerState {}
