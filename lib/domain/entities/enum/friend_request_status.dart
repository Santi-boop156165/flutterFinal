import 'package:hello_world/l10n/app_localizations.dart';


enum FriendRequestStatus { pending, accepted, rejected, canceled, noDisplay }

extension FriendRequestStatusExtension on FriendRequestStatus {
  String getTranslatedName(AppLocalizations localization) {
    switch (this) {
      case FriendRequestStatus.pending:
        return localization.pending;
      case FriendRequestStatus.accepted:
        return localization.accepted;
      case FriendRequestStatus.rejected:
        return localization.rejected;
      case FriendRequestStatus.canceled:
        return localization.canceled;
      case FriendRequestStatus.noDisplay:
        return '';
      default:
        return '';
    }
  }
}
