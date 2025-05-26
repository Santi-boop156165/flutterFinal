import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../viewmodel/timer_view_model.dart';
import 'timer_text.dart';

class TimerTextSized extends HookConsumerWidget {
  const TimerTextSized({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timerViewModelProvider);
    final timerViewModel = ref.watch(timerViewModelProvider.notifier);

    return const Column(
      children: <Widget>[
        SizedBox(
          height: 125,
          child: Center(
            child: TimerText(),
          ),
        )
      ],
    );
  }
}
