part of '../mentorx_ui.dart';


extension StringExtensions on String {
  void showAsToast() {
    MentorXUI.showToast(message: this);
  }
}
