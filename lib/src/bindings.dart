import 'dart:ffi';
import 'package:ffi/ffi.dart';

/// Handle to the native dynamic library.
final _dll = DynamicLibrary.open('classic_fr_drv_ng.dll');

// Utility for creating integer setters
typedef _IntArg = Void Function(Pointer<Void>, Int32);
typedef _IntArgDart = void Function(Pointer<Void>, int);
void Function(Pointer<Void>, int) _makeSetter(String name) =>
    _dll.lookupFunction<_IntArg, _IntArgDart>(name);

/// FFI bindings to the `classic_fr_drv_ng` library.
class StrihFrBindings {
  // Context
  static final cInit = _dll.lookupFunction<
    Pointer<Void> Function(Pointer<Utf8>),
    Pointer<Void> Function(Pointer<Utf8>)
  >('c_classic_init');
  static final cDeinit = _dll.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('c_classic_deinit');

  // Initialize common setters
  static final setComNumber = _makeSetter('Set_ComNumber');
  static final setBaudRate = _makeSetter('Set_BaudRate');
  static final setTimeout = _makeSetter('Set_Timeout');
  static final setConnType = _makeSetter('Set_ConnectionType');
  static final setCheckType = _makeSetter('Set_CheckType');
  static final setDepartment = _makeSetter('Set_Department');
  static final setTax1 = _makeSetter('Set_Tax1');
  static final setTax2 = _makeSetter('Set_Tax2');
  static final setTax3 = _makeSetter('Set_Tax3');
  static final setTax4 = _makeSetter('Set_Tax4');
  static final setSumm1 = _makeSetter('Set_Summ1');
  static final setSumm2 = _makeSetter('Set_Summ2');
  static final setSumm3 = _makeSetter('Set_Summ3');
  static final setSumm4 = _makeSetter('Set_Summ4');

  // Special setters
  static final setPassword = _dll.lookupFunction<
    Void Function(Pointer<Void>, Uint32),
    void Function(Pointer<Void>, int)
  >('Set_Password');
  static final setQuantity = _dll.lookupFunction<
    Void Function(Pointer<Void>, Double),
    void Function(Pointer<Void>, double)
  >('Set_Quantity');
  static final setPrice = _dll.lookupFunction<
    Void Function(Pointer<Void>, Int64),
    void Function(Pointer<Void>, int)
  >('Set_Price');
  static final setStringForPrinting = _dll.lookupFunction<
    Void Function(Pointer<Void>, Pointer<Utf8>, IntPtr),
    void Function(Pointer<Void>, Pointer<Utf8>, int)
  >('Set_StringForPrinting');
  static final setDiscountOnCheck = _dll.lookupFunction<
    Void Function(Pointer<Void>, Double),
    void Function(Pointer<Void>, double)
  >('Set_DiscountOnCheck');

  // Commands
  static final connect = _dll.lookupFunction<
    Int32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('Connect');
  static final openCheck = _dll.lookupFunction<
    Int32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('OpenCheck');
  static final sale = _dll.lookupFunction<
    Int32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('Sale');
  static final closeCheck = _dll.lookupFunction<
    Int32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('CloseCheck');
  static final cancelCheck = _dll.lookupFunction<
    Int32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('CancelCheck');

  static final returnSale = _dll.lookupFunction<
    Int32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('ReturnSale');

  static final printReportWithoutCleaning = _dll.lookupFunction<
    Int32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('PrintReportWithoutCleaning');
  static final printReportWithCleaning = _dll.lookupFunction<
    Int32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('PrintReportWithCleaning');
}
