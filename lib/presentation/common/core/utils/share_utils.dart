import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hello_world/l10n/app_localizations.dart';

import 'package:share_plus/share_plus.dart';

class ShareUtils {
  static Future<void> shareImage(BuildContext context, Uint8List image) async {
    await Share.shareXFiles([
      XFile.fromData(
        image,
        name: 'run_flutter_run',
        mimeType: 'image/png',
      )
    ]);
  }

  /// Display a snackbar when share image failed
  static void showShareFailureSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.share_failed),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: AppLocalizations.of(context)!.close,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
