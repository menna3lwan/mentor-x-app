part of 'package:mentorx_core/mentorx_core.dart';

/// Extensions for the [String] class to provide additional functionality.
extension MentorXStringExtensions on String {
  /// Whether the string represents a valid network URL.
  ///
  /// Checks if the string matches common URL patterns with protocols
  /// such as http, https, ftp, file, ws, or wss.
  bool get isNetworkUrl {
    // Create a RegExp that matches common URL protocols
    final RegExp urlPattern = RegExp(
      r'^(https?|ftp|file|wss?):\/\/' // Protocol (http, https, ftp, file, ws, wss)
      r'(([a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?' // Domain name
      r'|(\d{1,3}\.){3}\d{1,3})' // OR IP address
      r'(:\d+)?' // Optional port
      r'(\/[-a-zA-Z0-9%_.~#+]*)*' // Path
      r'(\?[;&a-zA-Z0-9%_.~+=-]*)?' // Query string
      r'(\#[-a-zA-Z0-9%_.~+=/]*)?$', // Fragment
      caseSensitive: false,
    );
    return urlPattern.hasMatch(this);
  }

  /// Whether the string represents a valid SVG image URL.
  ///
  /// First checks if the string is a network URL, then verifies
  /// if it has an SVG file extension or content type indicator.
  bool get isSvgUrl {
    // First check if it's a network URL
    if (!isNetworkUrl) {
      return false;
    }
    // Check if URL ends with .svg (case insensitive)
    // or if it has a Content-Type or MIME type parameter indicating SVG
    final RegExp svgPattern = RegExp(
      r'\.svg(\?[^#]*)?$|' // File extension .svg
      r'[?&]type=(image/svg\+xml|svg)', // URL parameter type=image/svg+xml
      caseSensitive: false,
    );
    return svgPattern.hasMatch(this);
  }

  bool get isLocalSvgPath {
    // Pattern for local SVG file paths
    final RegExp localSvgPattern = RegExp(
      r'[^:*?"<>|]*\.svg$', // Ends with .svg
      caseSensitive: false,
    );
    return localSvgPattern.hasMatch(this);
  }

  /// Whether the string represents a valid raster image URL.
  ///
  /// First checks if the string is a network URL, then verifies
  /// if it has a common raster image file extension.
  bool get isRasterImageUrl {
    // First check if it's a network URL
    if (!isNetworkUrl) {
      return false;
    }
    // Check if URL ends with common raster image extensions
    final RegExp rasterPattern = RegExp(
      r'\.(jpe?g|png|gif|bmp|webp|tiff?|ico|heic|heif|avif)(\?[^#]*)?$',
      caseSensitive: false,
    );
    return rasterPattern.hasMatch(this);
  }

  /// Whether the string represents a valid local file path.
  ///
  /// Explicitly excludes network URLs and checks if the string
  /// matches common patterns for local paths on Windows or Unix systems.
  bool get isLocalPath {
    // Explicitly exclude network URLs
    if (isNetworkUrl) {
      return false;
    }
    // Pattern for common local path formats
    final RegExp localPathPattern = RegExp(
      // Windows absolute paths (C:\folder\file.txt)
      r'^([a-zA-Z]:[\\/]|'
      // Windows UNC paths (\\server\share)
      r'\\\\[^\\/:*?"<>|]+\\[^\\/:*?"<>|]+|'
      // Unix absolute paths (/home/user/file.txt)
      r'\/|'
      // Unix relative paths (./folder or ../folder)
      r'\.[\/\\]|'
      // Relative paths without ./ prefix (folder/file.txt)
      r'[^\/\\:*?"<>|]+[\/\\])'
      // Path components
      r'[^:*?"<>|]*$',
    );
    return localPathPattern.hasMatch(this);
  }

  /// Whether the string represents a valid email address.
  ///
  /// Checks if the string is not empty and matches a common email pattern
  /// with username, @ symbol, domain name, and top-level domain (TLD).
  bool get isValidEmail {
    if (isEmpty) return false;

    // Regular expression for email validation
    // This regex checks for:
    // - One or more characters before the @ symbol
    // - @ symbol
    // - Domain name with at least one character before and after a period
    // - TLD (top-level domain) with at least 2 characters
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(this);
  }

  /// Whether the string contains at least one uppercase letter.
  bool get hasUppercase => contains(RegExp(r'[A-Z]'));

  /// Whether the string contains at least one lowercase letter.
  bool get hasLowercase => contains(RegExp(r'[a-z]'));

  /// Whether the string contains at least one digit.
  bool get hasDigit => contains(RegExp(r'\d'));

  /// Whether the string contains at least one special character.
  bool get hasSpecialCharacter => contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  /// Whether the string length is at least the specified minimum.
  ///
  /// [mimimum] is the minimum length required.
  bool satisfiesMinLength(int mimimum) => length >= mimimum;

  /// Whether the string length does not exceed the specified maximum.
  ///
  /// [maximum] is the maximum length allowed.
  bool satisfiesMaxLength(int maximum) => length <= maximum;
}
