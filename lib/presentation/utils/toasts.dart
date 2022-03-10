import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:phrase_of_the_day/presentation/utils/app_colors.dart';

class Toast {
  void showErrorToast(String message) {
    _showToast(const Key('errorToast'), message, AppColors.error);
  }

  static _showToast(Key? key, String message, Color color,
      {bool showCloseButton = false}) {
    BotToast.showCustomNotification(
      align: Alignment.topCenter,
      duration: Duration(milliseconds: showCloseButton ? 5000 : 3500),
      toastBuilder: (cancel) {
        return SizedBox(
          key: key,
          width: double.infinity,
          child: Material(
            color: color,
            child: ListTile(
              dense: true,
              title: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              trailing: showCloseButton
                  ? IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: cancel,
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
