part of '../mentorx_ui.dart';

extension MentorXExceptionExtenions on MentorXException {
  String get presentationMessage =>
      message ?? t_ui.exceptions[code.name] ?? t_ui.exceptions['unknown'];

  void showAsToast() {
    MentorXUI.showToast(message: presentationMessage);
  }
}
