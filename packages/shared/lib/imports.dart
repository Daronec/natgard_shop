/// All packages and widgets for project

/// Packages
export 'dart:async';
export 'dart:math';
export 'package:flutter/material.dart';
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:go_router/go_router.dart';
export 'package:provider/provider.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_spinkit/flutter_spinkit.dart';
export 'package:flutter/services.dart';
export 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:dio/dio.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:fluttertoast/fluttertoast.dart';
export 'package:flutter/foundation.dart';
export 'package:path_provider/path_provider.dart';
export 'package:uuid/uuid.dart';
export 'package:image_picker/image_picker.dart';
export 'package:flutter_persistence/flutter_persistence.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:permission_handler/permission_handler.dart';
export 'package:device_info_plus/device_info_plus.dart';
export 'package:carousel_slider/carousel_slider.dart';
export 'package:flutter_local_notifications/flutter_local_notifications.dart';
export 'package:nested/nested.dart';
export 'package:flutter_secure_storage/flutter_secure_storage.dart';
export 'package:fresh_dio/fresh_dio.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:union_state/union_state.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:flutter_file_uploader/flutter_file_uploader.dart';


/// Project files
export 'package:shared/source/constants.dart';
export 'package:shared/styles/app_theme.dart';
export 'package:shared/source/functions.dart';
export 'package:shared/styles/app_colors.dart';
export 'package:shared/widgets/text_field/app_text_field.dart';
export 'package:shared/widgets/input_field.dart';
export 'package:shared/widgets/buttons/app_button.dart';
export 'package:shared/source/endpoints.dart';
export 'package:shared/source/preferences.dart';
export 'package:shared/source/keys.dart';
export 'package:shared/widgets/custom_appbar.dart';
export 'package:shared/source/extensions.dart';
export 'package:shared/widgets/restart_widget.dart';
export 'package:shared/widgets/text_field/helpers/types.dart';
export 'package:shared/widgets/progress_indicator.dart';
export 'package:shared/widgets/avatar_widget.dart';
export 'package:shared/widgets/image_widget.dart';
export 'package:shared/widgets/app_radio.dart';
export 'package:shared/widgets/splash_screen.dart';
export 'package:shared/source/notifications_service.dart';
export 'package:shared/source/di_scope.dart';
export 'package:shared/source/disposable_object/disposable_object.dart';
export 'package:shared/gen/assets.gen.dart';
export 'package:shared/data/persistence/storage/tokens_storage/token_storage_impl.dart';
export 'package:shared/data/persistence/storage/tokens_storage/auth_token_pair.dart';
export 'package:shared/data/dio/dio_client.dart';
export 'package:shared/data/config/app_config.dart';
export 'package:shared/data/dio/interceptors.dart';
export 'package:shared/widgets/web_view_widget.dart';
export 'package:shared/core/architecture/domain/entity/request_operation.dart';
export 'package:shared/core/architecture/presentation/base_model.dart';
export 'package:shared/core/architecture/data/converter/converter.dart';

/// Models
export 'package:shared/data/models/user_model/user_model.dart';
export 'package:shared/data/models/video_model/video_model.dart';
export 'package:shared/data/models/audio_dto/audio_dto.dart';

/// Entities
export 'package:shared/data/entity/navbar_entity.dart';

/// Repositories
export 'package:shared/data/i_repositories/i_auth_repository.dart';
export 'package:shared/data/i_repositories/i_you_tube_repository.dart';
export 'package:shared/data/repositories/you_tube_repository.dart';
export 'package:shared/data/repositories/auth_repository.dart';
export 'package:shared/data/i_repositories/i_cloud_base_repository.dart';
export 'package:shared/data/repositories/cloud_base_repository.dart';
export 'package:shared/data/repositories/firebase_storage_repository.dart';
export 'package:shared/data/i_repositories/i_firebase_storage_repository.dart';

/// Services
export 'package:shared/data/services/auth_service/auth_service.dart';
export 'package:shared/data/services/you_tube_service/you_tube_service.dart';

/// Enum
export 'package:shared/source/enum.dart';
