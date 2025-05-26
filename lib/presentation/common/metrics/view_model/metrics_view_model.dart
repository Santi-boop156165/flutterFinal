import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../main.dart';
import '../../core/services/text_to_speech_service.dart';
import '../../location/view_model/location_view_model.dart';
import '../../timer/viewmodel/timer_view_model.dart';
import 'state/metrics_state.dart';


final metricsViewModelProvider =
    StateNotifierProvider.autoDispose<MetricsViewModel, MetricsState>(
  (ref) => MetricsViewModel(ref.container),
);

class MetricsViewModel extends StateNotifier<MetricsState> {
  final ProviderContainer _container;
  late final TextToSpeechService textToSpeech;

  MetricsViewModel(this._container) : super(MetricsState.initial()) {
    textToSpeech = _container.read(textToSpeechService);
  }

  Future<void> updateMetrics() async {
    final location = _container.read(locationViewModelProvider);
    final timer = _container.read(timerViewModelProvider.notifier);
    final timerState = _container.read(timerViewModelProvider);

    final lastDistanceInteger = state.distance.toInt();

    final distance = state.distance +
        distanceInKmBetweenCoordinates(
          location.lastPosition?.latitude,
          location.lastPosition?.longitude,
          location.currentPosition?.latitude,
          location.currentPosition?.longitude,
        );

    final globalSpeed = distance / (timer.getTimerInMs() / 3600000);

    state = state.copyWith(distance: distance, globalSpeed: globalSpeed);

    final newDistanceInteger = state.distance.toInt();
    if (newDistanceInteger != lastDistanceInteger) {
      final l10nConf = await _container.read(myAppProvider).getLocalizedConf();

      var textToSay = StringBuffer();

      textToSay.write("$newDistanceInteger ${l10nConf.kilometers}.");

      var duration = StringBuffer();
      if (timerState.hours != 0) {
        duration.write("${timerState.hours} ${l10nConf.hours}");
      }
      if (timerState.minutes != 0) {
        duration.write("${timerState.minutes} ${l10nConf.minutes}");
      }
      if (timerState.seconds != 0) {
        duration.write("${timerState.seconds} ${l10nConf.seconds}");
      }

      textToSay.write('${l10nConf.duration}: $duration.');

      String speedStr = state.globalSpeed.toStringAsFixed(2);
      String km = speedStr.split('.')[0];
      String meters = speedStr.split('.')[1];

      textToSay.write(
          "${l10nConf.speed}: $km,$meters ${l10nConf.kilometers} ${l10nConf.per} ${l10nConf.hours}.");

      await textToSpeech.say(textToSay.toString());
    }
  }

  /// Resets the metrics state to its initial values.
  void reset() {
    state = MetricsState.initial();
  }

  /// Converts degrees to radians.
  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  /// Calculates the distance in kilometers between two sets of coordinates.
  double distanceInKmBetweenCoordinates(
    double? lat1,
    double? lon1,
    double? lat2,
    double? lon2,
  ) {
    const earthRadiusKm = 6371.0;

    final dLat = degreesToRadians(lat2! - lat1!);
    final dLon = degreesToRadians(lon2! - lon1!);

    lat1 = degreesToRadians(lat1);
    lat2 = degreesToRadians(lat2);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }
}
