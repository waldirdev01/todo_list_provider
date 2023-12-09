import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/notifier/default_changer_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  final DefaultChangNotifier changeNotifier;
  DefaultListenerNotifier({required this.changeNotifier});

  void listener(
      {required BuildContext context,
      required SuccessVoidCallback successCallBack,
      DefaultErrorCallback? errorCallback}) {
    changeNotifier.addListener(() {
      if (changeNotifier.isLoading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }
      if (changeNotifier.hasError) {
        if (errorCallback != null) {
          errorCallback(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSuccess) {
        successCallBack(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallback = void Function(DefaultChangNotifier changeNotifier,
    DefaultListenerNotifier listenerNotifier);

typedef DefaultErrorCallback = void Function(
    DefaultChangNotifier changeNotifier,
    DefaultListenerNotifier listenerNotifier);
