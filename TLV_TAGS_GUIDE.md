# Руководство по работе с TLV-тегами

## 📋 Обзор

Данная библиотека поддерживает отправку TLV-тегов в фискальный накопитель для:
- **Тег 1008**: Email/телефон покупателя (для отправки электронного чека)
- **Тег 1228**: ИИН/БИН покупателя (для Казахстана)
- Любые другие TLV-теги через универсальный API

---

## 🚀 Быстрый старт

### 1. Импорт библиотеки

```dart
import 'package:flutter_shtrih_fr_ffi/flutter_shtrih_fr_ffi.dart';
```

### 2. Базовое использование - отправка email покупателя

```dart
final kkm = FlutterStrihFrFFI();
final driver = StrihFrDriver();

try {
  // 1. Подключение
  await driver.connect(
    comNumber: 8,       // COM9
    baudRate: 115200,
    timeout: 5000,
  );

  // 2. Открыть чек
  await driver.openCheck(
    operatorPassword: 30,
    checkType: CheckType.sale,
  );

  // 3. Регистрация товаров
  await driver.sale(
    quantity: 1.0,
    price: 10000, // 100 руб в копейках
    department: 1,
    operatorPassword: 30,
    text: 'Товар 1',
  );

  // 4. ⭐ Отправить email покупателя (тег 1008)
  await driver.sendCustomerEmail(
    email: 'client@example.com',
    operatorPassword: 30,
  );

  // 5. Закрыть чек
  await driver.closeCheck(
    operatorPassword: 30,
    summ1: 10000,
    summ2: 0, summ3: 0, summ4: 0,
    discountOnCheck: 0.0,
    tax1: 0, tax2: 0, tax3: 0, tax4: 0,
  );
} finally {
  driver.deinit();
}
```

---

## 📧 Отправка email покупателя (тег 1008)

### Способ 1: Через специализированный метод `sendCustomerEmail`

```dart
await driver.sendCustomerEmail(
  email: 'customer@example.com',
  operatorPassword: 30,
);
```

### Способ 2: Через универсальный метод `sendTag`

```dart
await driver.sendTag(
  tagNumber: TagNumber.customerEmail, // 1008
  tagType: TagType.string,             // 5
  tagValue: 'customer@example.com',
  operatorPassword: 30,
);
```

---

## 🆔 Отправка ИИН/БИН покупателя (тег 1228) - для Казахстана

```dart
await driver.sendTag(
  tagNumber: TagNumber.customerTIN,   // 1228
  tagType: TagType.string,             // 5
  tagValue: '123456789012',            // 12 цифр
  operatorPassword: 30,
);
```

---

## 🔄 Комбинированный пример: Email + ИИН

```dart
final driver = StrihFrDriver();

try {
  await driver.connect(comNumber: 8, baudRate: 115200, timeout: 5000);
  await driver.openCheck(operatorPassword: 30, checkType: CheckType.sale);

  // Регистрация товаров
  await driver.sale(
    quantity: 2.0,
    price: 15000,
    department: 1,
    operatorPassword: 30,
    text: 'Кофе',
  );

  // ⭐ Отправить email покупателя
  await driver.sendCustomerEmail(
    email: 'client@gmail.com',
    operatorPassword: 30,
  );

  // ⭐ Отправить ИИН покупателя
  await driver.sendTag(
    tagNumber: 1228,
    tagType: 5,
    tagValue: '123456789012',
    operatorPassword: 30,
  );

  // Закрытие чека
  await driver.closeCheck(
    operatorPassword: 30,
    summ1: 30000,
    summ2: 0, summ3: 0, summ4: 0,
    discountOnCheck: 0.0,
    tax1: 0, tax2: 0, tax3: 0, tax4: 0,
  );
} finally {
  driver.deinit();
}
```

---

## 📌 Типы данных для тегов (`TagType`)

| Константа | Значение | Описание |
|-----------|----------|----------|
| `TagType.byte` | 0 | Одиночный байт (0-255) |
| `TagType.uint16` | 1 | 16-битное целое |
| `TagType.uint32` | 2 | 32-битное целое |
| `TagType.vln` | 3 | Переменная длина |
| `TagType.fvln` | 4 | Дробное переменной длины |
| `TagType.string` | 5 | Строка (для email, ИИН) |
| `TagType.unixtime` | 6 | Unix timestamp |
| `TagType.stlv` | 7 | Структурированный TLV |
| `TagType.byteArray` | 8 | Массив байтов |

---

## 🏷️ Популярные номера тегов (`TagNumber`)

| Константа | Номер | Описание |
|-----------|-------|----------|
| `TagNumber.customerEmail` | 1008 | Email/телефон покупателя |
| `TagNumber.customerTIN` | 1228 | ИИН/БИН покупателя (Казахстан) |

---

## ⚠️ Важные замечания

1. **Порядок операций обязателен:**
   ```
   openCheck → sale (товары) → sendTag (теги) → closeCheck
   ```

2. **Теги отправляются ПОСЛЕ регистрации товаров, но ДО закрытия чека**

3. **Валидация:**
   - Email: стандартный формат (`username@domain.com`)
   - ИИН/БИН: ровно 12 цифр

4. **Настройки кассы (для Казахстана):**
   - Модель ФР: **Штрих-ON-LINE**
   - Протокол: **1.16**
   - Включить: "Печать ИИН/БИН клиента на чеке" в личном кабинете

---

## 🔧 Низкоуровневый доступ

Для прямой работы с драйвером используйте класс `StrihFrDriver`:

```dart
import 'package:flutter_shtrih_fr_ffi/src/driver/strih_fr_driver.dart';

final driver = StrihFrDriver();
// ... работа с драйвером
driver.deinit(); // Обязательная очистка!
```

---

## 📚 Дополнительные ресурсы

- [Документация API](https://github.com/shtrih-m/fr_drv_ng)
- [Пример приложения](example/lib/main.dart)
- [Спецификация тегов ФН](https://онлайнкассир.рф/faq/thegs)

---

## ✅ Проверка работы через тест-драйвер

### Email (тег 1008):
1. Регистрация → Продажа товара
2. ФН → Теги ОФД → Тег 1008
3. Получить описание тега
4. Указать email в "Значение тега строка"
5. Отправить тег
6. Регистрация → Закрыть чек

### ИИН/БИН (тег 1228):
1. Регистрация → Продажа товара
2. ФН → Теги ОФД → Тег 1228
3. Получить описание тега
4. Указать ИИН (12 цифр) в "Значение тега строка"
5. Отправить тег
6. Регистрация → Закрыть чек
