import 'package:flutter/material.dart';
import 'package:emprestapro/common/models/consumer_model.dart';

class AddConsumerController extends ChangeNotifier {
  final List<ConsumerModel> _consumers = [];

  List<ConsumerModel> get consumers => _consumers;

  void addConsumer(ConsumerModel consumer) {
    _consumers.add(consumer);
    notifyListeners(); // Notifica o estado de mudança
  }
}
