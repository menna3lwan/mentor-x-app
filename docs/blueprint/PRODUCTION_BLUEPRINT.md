# PRODUCTION BLUEPRINT — Flutter Monorepo Architecture

> A complete, project-agnostic construction manual. Every `{{placeholder}}` is a value you replace with your own project-specific name. Every code template is compilable once placeholders are filled.

---

## TABLE OF CONTENTS

| Part | Patterns | Status |
|------|----------|--------|
| **Part 1** | 1. Workspace Root · 2. Domain Core · 3. HTTP Client · 4. Dio Repositories · 5. Mock Repositories | This file |
| **Part 2** | 6. Cache Repository · 7. Mock Data · 8. UI Kit | Say "continue" |
| **Part 3** | 9. App Shell · 10. Feature Modules | Say "continue" |
| **Part 4** | Master Build Order · Quick-Action Checklists | Say "continue" |

---

# PART 1 — PATTERNS 1-5

---

## PATTERN 1: WORKSPACE ROOT

### 1.1 Folder skeleton

```
{{project_root}}/
├── pubspec.yaml                  # Workspace root (NO runnable code here)
├── analysis_options.yaml
├── devtools_options.yaml
├── {{app_name}}/                 # The main Flutter app
│   ├── pubspec.yaml
│   ├── build.yaml
│   ├── dev.env
│   ├── makefile
│   ├── lib/
│   ├── android/
│   ├── ios/
│   └── assets/
└── packages/
    ├── clients/
    │   └── dio_http_client/
    ├── common/
    │   └── flutter_secure_storage_cache_repository/
    ├── {{project_name}}_core/     # Domain layer
    ├── {{project_name}}_ui/       # Shared UI library
    ├── {{project_name}}/          # Dio repositories
    │   ├── dio_authentication_repository/
    │   ├── dio_{{entity}}_repository/   # One per domain entity
    │   └── ...
    ├── mock/                      # Mock repositories
    │   ├── mock_authentication_repository/
    │   ├── mock_{{entity}}_repository/
    │   └── ...
    └── mock_data/                 # Centralized mock data
```

### 1.2 Root `pubspec.yaml`

```yaml
name: {{project_root_name}}
publish_to: none

environment:
  sdk: ^3.9.2

workspace:
  - {{app_name}}
  # Domain core
  - packages/{{project_name}}_core
  # UI kit
  - packages/{{project_name}}_ui
  # Clients
  - packages/clients/dio_http_client
  # Common
  - packages/common/flutter_secure_storage_cache_repository
  # Mock data
  - packages/mock_data
  # Dio repositories (one line per entity)
  - packages/{{project_name}}/dio_authentication_repository
  - packages/{{project_name}}/dio_{{entity_a}}_repository
  - packages/{{project_name}}/dio_{{entity_b}}_repository
  # Mock repositories (one line per entity)
  - packages/mock/mock_authentication_repository
  - packages/mock/mock_{{entity_a}}_repository
  - packages/mock/mock_{{entity_b}}_repository

dev_dependencies:
  melos: ^7.1.0

dependency_overrides:
  test_api: ^0.7.7
```

**Key rule**: Every package in the workspace MUST appear in this list. Dart 3.x native workspace resolution (`resolution: workspace`) replaces melos linking.

### 1.3 Root `analysis_options.yaml`

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    deprecated_member_use: ignore

formatter:
  trailing_commas: preserve
```

### 1.4 Root `devtools_options.yaml`

```yaml
description: This file stores settings for Dart & Flutter DevTools.
documentation: https://docs.flutter.dev/tools/devtools/extensions#configure-extension-enablement-states
extensions:
  - provider: true
```

---

## PATTERN 2: DOMAIN CORE (`{{project_name}}_core`)

The **single source of truth** for all domain types. Zero Flutter dependency. Zero implementation.

### 2.1 Package structure

```
packages/{{project_name}}_core/
├── pubspec.yaml
├── CHANGELOG.md
├── README.md
└── lib/
    └── {{project_name}}_core.dart    # Single library file, ALL others are `part`
        # Parts:
        # — Entities
        # — Repository interfaces
        # — Client interfaces
        # — Utils
        # — Extensions
        # — Constants
```

### 2.2 `pubspec.yaml`

```yaml
name: {{project_name}}_core
description: "Domain core: entities, repository interfaces, utils."
version: 0.0.1
publish_to: none

environment:
  sdk: ^3.9.2

resolution: workspace

dependencies:
  equatable: ^2.0.7
```

**Critical rule**: Only `equatable`. No Flutter. No Dio. No implementation libraries.

### 2.3 Barrel file (`{{project_name}}_core.dart`)

```dart
library;

// ——— Entities ———
part 'src/entities/user_entity.dart';
part 'src/entities/{{entity_a}}_entity.dart';
part 'src/entities/{{entity_b}}_entity.dart';

// ——— Repository Interfaces ———
part 'src/repositories/authentication_repository.dart';
part 'src/repositories/cache_repository.dart';
part 'src/repositories/{{entity_a}}_repository.dart';
part 'src/repositories/{{entity_b}}_repository.dart';

// ——— Client Interfaces ———
part 'src/clients/http_client.dart';

// ——— Utils ———
part 'src/utils/{{project_name}}_exception.dart';
part 'src/utils/{{project_name}}_logger.dart';
part 'src/utils/{{project_name}}_nullable_value.dart';
part 'src/utils/{{project_name}}_pagination_info.dart';

// ——— Extensions ———
part 'src/extensions/string_extensions.dart';

// ——— Constants ———
part 'src/constants/cache_keys.dart';
```

### 2.4 Entity template

```dart
part of '{{project_name}}_core.dart';

final class {{Entity}}Entity extends Equatable {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const {{Entity}}Entity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Placeholder for list displays and loading states
  static const placeholder = {{Entity}}Entity(
    id: '',
    name: '',
    createdAt: null,  // or DateTime(0)
    updatedAt: null,
  );

  {{Entity}}Entity copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return {{Entity}}Entity(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory {{Entity}}Entity.fromJson(Map<String, dynamic> json) {
    return {{Entity}}Entity(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt];
}
```

**Entity rules**:

- Always `final class`, always `extends Equatable`
- Always provide `copyWith()` — use `{{Project}}NullableValue<T>` wrapper for nullable fields
- Always provide `static const placeholder` for skeleton/loading states
- `fromJson` / `toJson` for serialization
- Use `part of` — entities are NOT standalone libraries

### 2.5 Generic exception system

```dart
part of '{{project_name}}_core.dart';

class {{Project}}Exception<T> extends Equatable implements Exception {
  final T? code;
  final String? message;

  const {{Project}}Exception({this.code, this.message});

  factory {{Project}}Exception.unknown({String? message}) =>
      {{Project}}Exception(message: message ?? 'Unknown error');

  @override
  List<Object?> get props => [code, message];
}
```

### 2.6 Repository interface template

```dart
part of '{{project_name}}_core.dart';

// Step 1: Define exception codes
enum {{Entity}}RepositoryExceptionCode {
  unknown,
  notFound,
  unauthorized,
  networkError,
  // add domain-specific codes
}

// Step 2: Typed exception
final class {{Entity}}RepositoryException
    extends {{Project}}Exception<{{Entity}}RepositoryExceptionCode> {
  const {{Entity}}RepositoryException({
    super.code,
    super.message,
  });
}

// Step 3: Abstract interface
abstract interface class {{Entity}}Repository {
  Future<void> initialize();

  Future<List<{{Entity}}Entity>> get{{Entity}}s({
    {{Project}}PaginationInfo? paginationInfo,
  });

  Future<{{Entity}}Entity> get{{Entity}}ById(String id);

  Future<{{Entity}}Entity> create{{Entity}}({{Entity}}Entity entity);

  Future<{{Entity}}Entity> update{{Entity}}({{Entity}}Entity entity);

  Future<void> delete{{Entity}}(String id);
}
```

**Repository interface rules**:

- Always `abstract interface class` (Dart 3 syntax)
- Always has `Future<void> initialize()` as first method
- Each repo has its own exception code enum + exception class
- Return domain entities, never models or JSON
- Accept `{{Project}}PaginationInfo` for paginated endpoints

### 2.7 HttpClient interface

```dart
part of '{{project_name}}_core.dart';

typedef HttpClientResponse = ({int statusCode, dynamic data});

abstract interface class HttpClient implements LocalizedClient {
  String? get accessToken;
  String? get userId;
  bool get isAuthenticated;

  Future<void> setAccessToken(String token);
  Future<void> setRefreshToken(String token);
  Future<void> clearTokens();

  Future<HttpClientResponse> get(String path,
      {Map<String, dynamic>? queryParameters});
  Future<HttpClientResponse> post(String path, {dynamic data});
  Future<HttpClientResponse> put(String path, {dynamic data});
  Future<HttpClientResponse> patch(String path, {dynamic data});
  Future<HttpClientResponse> delete(String path);
  Future<HttpClientResponse> postMultipart(String path,
      {required Map<String, dynamic> fields, required String fileFieldName,
       required String filePath});
}

abstract interface class LocalizedClient {
  String get languageCode;
  set languageCode(String code);
}
```

### 2.8 Utility classes

**NullableValue** (for `copyWith` with explicit null):

```dart
part of '{{project_name}}_core.dart';

final class {{Project}}NullableValue<T> {
  final T value;
  const {{Project}}NullableValue(this.value);
}
```

**PaginationInfo**:

```dart
part of '{{project_name}}_core.dart';

final class {{Project}}PaginationInfo extends Equatable {
  final int? limit;
  final String? cursor;

  const {{Project}}PaginationInfo({this.limit, this.cursor});

  @override
  List<Object?> get props => [limit, cursor];
}
```

**Logger**:

```dart
part of '{{project_name}}_core.dart';

final class {{Project}}Logger {
  final String tag;
  const {{Project}}Logger(this.tag);

  void debug(String message) => _log('DEBUG', message);
  void info(String message) => _log('INFO', message);
  void warning(String message) => _log('WARNING', message);
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log('ERROR', message);
    if (error != null) _log('ERROR', error.toString());
    if (stackTrace != null) _log('ERROR', stackTrace.toString());
  }

  void _log(String level, String message) {
    // ignore: avoid_print
    print('[$level] [$tag] $message');
  }
}
```

**CacheRepository interface**:

```dart
part of '{{project_name}}_core.dart';

abstract class CacheKeys {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const languageCode = 'language_code';
  static const onboarded = 'onboarded';
  static const userLocation = 'user_location';
  // add as needed
}

abstract interface class CacheRepository {
  Future<void> initialize();
  Future<String?> get(String key);
  Future<void> put(String key, String value);
  Future<void> delete(String key);
  Future<void> clear();
}
```

### 2.9 HttpClientRepository (abstract base for Dio repos)

```dart
part of '{{project_name}}_core.dart';

abstract class HttpClientRepository<T> {
  void handleHttpClientErrorResponse({
    required HttpClientResponse errorResponse,
    required T Function(int statusCode) codeFromStatusCode,
    String? message,
  }) {
    throw {{Project}}Exception<T>(
      code: codeFromStatusCode(errorResponse.statusCode),
      message: message ?? errorResponse.data?.toString(),
    );
  }
}
```

---

## PATTERN 3: HTTP CLIENT (`dio_http_client`)

### 3.1 Package structure

```
packages/clients/dio_http_client/
├── pubspec.yaml
└── lib/
    ├── dio_http_client.dart           # Barrel
    └── src/
        ├── dio_http_client.dart       # Implementation
        └── refresh_token_interceptor.dart
```

### 3.2 `pubspec.yaml`

```yaml
name: dio_http_client
description: "Dio implementation of HttpClient."
version: 0.0.1
publish_to: none

environment:
  sdk: ^3.9.2

resolution: workspace

dependencies:
  dio: ^5.9.0
  {{project_name}}_core:
    path: ../../{{project_name}}_core
```

### 3.3 DioHttpClient implementation

```dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:{{project_name}}_core/{{project_name}}_core.dart';

final class DioHttpClient implements HttpClient {
  final Dio _dio;
  final CacheRepository _cacheRepository;
  String _languageCode;

  // Decoded JWT fields
  String? _accessToken;
  String? _refreshToken;
  String? _userId;

  DioHttpClient({
    required String apiKey,
    required String baseUrl,
    required CacheRepository cacheRepository,
    required String languageCode,
  }) : _cacheRepository = cacheRepository,
       _languageCode = languageCode,
       _dio = Dio(BaseOptions(
         baseUrl: baseUrl,
         headers: {
           'x-api-key': apiKey,
           'Accept-Language': languageCode,
         },
       )) {
    _dio.interceptors.add(RefreshTokenInterceptor(httpClient: this, dio: _dio));
  }

  @override
  String get languageCode => _languageCode;

  @override
  set languageCode(String code) {
    _languageCode = code;
    _dio.options.headers['Accept-Language'] = code;
  }

  @override
  String? get accessToken => _accessToken;

  @override
  String? get userId => _userId;

  @override
  bool get isAuthenticated => _accessToken != null;

  @override
  Future<void> setAccessToken(String token) async {
    _accessToken = token;
    _userId = _extractUserIdFromJwt(token);
    _dio.options.headers['Authorization'] = 'Bearer $token';
    await _cacheRepository.put(CacheKeys.accessToken, token);
  }

  @override
  Future<void> setRefreshToken(String token) async {
    _refreshToken = token;
    await _cacheRepository.put(CacheKeys.refreshToken, token);
  }

  @override
  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    _userId = null;
    _dio.options.headers.remove('Authorization');
    await _cacheRepository.delete(CacheKeys.accessToken);
    await _cacheRepository.delete(CacheKeys.refreshToken);
  }

  /// Replace `[USER_ID]` placeholder in API paths with actual userId
  String _resolvePath(String path) {
    if (_userId != null) {
      return path.replaceAll('[USER_ID]', _userId!);
    }
    return path;
  }

  String? _extractUserIdFromJwt(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final map = jsonDecode(payload) as Map<String, dynamic>;
      return map['sub'] as String?;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<HttpClientResponse> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.get(
      _resolvePath(path),
      queryParameters: queryParameters,
    );
    return (statusCode: response.statusCode ?? 0, data: response.data);
  }

  @override
  Future<HttpClientResponse> post(String path, {dynamic data}) async {
    final response = await _dio.post(_resolvePath(path), data: data);
    return (statusCode: response.statusCode ?? 0, data: response.data);
  }

  @override
  Future<HttpClientResponse> put(String path, {dynamic data}) async {
    final response = await _dio.put(_resolvePath(path), data: data);
    return (statusCode: response.statusCode ?? 0, data: response.data);
  }

  @override
  Future<HttpClientResponse> patch(String path, {dynamic data}) async {
    final response = await _dio.patch(_resolvePath(path), data: data);
    return (statusCode: response.statusCode ?? 0, data: response.data);
  }

  @override
  Future<HttpClientResponse> delete(String path) async {
    final response = await _dio.delete(_resolvePath(path));
    return (statusCode: response.statusCode ?? 0, data: response.data);
  }

  @override
  Future<HttpClientResponse> postMultipart(String path,
      {required Map<String, dynamic> fields,
       required String fileFieldName,
       required String filePath}) async {
    final formData = FormData.fromMap({
      ...fields,
      fileFieldName: await MultipartFile.fromFile(filePath),
    });
    final response = await _dio.post(_resolvePath(path), data: formData);
    return (statusCode: response.statusCode ?? 0, data: response.data);
  }
}
```

### 3.4 RefreshTokenInterceptor

```dart
import 'dart:async';
import 'package:dio/dio.dart';
import 'dio_http_client.dart';

final class RefreshTokenInterceptor extends Interceptor {
  final DioHttpClient _httpClient;
  final Dio _dio;
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  RefreshTokenInterceptor({
    required DioHttpClient httpClient,
    required Dio dio,
  }) : _httpClient = httpClient,
       _dio = dio;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401 || !_httpClient.isAuthenticated) {
      return handler.next(err);
    }

    // If already refreshing, wait for it
    if (_isRefreshing) {
      await _refreshCompleter?.future;
      // Retry original request
      try {
        final response = await _dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<void>();

    try {
      final response = await _dio.post(
        '/auth/users/refresh-token',
        options: Options(headers: {
          'Authorization': 'Bearer ${_httpClient.accessToken}',
        }),
      );
      final newAccessToken = response.data['accessToken'] as String;
      await _httpClient.setAccessToken(newAccessToken);
      _refreshCompleter?.complete();

      // Retry original request with new token
      err.requestOptions.headers['Authorization'] =
          'Bearer $newAccessToken';
      final retryResponse = await _dio.fetch(err.requestOptions);
      return handler.resolve(retryResponse);
    } catch (e) {
      _refreshCompleter?.completeError(e);
      await _httpClient.clearTokens();
      return handler.next(err);
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }
}
```

**Key design choices**:

- `[USER_ID]` placeholder in API paths gets replaced at runtime from JWT `sub` claim
- Tokens are cached in `CacheRepository` on every `setAccessToken`/`setRefreshToken` call
- `Completer` prevents concurrent refresh attempts
- Language header injected on every request

---

## PATTERN 4: DIO REPOSITORY (`dio_{{entity}}_repository`)

### 4.1 Package structure

```
packages/{{project_name}}/dio_{{entity}}_repository/
├── pubspec.yaml
└── lib/
    ├── dio_{{entity}}_repository.dart     # Barrel + main class
    └── models/
        └── {{entity}}_model.dart          # JSON ↔ Entity bridge
```

### 4.2 `pubspec.yaml`

```yaml
name: dio_{{entity}}_repository
description: "Dio implementation of {{Entity}}Repository."
version: 0.0.1
publish_to: none

environment:
  sdk: ^3.9.2

resolution: workspace

dependencies:
  {{project_name}}_core:
    path: ../../{{project_name}}_core
  dio_http_client:
    path: ../../clients/dio_http_client
```

### 4.3 Model class template

```dart
import 'package:{{project_name}}_core/{{project_name}}_core.dart';

final class {{Entity}}Model extends {{Entity}}Entity {
  const {{Entity}}Model({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  /// API JSON → Model
  factory {{Entity}}Model.fromJson(Map<String, dynamic> json) {
    return {{Entity}}Model(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Model → API JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  /// Entity → Model (for sending updates to API)
  factory {{Entity}}Model.fromEntity({{Entity}}Entity entity) {
    return {{Entity}}Model(
      id: entity.id,
      name: entity.name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Model → Entity (covariance is automatic since Model extends Entity)
  {{Entity}}Entity toEntity() => this;
}
```

### 4.4 Repository implementation template

```dart
import 'package:{{project_name}}_core/{{project_name}}_core.dart';

import 'models/{{entity}}_model.dart';

export 'models/{{entity}}_model.dart';

// Step 1: Create a convenience typedefs
typedef _Exception = {{Entity}}RepositoryException;
typedef _ExceptionCode = {{Entity}}RepositoryExceptionCode;

// Step 2: Extend HttpClientRepository, implement the interface
final class Dio{{Entity}}Repository
    extends HttpClientRepository<_ExceptionCode>
    implements {{Entity}}Repository {

  final HttpClient _httpClient;

  Dio{{Entity}}Repository({required HttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<void> initialize() async {
    // Load cached tokens, warm up caches, etc.
  }

  @override
  Future<List<{{Entity}}Entity>> get{{Entity}}s({
    {{Project}}PaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await _httpClient.get(
        '/{{entity_plural}}',
        queryParameters: {
          if (paginationInfo?.limit != null)
            'limit': paginationInfo!.limit,
          if (paginationInfo?.cursor != null)
            'cursor': paginationInfo!.cursor,
        },
      );
      final List<dynamic> items = response.data['data'] as List<dynamic>;
      return items
          .map((json) => {{Entity}}Model.fromJson(json as Map<String, dynamic>))
          .toList();
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(
        errorResponse: errorResponse,
        codeFromStatusCode: (statusCode) => switch (statusCode) {
          401 => _ExceptionCode.unauthorized,
          404 => _ExceptionCode.notFound,
          _ => _ExceptionCode.unknown,
        },
      );
      rethrow; // unreachable but satisfies analyzer
    }
  }

  @override
  Future<{{Entity}}Entity> get{{Entity}}ById(String id) async {
    try {
      final response = await _httpClient.get('/{{entity_plural}}/$id');
      return {{Entity}}Model.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(
        errorResponse: errorResponse,
        codeFromStatusCode: (statusCode) => switch (statusCode) {
          401 => _ExceptionCode.unauthorized,
          404 => _ExceptionCode.notFound,
          _ => _ExceptionCode.unknown,
        },
      );
      rethrow;
    }
  }

  @override
  Future<{{Entity}}Entity> create{{Entity}}({{Entity}}Entity entity) async {
    try {
      final model = {{Entity}}Model.fromEntity(entity);
      final response = await _httpClient.post(
        '/{{entity_plural}}',
        data: model.toJson(),
      );
      return {{Entity}}Model.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(
        errorResponse: errorResponse,
        codeFromStatusCode: (statusCode) => switch (statusCode) {
          401 => _ExceptionCode.unauthorized,
          _ => _ExceptionCode.unknown,
        },
      );
      rethrow;
    }
  }

  // Pattern continues for update, delete...
}
```

**Dio repository rules**:

- `extends HttpClientRepository<ExceptionCode>` for shared error handling
- `implements {{Entity}}Repository` from core
- `typedef` aliases reduce boilerplate: `_Exception`, `_ExceptionCode`
- Models live in `lib/models/`, extend core entities, have `fromJson`/`toJson`/`fromEntity`
- Error handling: `on HttpClientResponse catch (errorResponse)` → `handleHttpClientErrorResponse`
- Status code → exception code mapping via `switch` expression
- `[USER_ID]` in API paths is auto-resolved by HttpClient

### 4.5 Authentication repository (special case)

The authentication repository is unique — it handles OTP flow, token management, and user profile CRUD:

```dart
final class DioAuthenticationRepository
    extends HttpClientRepository<AuthenticationRepositoryExceptionCode>
    implements AuthenticationRepository {

  final HttpClient _httpClient;
  final CacheRepository _cacheRepository;

  DioAuthenticationRepository({
    required HttpClient httpClient,
    required CacheRepository cacheRepository,
  }) : _httpClient = httpClient,
       _cacheRepository = cacheRepository;

  @override
  Future<void> initialize() async {
    // Restore tokens from cache
    final accessToken = await _cacheRepository.get(CacheKeys.accessToken);
    final refreshToken = await _cacheRepository.get(CacheKeys.refreshToken);
    if (accessToken != null) await _httpClient.setAccessToken(accessToken);
    if (refreshToken != null) await _httpClient.setRefreshToken(refreshToken);
  }

  @override
  Future<OtpInfoEntity?> sendOtp(String phoneNumber, Country country) async {
    try {
      final response = await _httpClient.post('/auth/users/otp/send', data: {
        'phoneNumber': phoneNumber,
        'countryCode': country.code,
      });
      // Parse optional OTP metadata
      final data = response.data['data'] as Map<String, dynamic>?;
      if (data != null) {
        return OtpInfoEntity(
          otpLength: data['otpLength'] as int?,
          otpDuration: data['otpDuration'] != null
              ? Duration(seconds: data['otpDuration'] as int)
              : null,
        );
      }
      return null;
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(
        errorResponse: errorResponse,
        codeFromStatusCode: _mapStatusCode,
      );
      rethrow;
    }
  }

  @override
  Future<UserEntity> verifyOtp(String otp) async {
    try {
      final response = await _httpClient.post(
        '/auth/users/otp/verify',
        data: {'otp': otp},
      );
      final data = response.data['data'] as Map<String, dynamic>;
      // Store tokens
      await _httpClient.setAccessToken(data['accessToken'] as String);
      await _httpClient.setRefreshToken(data['refreshToken'] as String);
      // Return user
      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(
        errorResponse: errorResponse,
        codeFromStatusCode: _mapStatusCode,
      );
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _httpClient.clearTokens();
    await _cacheRepository.clear();
  }
}
```

---

## PATTERN 5: MOCK REPOSITORY (`mock_{{entity}}_repository`)

### 5.1 Package structure

```
packages/mock/mock_{{entity}}_repository/
├── pubspec.yaml
└── lib/
    ├── mock_{{entity}}_repository.dart    # Barrel
    └── src/
        └── mock_{{entity}}_repository.dart
```

### 5.2 `pubspec.yaml`

```yaml
name: mock_{{entity}}_repository
description: "Mock implementation of {{Entity}}Repository."
version: 0.0.1
publish_to: none

environment:
  sdk: ^3.9.2

resolution: workspace

dependencies:
  {{project_name}}_core:
    path: ../../{{project_name}}_core
  mock_data:
    path: ../mock_data
  faker: ^2.1.0
```

### 5.3 Mock repository template

```dart
import 'package:{{project_name}}_core/{{project_name}}_core.dart';
import 'package:mock_data/mock_data.dart';

final class Mock{{Entity}}Repository implements {{Entity}}Repository {
  final Duration delay;
  final LocalizedClient? localizedClient;
  final CacheRepository? cacheRepository;

  List<{{Entity}}Entity> _items = [];

  Mock{{Entity}}Repository({
    this.delay = const Duration(seconds: 2),
    this.localizedClient,
    this.cacheRepository,
  });

  @override
  Future<void> initialize() async {
    _items = MockDataService.get{{Entity}}s(
      languageCode: localizedClient?.languageCode ?? 'en',
    );
  }

  @override
  Future<List<{{Entity}}Entity>> get{{Entity}}s({
    {{Project}}PaginationInfo? paginationInfo,
  }) async {
    await Future.delayed(delay);
    return List.of(_items);
  }

  @override
  Future<{{Entity}}Entity> get{{Entity}}ById(String id) async {
    await Future.delayed(delay);
    return _items.firstWhere(
      (e) => e.id == id,
      orElse: () => throw {{Entity}}RepositoryException(
        code: {{Entity}}RepositoryExceptionCode.notFound,
      ),
    );
  }

  @override
  Future<{{Entity}}Entity> create{{Entity}}({{Entity}}Entity entity) async {
    await Future.delayed(delay);
    _items.add(entity);
    return entity;
  }

  @override
  Future<{{Entity}}Entity> update{{Entity}}({{Entity}}Entity entity) async {
    await Future.delayed(delay);
    final index = _items.indexWhere((e) => e.id == entity.id);
    if (index == -1) {
      throw {{Entity}}RepositoryException(
        code: {{Entity}}RepositoryExceptionCode.notFound,
      );
    }
    _items[index] = entity;
    return entity;
  }

  @override
  Future<void> delete{{Entity}}(String id) async {
    await Future.delayed(delay);
    _items.removeWhere((e) => e.id == id);
  }
}
```

**Mock repository rules**:

- Implements the SAME interface as the Dio repo
- Configurable `delay` to simulate network latency
- Optional `LocalizedClient` for bilingual mock data
- Optional `CacheRepository` for persistent mock caching
- Data sourced from centralized `mock_data` package
- Throw the SAME typed exceptions as the Dio repo

### 5.4 MockLocalizedClient (for language-aware mock data)

```dart
final class MockLocalizedClient implements LocalizedClient {
  String _languageCode;

  MockLocalizedClient({required String languageCode})
      : _languageCode = languageCode;

  @override
  String get languageCode => _languageCode;

  @override
  set languageCode(String code) => _languageCode = code;
}
```

---

## END OF PART 1

Say **"continue"** to receive **Part 2 — Patterns 6 (Cache Repository), 7 (Mock Data), 8 (UI Kit)**.
