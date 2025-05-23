import 'package:app/extensions/app_localizations.dart';
import 'package:flutter/material.dart';

enum ApiMessages {
  invalidRequestParameters,
  invalidCredentials,
  invalidResponse,
  noInternetConnection,
  unauthorizedAccess,
  userExists,
  unknownError;

  static ApiMessages fromJson(String value) {
    switch (value) {
      case 'INVALID_REQUEST_PARAMETERS':
        return invalidRequestParameters;
      case 'INVALID_CREDENTIALS':
        return invalidCredentials;
      case 'NO_INTERNET_CONNECTION':
        return noInternetConnection;
      case 'UNAUTHORIZED_ACCESS':
        return unauthorizedAccess;
      case 'USER_EXISTS':
        return userExists;
      default:
        return unknownError;
    }
  }

  String asString(BuildContext context) => switch (this) {
        invalidRequestParameters => context.l10n.api_invalid_request_parameters,
        invalidCredentials => context.l10n.api_invalid_credentials,
        invalidResponse => context.l10n.api_invalid_response,
        unknownError => context.l10n.api_unknown_error,
        noInternetConnection => context.l10n.api_no_internet_connection,
        unauthorizedAccess => context.l10n.api_unauthorized_access,
        userExists => context.l10n.api_user_exists,
      };
}
