# flutter_shtrih_fr_ffi

Dart/Flutter FFI wrapper for the Windows library `classic_fr_drv_ng.dll`. It provides a simple API to control Shtrih‑FR fiscal registers from desktop applications.

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_shtrih_fr_ffi: ^0.1.1
```

Then run `flutter pub get`.

## Windows DLL

Download `classic_fr_drv_ng.dll` from [Shtrih's GitHub releases](https://github.com/shtrih-m/fr_drv_ng/releases) and place it in
`windows/classic_fr_drv_ng.dll` inside your Flutter project. Add the following to `windows/runner/CMakeLists.txt` so the DLL is copied next to the executable:

```cmake
add_custom_command(
  TARGET ${BINARY_NAME} POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_CURRENT_SOURCE_DIR}/../classic_fr_drv_ng.dll"
    "$<TARGET_FILE_DIR:${BINARY_NAME}>/classic_fr_drv_ng.dll"
  COMMENT "Copying classic_fr_drv_ng.dll after build"
)
```

## Example

```dart
final kkm = FlutterStrihFrFFI();

await kkm.printReportWithoutCleaning(
  reportParams: ConnectionParams(
    comNumber: 8, //Local com-port
    baudRate: 115200,
    timeout: 5000, //Timeout in milliseconds; values below 5000 may cause communication errors due to slow device response.
    operatorPassword: 30,
  ),
);
```

See the [example](example/lib/main.dart) folder for a complete demo. Or full [example app](https://github.com/Bodikov1990/flutter_example_app_shtrih_fr) where included `windows/classic_fr_drv_ng.dll` and `windows/runner/CMakeLists.txt`.
