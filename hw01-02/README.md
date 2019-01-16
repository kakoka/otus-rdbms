#### 1. Общая таблица примененных типов данных (на примере PostgreSQL).

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

#### Таблица `city_`

Cодержит список городов, в которых проживают сотрудники ресторана. Список поселенийв одной локации не может быть слишком большим, а название города слишком длинным, отсюда и выбор данных типов.

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | serial2 | nextval('city__id__seq'::regclass) | NO | идетификатор записи 
city_name_ | varchar(30) | None | NO | название города 

#### Таблица `course_`

Таблица текущего меню ресторана.

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | serial | nextval('course__id__seq'::regclass)| NO | идентификатор записи
dish_ID | integer | None| NO | внешний ключ к таблице блюд `dish_`
discount_ID | integer | None| NO | внешний ключ к таблице блюд `discount_`
hasDiscout | boolean | false| NO | 'есть'/'нет' скидка на блюдо
isActive | boolean | false| NO | блюдо 'доступно'/'не доступно' для заказа

#### Таблица `discount_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | serial4 | nextval('discount__id__seq'::regclass)| NO | идентификатор записи
quantity_ | smallint | None | NO |

#### Таблица `dish_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | serial | nextval('dish__id__seq'::regclass)| NO | идентификатор записи
dish_ | varchar(100) | None| NO |
price_ | money | None| NO |
isActive | boolean | false| NO |

#### Таблица `dish_items 

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
product_id | integer | None| NO |
dish_id | integer | None| NO |
quiantity_ | smallint | None | YES |

#### Таблица `metrics_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | serial | nextval('metrics__id__seq'::regclass)| NO | идентификатор записи
metric_ | varchar(4) | None| NO |
weight_of_packing_ | numeric | None | YES |

#### Таблица `orders_course_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | serial | nextval('order__id__seq'::regclass)| NO | идентификатор записи
UUID | varchar(255) | uuid_generate_v4()| NO |
table_ID | integer | None| NO |
payment_method_ID | integer | None| NO |
time_start_ | timestamp with time zone | CURRENT_TIMESTAMP| NO |
time_end_ | timestamp with time zone | None | YES |
isCancelled | boolean | false| NO |
isPayed | boolean | false| NO |
stuff_ID | integer | None | YES |
isClosed | boolean | false | YES |

#### Таблица `orders_course_items 

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
order_ID | integer | None| NO |
course_ID | integer | None| NO |
quantity_ | smallint | None| NO |

#### Таблица `passports_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | serial | nextval('passports__id__seq'::regclass)| NO | идентификатор записи
passport_ | varchar() | None| NO |
passport_photo_ | varchar() | None| NO |
passport_issue_date_ | date | None| NO |
passport_registration_address_ | varchar() | None| NO |

#### Таблица `payment_method_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | smallint | nextval('payment_method__id__seq'::regclass)| NO | идентификатор записи
method_ | varchar() | None| NO |
isActive | boolean | false| NO |

#### Таблица `position_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | smallint | nextval('position__id__seq'::regclass)| NO | идентификатор записи
position_name_ | varchar() | None| NO |

#### Таблица `product_items 

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
product_ID | integer | None| NO |
supplier_ID | integer | None| NO |

#### Таблица `products_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | serial | nextval('products__id__seq'::regclass)| NO | идентификатор записи
product_name_ | varchar() | None| NO |
UUID | varchar() | uuid_generate_v1()| NO |

#### Таблица `stuff_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | serial | nextval('stuff__id__seq'::regclass)| NO | идентификатор записи
name_ | varchar() | None| NO |
surname_ | varchar() | None| NO |
familyname_ | varchar() | None | YES |
phone_ | varchar(11) | None| NO |
email_ | USER-DEFINED | None| NO |
city_ID | integer | None| NO |
position_ID | integer | None| NO |
UUID | varchar() | uuid_generate_v1()| NO |
timestamp_ | timestamp with time zone | CURRENT_TIMESTAMP| NO |
release_date_ | date | None| NO |
resignation_date_ | date | None | YES |
passport_ID | integer | None| NO |

#### Таблица `supplier_orders_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | serial | nextval('supplier_orders__id__seq'::regclass)| NO | идентификатор записи
supplier_ID | integer | None| NO |
UUID | varchar() | uuid_generate_v4()| NO |
products_ID | integer | None| NO |
quantity | smallint | None| NO |
metric_ID | smallint | None| NO |
price_ | money | None| NO |
timestamp | timestamp with time zone | CURRENT_TIMESTAMP| NO |

#### Таблица `supplier_orders_items 

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
product_id | integer | None| NO |
order_id | integer | None| NO |
quantity | integer | None | YES |

#### Таблица `suppliers_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | serial | nextval('suppliers__id__seq'::regclass)| NO | идентификатор записи
supplier_name_ | varchar() | None| NO |
address_ | varchar() | None| NO |
phone_ | varchar(11) | None| NO |
email_ | USER-DEFINED | None| NO |

#### Таблица `tables_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | smallint | nextval('tables__id__seq'::regclass)| NO | идентификатор записи
table_num_ | smallint | None| NO |

#### Таблица `tables_reserve_`

Column | Datatype | Default | Nullable | Комментарий 
:---:|:---:|:---:|:---:| --- 
id_ | smallint | nextval('tables_reserve__id__seq'::regclass)| NO | идентификатор записи
table_ID | integer | None| NO |
isReserved | boolean | None| NO |
owner_name_ | varchar() | None| NO |
owner_phone_ | bigint | None| NO |

### 3. Оптимизация
int8 -> varchar(11)
паспорта в отдельную таблицу
тип данных money вместо decimal

### 4. Машинерия

```
git clone https://github.com/vokal/pg-table-markdown.git
pip list | grep psycopg2
> 2.7.6.1
vi setup.py 2.6 --> 2.7.6.1
python setup.py build && python setup.py install
pgtablemd --database_url postgres://postgres:postgres@localhost:5432/rest_db --max_length --output_file rest_db.md
```