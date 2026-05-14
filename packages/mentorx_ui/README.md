# 🎨 MentorX UI Kit

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Package](https://img.shields.io/badge/Package-mentorx__ui-2EC4B6?style=for-the-badge)](#)

The **MentorX UI Kit** is the design foundation for the entire MentorX ecosystem. it provides a unified set of widgets, theme tokens, and design patterns to ensure a premium, consistent experience across all applications.

---

## 🌈 Design System

### Color Palette
-   **Oxford Blue (`brandPrimary`)**: The core brand identity.
-   **Pumpkin Orange (`brandSecondary`)**: Accent used for CTAs and highlights.
-   **Light Beige (`backgroundPrimary`)**: Soft, welcoming background for a modern feel.
-   **Teal Green (`statusSuccess`)**: Indicators for success and achievements.

### Typography
-   Primary Font: **Outfit** (or custom brand fonts)
-   Secondary Font: **HT-Mosafer-Rounded** (for specialized contexts)

---

## 📦 What's Inside?

-   **`theming/`**: Core theme providers, extension tokens, and color palettes for both Light and Dark modes.
-   **`widgets/`**: A library of reusable, brand-compliant UI components (Buttons, Cards, Modals, etc.).
-   **`assets/`**: Centralized repository for brand SVGs and icons.
-   **`localization/`**: Shared labels and UI-specific translations.

---

## 🛠️ Usage

To use this package in other modules, add it to your `pubspec.yaml`:

```yaml
dependencies:
  mentorx_ui:
    path: ../packages/mentorx_ui
```

### Applying the Theme
Wrap your app with `MentorXThemeProvider` (if provided) or apply the `MentorXTheme` directly to your `MaterialApp`.

```dart
MaterialApp(
  theme: MentorXThemes.light,
  darkTheme: MentorXThemes.dark,
  // ...
)
```

---

## 🚀 Development
When adding new components:
1.  Ensure they support both **Light** and **Dark** modes.
2.  Use **Theme Extensions** for custom style tokens.
3.  Apply haptic feedback where appropriate via the built-in extensions.
