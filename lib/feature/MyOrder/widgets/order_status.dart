import 'package:easy_localization/easy_localization.dart';
import 'package:renvo_app/core/localization/strings.dart';

enum StatusOrder {
  waiting,
  processing,
  complete,
  cancelled;

  String get trValue {
    switch (this) {
      case StatusOrder.waiting:
        return tr(LocaleKeys.pending);
      case StatusOrder.processing:
        return tr(LocaleKeys.underway);
      case StatusOrder.complete:
        return tr(LocaleKeys.complete);
      case StatusOrder.cancelled:
        return tr(LocaleKeys.canceled);
    }
  }

  String get statusValue {
    switch (this) {
      case StatusOrder.waiting:
        return "waiting";
      case StatusOrder.processing:
        return "processing";
      case StatusOrder.complete:
        return "completed";
      case StatusOrder.cancelled:
        return "cancelled";
    }
  }

  int get flaggedValue {
    switch (this) {
      case StatusOrder.waiting:
        return 1;
      case StatusOrder.processing:
        return 2;
      case StatusOrder.complete:
        return 3;
      case StatusOrder.cancelled:
        return 4;
    }
  }
}

