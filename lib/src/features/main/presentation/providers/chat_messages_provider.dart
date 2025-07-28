import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/logger/logger.dart';
import 'package:xchat/src/features/main/data/dto/chat_message_dto.dart';
import 'package:xchat/src/features/main/domain/model/chat_message.dart';
import 'package:xchat/src/global_providers/global_providers.dart';

part 'chat_messages_provider.g.dart';

@riverpod
Stream<List<ChatMessage>> chatMessages(Ref ref, int roomId) {
  final service = ref.watch(webSocketServiceProvider);

  final streamController = StreamController<List<ChatMessage>>();
  final allMessages = <ChatMessage>[];

  streamController.add(allMessages);

  final sub = service.messages.listen((data) {
    logger.d(data);
    final newMessages = ChatMessageDto.parse(data).reversed;
    allMessages.insertAll(0, newMessages);
    streamController.add(List.from(allMessages));
  });

  ref.onDispose(() {
    sub.cancel();
    service.disconnect();
    streamController.close();
  });

  return streamController.stream;
}
