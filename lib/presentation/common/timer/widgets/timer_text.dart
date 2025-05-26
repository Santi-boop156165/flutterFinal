import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../viewmodel/timer_view_model.dart';

class TimerText extends HookConsumerWidget {
  final int? timeInMs;

  const TimerText({super.key, this.timeInMs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timerViewModelProvider);
    final timerViewModel = ref.watch(timerViewModelProvider.notifier);

    const TextStyle timerTextStyle =
        TextStyle(fontSize: 60.0, fontFamily: "Open Sans");

    return Text(
      timeInMs != null
          ? timerViewModel.getFormattedTime(timeInMs)
          : timerViewModel.getFormattedTime(),
      style: timerTextStyle,
    );
  }
}
