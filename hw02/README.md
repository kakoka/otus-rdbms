##  Типы данных в модели

Итак, мы составили следующую схему БД:

![Cхема БД.](pic/rest_db_schema_v2.png)

Опишем поля таблиц и используемые типы данных.

#### 1. Общая таблица примененных типов данных (PostgreSQL).

Имя | Обозначение | Размер | Описание | Диапазон
:---:|:---:|:---:| --- | ---
smallserial | serial2 | 2 байта | небольшое целое с автоувеличением | 1 .. 32767
serial | serial4 | 4 байта | целое с автоувеличением | 1 .. 2147483647
smallint | int2 | 2 байта | целое в небольшом диапазоне | -32768 .. +32767
integer | int4 | 4 байта | типичный выбор для целых чисел | -2147483648 .. +2147483647
bigint | int8 | 8 байт | целое в большом диапазоне | -9223372036854775808 .. 9223372036854775807
money | money | переменный | вещественное число с указанной точностью | до 131072 цифр до десятичной точки и до 16383 — после
numeric | numeric | переменный | вещественное число с переменной точностью | точность в пределах 15 десятичных цифр |
varchar | varchar(n) | n символов | строка ограниченной переменной длины | от 1 до 65535 символов
boolean | boolean | 1 байт | состояние: истина или ложь | |
timestamptz | timestamptz | 8 байт | дата и время (с часовым поясом) | 4713 до н. э. – 294276 н. э. |
date | date | 4 байта | дата (без времени суток) | 4713 до н.э. – 5874897 н. э. |
UUID | uuid | 128 бит | Cохраняет UUID, RFC 4122, ISO/IEC 9834-8:2005 и связанных стандартах.||
email | (DOMAIN) | | тип данных с доп. условиями | |

#### 1.1 Последовательности значений по умолчанию в поле `id_`.

Тип данных в поле `id_` - `smallserial` и `serial`. Значение по умолчанию этого поля `nextval('course__id__seq'::regclass)` означает, что используется последовательность значений, которая экономит уникальные значения id, позволяя их переиспользовать при удалении старых и добавлении новых записей.

```sql
CREATE SEQUENCE "course__id__seq"
       INCREMENT 1
       MINVALUE  1
       MAXVALUE 32767
       START 1
       CACHE 1;
```

#### 1.2 Типы данных

Применены следующие типы данных для следующих полей:

##### 1.2.1 Числовые типы данных

Использованы для следующих полей:

- счетчики - `id_` – smallint, integer
- цена – `price_` – money, храняться денежные данные
- количество – `quantity_` – smallint, хранятся целые небольшие числа
- вес – `weight_of_packing_` – numeric, хранятся числа с десятичной точкой

##### 1.2.2 Символьный тип данных

Varchar(n) - использован для полей, в которых содержатся сведения преимущественно описательного характера. Длина символьного поля варьируется исходя из разумных потребностей. Например, для перечисления вариантов упаковки продукта: "шт,кг,упак,л" нужно символьное поле длиной от 1 до 4 символов, а поле адреса потребует 255 символов.

##### 1.2.3 Логический типы данных

Используется для обозначения наличия или отсутсвия чего-либо в некоторых таблицах. Принимают только два значения "true" или "false".

##### 1.2.4 Типы даты/времени

- date - используем для фиксации даты, в том случае когда время суток не имеет значения, например `release_date_` - дата выхода сотрудника на работу
- timestamptz - используем для фиксации точного времени заведения записей в таблицы, или времени открытия заказа – `time_start_`.

##### 1.2.5 Собственные типы данных

Мы можем завести собственный тип данных, однако для подавляющего большинства таких типов сообществом разработчиков написаны расширения. Мы будем использовать следующие типы:

- email – для хранения только адресов электронной почты

```sql
# CREATE EXTENSION citext;
```

CREATE DOMAIN создаёт новый домен. Домен по сути представляет собой тип данных с дополнительными условиями (ограничивающими допустимый набор значений). Владельцем домена становится пользователь его создавший.

```sql
# CREATE DOMAIN email AS citext
```

Предложения CHECK задают ограничения целостности или проверки, которым должны удовлетворять значения домена.

```sql
  CHECK ( value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' );
```

Создаем еще и проверку на корректность указания email.

- phone - для хранения только номеров телефонов

Используем extension https://github.com/blm768/pg-libphonenumber.

```sql
CREATE EXTENSION pg_libphonenumber;
```

- UUID - cохраняет UUID в тех случаях, когда это имеет смысл, например таблица продуктов, которых может быть очень много с течением веремени работы ресторана.

```sql
CREATE EXTENSION "uuid-ossp";
```

Сгенерировать UUID можно с помощью дополнительного модуля uuid-ossp, в котором реализованы несколько стандартных алгоритмов

### 2. Таблицы базы данных `rest_db`.

#### 2.1 Таблица `city_`
Cодержит список городов, в которых проживают сотрудники ресторана. Список поселений в одной локации не может быть слишком большим, а название города слишком длинным, отсюда и выбор данных типов.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | serial2 | nextval('city__id__seq'::regclass) | NO | идетификатор записи
city_name_ | varchar(30) | None | NO | название города

#### 2.2 Таблица `course_`
Содержит актуальное меню ресторана, так же определяются позиции меню со скидками.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | serial | nextval('course__id__seq'::regclass)| NO | идентификатор записи
dish_ID | integer | None| NO | внешний ключ к таблице блюд `dish_`
discount_ID | integer | None| NO | внешний ключ к таблице блюд `discount_`
hasDiscout | boolean | false| NO | 'есть'/'нет' скидка на блюдо
isActive | boolean | false| NO | блюдо 'доступно'/'не доступно' для заказа

#### 2.3 Таблица `discount_`
Содержит возможные скидки заведения.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | serial2 | nextval('discount__id__seq'::regclass)| NO | идентификатор записи
quantity_ | smallint | None | NO | величина скидки (в процентах)

#### 2.4 Таблица `dish_`
Содрежит актуальные блюда ресторана.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | serial | nextval('dish__id__seq'::regclass)| NO | идентификатор записи
dish_ | varchar(100) | None| NO |  название блюда
price_ | money | None| NO | стоимость блюда
isActive | boolean | false| NO | возможность/не возможность приготовления

#### 2.5 Таблица `dish_items`
Служебная таблица, предназначена для списка продуктов, которое включает конкретное блюдо.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
product_id | integer | None| NO | внешний ключ к таблице продуктов
dish_id | integer | None| NO | внешний ключ к таблице блюд
quiantity_ | numeric(8,4) | 0 | NO | вес продукта в граммах

#### 2.6 Таблица `metrics_`
Таблица размерностей упаковки продуктов.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | serial | nextval('metrics__id__seq'::regclass)| NO | идентификатор записи
metric_ | varchar(4) | None| NO | размерность величин - упаковка, килограмм
weight_of_packing_ | numeric(8,4) | None | YES | вес упаковки

#### 2.7 Таблица `orders_course_`
Таблица заказов блюд в ресторане.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | serial | nextval('order__id__seq'::regclass)| NO | идентификатор записи
UUID | varchar(255) | uuid_generate_v4()| NO | уникальный идетификатор заказа
table_ID | integer | None| NO | внешний ключ к таблице столиков в ресторане
payment_method_ID | integer | None| NO | внешний ключ к таблице способов оплаты
time_start_ | timestamp with time zone | CURRENT_TIMESTAMP| NO | время открытия заказа
time_end_ | timestamp with time zone | None | YES | время закрытия заказа
isCancelled | boolean | false| NO | факт отмена заказа
isPayed | boolean | false| NO | факт оплаты заказа
stuff_ID | integer | None | YES | внешний ключ к таблице сотрудников, обслуживающих столик
isClosed | boolean | false | YES | факт закрытия заказа

#### 2.8 Таблица `orders_course_items`
Служебная таблица для таблицы заказов. Каждый заказ может содержать несколько позиций.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
order_ID | integer | None| NO | внешний ключ к таблице заказов
course_ID | integer | None| NO | внешний ключ к таблице блюд в меню
quantity_ | smallint | None| NO | количество

#### 2.9 Таблица `passports_`
Таблица паспортных данных сотрудников.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | serial | nextval('passports__id__seq'::regclass)| NO | идентификатор записи
passport_ | varchar(15) | None| NO | номер паспорта
passport_photo_ | varchar(255) | None| NO | ссылка на файл со изображением паспорта
passport_issue_date_ | date | None| NO | дата выдачи паспорт
passport_registration_address_ | varchar(255) | None| NO | адрес регистрации

#### 2.10 Таблица `payment_method_`
Таблица возможных способов оплаты.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | smallint | nextval('payment_method__id__seq'::regclass)| NO | идентификатор записи
method_ | varchar(15) | None| NO | способ оплаты
isActive | boolean | false| NO | доступен/недоступен для использования

#### 2.11 Таблица `position_`
Таблица названия должностей.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | smallint | nextval('position__id__seq'::regclass)| NO | идентификатор записи
position_name_ | varchar(40) | None| NO | название должности

#### 2.12 Таблица `product_items`
Служебная таблица для связывания поставщика и продуктов, которые поставщик предоставляет ресторану.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
product_ID | integer | None| NO | внешний ключ к таблице продуктов
supplier_ID | integer | None| NO | внешний ключ к таблице поставщиков продуктов

#### 2.13 Таблица `products_`
Таблица названий продуктов.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | serial | nextval('products__id__seq'::regclass)| NO | идентификатор записи
product_name_ | varchar(100) | None| NO | наименование продукта
UUID | varchar(255) | uuid_generate_v1() | NO |

#### 2.14 Таблица `stuff_`
Таблица сотрудников ресторана.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | serial | nextval('stuff__id__seq'::regclass)| NO | идентификатор записи
name_ | varchar(100) | None| NO | имя сотрудника
surname_ | varchar(100) | None| NO | фамилия сотрудника
familyname_ | varchar(100) | None | YES | отчество сотрудника (если имеется)
phone_ | varchar(11) | None| NO | номер телефона сотрудника
email_ | USER-DEFINED (email) | None | NO | email сотрудника
city_ID | integer | None| NO | внешний ключ к таблице городов проживания сотрудника
position_ID | integer | None| NO | внешний ключ к таблице должностей
UUID | varchar(255) | uuid_generate_v1()| NO | уникальный идентификатор сотрудника
timestamp_ | timestamp with time zone | CURRENT_TIMESTAMP| NO | время создания записи о сотруднике
release_date_ | date | None| NO | дата выхода сотрудника на работу
resignation_date_ | date | None | YES | дата увольнения сотрудника
passport_ID | integer | None| NO | внешний ключ к таблице паспортных данных

#### 2.15 Таблица `supplier_orders_`
Таблица заказов продуктов у поставщиков.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | serial | nextval('supplier_orders__id__seq'::regclass)| NO | идентификатор записи
supplier_ID | integer | None| NO | внешний ключ к таблице поставщиков
UUID | varchar() | uuid_generate_v4()| NO | уникальный идентификатор заказа
products_ID | integer | None| NO | внешний ключ к таблице продуктов
quantity | smallint | None| NO | количество продуктов
metric_ID | smallint | None| NO | внешний ключ к таблице размерностей продуктов
price_ | money | None| NO | закупочная цена продукта
timestamp | timestamp with time zone | CURRENT_TIMESTAMP| NO | время создания записи

#### 2.16 Таблица `supplier_orders_items`
Служебная таблица для таблицы заказов у поставщиков. Каждый заказ может содержать несколько позиций.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
product_id | integer | None| NO | внешний ключ к таблице продуктов
order_id | integer | None| NO | внешний ключ к таблице заказов у поставщиков
quantity | integer | None | YES | количество продукта

#### 2.17 Таблица `suppliers_`
Таблица поставщиков продуктов.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | serial | nextval('suppliers__id__seq'::regclass)| NO | идентификатор записи
supplier_name_ | varchar(50) | None| NO | наименование поставщика
address_ | varchar(255) | None| NO | адрес поставщика
phone_ | varchar(11) | None| NO | телефон поставщика
email_ | USER-DEFINED (email) | None| NO | email поставщика

#### 2.18 Таблица `tables_`
Таблица доступных столиков в ресторане.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | smallint | nextval('tables__id__seq'::regclass)| NO | идентификатор записи
table_num_ | smallint | None| NO | номер столика в ресторане

#### 2.19 Таблица `tables_reserve_`
Таблица заказа столиков в ресторне.

Column | Datatype | Default | Nullable | Комментарий
:---:|:---:|:---:|:---:| ---
id_ | smallint | nextval('tables_reserve__id__seq'::regclass)| NO | идентификатор записи
table_ID | integer | None| NO | внешний ключ к таблице столиков
isReserved | boolean | None| NO | есть/нет бронирование столика
owner_name_ | varchar(100) | None| NO | имя, на которое зарезервирован столик
owner_phone_ | varchar(11) | None| NO | телефон для связи с клиентом

### 3. Оптимизация

Произведена небольшоя оптимизация полей:
- `int8` -> `varchar(11)` для поля номера телефона
- паспорта вынесены в отдельную таблицу
- изменен тип данных, `money` вместо `decimal`
- `numeric` вместо `double precision` с определением размерность для веса
- varchar - везде указаны размерности полей в символах

### 4. Машинерия

Для создания документации на основе уже созданных таблиц БД PostgreSQL найден инструмент pg-table-markdown. Пакетным менеджером pip он не поставился, из-за требований совместимости, но из исходников с небольшими изменениями все заработало.

```bash
$ git clone https://github.com/vokal/pg-table-markdown.git
$ pip list | grep psycopg2
> 2.7.6.1
```
В файле `setup.py` нужно изменить номер версии с psycopg2 c 2.6 на 2.7.6.1.

```bash
$ python setup.py build && python setup.py install
$ pgtablemd --database_url postgres://postgres:postgres@localhost:5432/rest_db --max_length --output_file rest_db.md
```
