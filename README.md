# flutter_shtrih_fr_ffi

FFI wrapper for the native `classic_fr_drv_ng.dll` library for Windows. This package allows you to control Shtrih-FR fiscal registers using Dart/Flutter desktop apps.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_shtrih_fr_ffi: ^0.1.0


Setup DLL
Download classic_fr_drv_ng.dll from the official GitHub repo:
https://github.com/shtrih-m/fr_drv_ng/releases

Place it in your project under:
windows/classic_fr_drv_ng.dll

Then modify windows/runner/CMakeLists.txt to copy it after build:
add_custom_command(
  TARGET ${BINARY_NAME}
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_CURRENT_SOURCE_DIR}/../classic_fr_drv_ng.dll"
    "$<TARGET_FILE_DIR:${BINARY_NAME}>/classic_fr_drv_ng.dll"
  COMMENT "Copying classic_fr_drv_ng.dll after build"
)
