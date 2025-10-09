part of '../mentorx_ui.dart';

extension MentorXExceptionExtenions on MentorXException {
  String get presentationMessage =>
      message ?? t.exceptions[code] ?? t.exceptions['unknown'];

  void showAsToast() {
    MentorXUI.showToast(message: presentationMessage);
  }
}
