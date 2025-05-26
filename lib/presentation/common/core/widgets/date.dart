import 'package:flutter/material.dart';
import 'package:hello_world/l10n/app_localizations.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class Date extends HookConsumerWidget {
  final DateTime date;

  const Date({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context)!;
    final formattedDate = DateFormat('dd/MM/yyyy').format(date);

    final formattedTime = DateFormat('HH:mm').format(date);

    return Text(
      '${appLocalizations.date_pronoun} $formattedDate ${appLocalizations.hours_pronoun} $formattedTime',
    );
  }
}
