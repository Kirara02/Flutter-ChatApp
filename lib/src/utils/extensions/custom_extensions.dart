import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:xchat/src/constants/colors.dart';
import 'package:xchat/src/constants/app_sizes.dart';
import 'package:xchat/src/core/network/response/api_response.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/data/dto/login_dto.dart';
import 'package:xchat/src/features/auth/data/dto/refresh_dto.dart';
import 'package:xchat/src/features/auth/data/dto/user_dto.dart';
import 'package:xchat/src/features/auth/domain/model/login_result.dart';
import 'package:xchat/src/features/auth/domain/model/refresh_result.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/main/data/dto/chat_room_dto.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../widgets/emoticons.dart';
import '../app_utils.dart';
import '../toast/toast.dart';

part 'custom_extensions/async_value_extensions.dart';
part 'custom_extensions/bool_extensions.dart';
part 'custom_extensions/context_extensions.dart';
part 'custom_extensions/date_time_extensions.dart';
part 'custom_extensions/double_extensions.dart';
part 'custom_extensions/int_extensions.dart';
part 'custom_extensions/iterable_extensions.dart';
part 'custom_extensions/map_extensions.dart';
part 'custom_extensions/string_extensions.dart';
part 'custom_extensions/global_extensions.dart';
part 'custom_extensions/dto_to_model_mapper_extensions.dart';
