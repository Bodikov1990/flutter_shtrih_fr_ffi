## 0.1.1

- Initial release with bindings to `classic_fr_drv_ng.dll`.

## 0.1.2

- LICENSE updated.

## 0.1.3

- Fixed returnSale.

## 0.2.0

### 🎉 Major Features

#### TLV Tags Support for Customer Information
- **NEW**: Send customer email and TIN (ИИН/БИН) to fiscal register
- **Tag 1008**: Customer email/phone for electronic receipt delivery
- **Tag 1228**: Customer TIN (ИИН/БИН) for Kazakhstan fiscal requirements

#### New Entities
- `CustomerInfo` - model for customer data (email, phone, TIN)
- `TagTypes` - constants for TLV tag data types
- `TagNumber` - constants for popular tag numbers
- `SendTagParams` - parameters for sending arbitrary TLV tags
- `ValidationException` - enhanced validation error handling

#### Enhanced API
- `saleAndCloseCheck()` now accepts optional `customerInfo` parameter
- `returnSale()` now accepts optional `customerInfo` parameter
- Automatic tag sending between item registration and check closing
- **Backward compatible** - existing code works without changes

#### Driver Layer Improvements
- `sendTag()` - universal method for sending any TLV tag
- `sendCustomerEmail()` - specialized method for email (tag 1008)
- `printString()` - print arbitrary text with automatic TIN recognition
- Background execution in isolates prevents UI blocking

#### Validation Enhancements
- Input validation for `ConnectionParams` (port, baud rate, timeout, password)
- Input validation for `ItemModel` (name, price, quantity)
- Email format validation (RFC 5322 compliant)
- TIN format validation (12 digits for Kazakhstan)
- Clear error messages with parameter names

### 🐛 Bug Fixes
- Fixed `returnSale()` - removed unnecessary `openCheck` call
- Improved error handling in repository layer
- Better exception messages for debugging

### 📚 Documentation
- Added comprehensive `TLV_TAGS_GUIDE.md` with usage examples
- Updated example app with customer info demo
- Enhanced inline documentation for all public methods
- Added code examples for common scenarios

### 🏗️ Architecture Improvements
- Clean separation of concerns in repository layer
- Helper method `_sendCustomerTags()` for centralized tag logic
- Proper error propagation throughout the stack
- Improved code organization and readability

### 💡 Usage Example

```dart
// Send electronic receipt to customer
await kkm.saleAndCloseCheck(
  reportParams: connectionParams,
  items: items,
  totalSumm1: 100,
  // ... other parameters
  customerInfo: CustomerInfo(
    email: 'client@example.com',  // Electronic receipt
    tin: '123456789012',           // Customer TIN (Kazakhstan)
  ),
);
```

### ⚠️ Breaking Changes
None - fully backward compatible.

### 📦 Dependencies
- No new dependencies added
- Uses existing `ffi: ^2.1.4`
