DROP database if exists rest_db;

CREATE database rest_db
LC_COLLATE 'ru_RU.utf8' LC_CTYPE 'ru_RU.utf8'
TEMPLATE template0;

SET DateStyle TO European;
SET timezone = 'Europe/Moscow';

-- UUID generator extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Additional datatype DOMAIN - email

CREATE EXTENSION citext;
CREATE DOMAIN email AS citext
  CHECK ( value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' );

-- ----------------------------
-- Sequence structure for city__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "city__id__seq";
CREATE SEQUENCE "city__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 32767
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for course__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "course__id__seq";
CREATE SEQUENCE "course__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for discount__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "discount__id__seq";
CREATE SEQUENCE "discount__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 32767
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for dish__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "dish__id__seq";
CREATE SEQUENCE "dish__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for metrics__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "metrics__id__seq";
CREATE SEQUENCE "metrics__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for order__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "order__id__seq";
CREATE SEQUENCE "order__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for payment_method__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "payment_method__id__seq";
CREATE SEQUENCE "payment_method__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 32767
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for position__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "position__id__seq";
CREATE SEQUENCE "position__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 32767
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for products__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "products__id__seq";
CREATE SEQUENCE "products__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for stuff__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "stuff__id__seq";
CREATE SEQUENCE "stuff__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for supplier_orders__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "supplier_orders__id__seq";
CREATE SEQUENCE "supplier_orders__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for suppliers__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "suppliers__id__seq";
CREATE SEQUENCE "suppliers__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for tables__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "tables__id__seq";
CREATE SEQUENCE "tables__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 32767
START 1
CACHE 1;


-- ----------------------------
-- Sequence structure for tables__id__seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "tables_reserve__id__seq";
CREATE SEQUENCE "tables_reserve__id__seq"
INCREMENT 1
MINVALUE  1
MAXVALUE 32767
START 1
CACHE 1;


CREATE TABLE "tables_reserve_" (
"id_" int2 NOT NULL DEFAULT nextval('tables_reserve__id__seq'::regclass),
"table_ID" int4 NOT NULL,
"isReserved" bool NOT NULL,
"owner_name_" varchar(255) COLLATE "default" NOT NULL,
"owner_phone_" int8 NOT NULL,
CONSTRAINT "tables_reserve__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "tables_reserve_" IS 'Таблица заказа столиков в ресторне.';
COMMENT ON COLUMN "tables_reserve_"."id_" IS 'идентификатор записи';
COMMENT ON COLUMN "tables_reserve_"."table_ID" IS 'внешний ключ к таблице столиков';
COMMENT ON COLUMN "tables_reserve_"."isReserved" IS 'есть/нет бронирование столика';
COMMENT ON COLUMN "tables_reserve_"."owner_name_" IS 'имя, на которое зарезервирован столик';
COMMENT ON COLUMN "tables_reserve_"."owner_phone_" IS 'телефон для связи с клиентом';
ALTER TABLE "tables_reserve_" OWNER TO "postgres";

CREATE TABLE "tables_" (
"id_" int2 NOT NULL DEFAULT nextval('tables__id__seq'::regclass),
"table_num_" int2 NOT NULL,
CONSTRAINT "tables__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "tables_" IS 'Таблица доступных столиков в ресторане.';
COMMENT ON COLUMN "tables_"."id_" IS 'идетификатор записи';
COMMENT ON COLUMN "tables_"."table_num_" IS 'номер столика в ресторане';
ALTER TABLE "tables_" OWNER TO "postgres";

CREATE TABLE "suppliers_" (
"id_" int4 NOT NULL DEFAULT nextval('suppliers__id__seq'::regclass),
"supplier_name_" varchar(255) COLLATE "default" NOT NULL,
"address_" varchar(255) COLLATE "default" NOT NULL,
"phone_" int8 NOT NULL,
"email_" "public"."email" NOT NULL,
CONSTRAINT "suppliers__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "suppliers_" IS 'Таблица поставщиков продуктов для ресторана.';
COMMENT ON COLUMN "suppliers_"."id_" IS 'идентификатор записи';
COMMENT ON COLUMN "suppliers_"."supplier_name_" IS 'наименование поставщика';
COMMENT ON COLUMN "suppliers_"."address_" IS 'адрес поставщика';
COMMENT ON COLUMN "suppliers_"."phone_" IS 'телефон поставщика';
COMMENT ON COLUMN "suppliers_"."email_" IS 'email поставщика';
ALTER TABLE "suppliers_" OWNER TO "postgres";

CREATE TABLE "supplier_orders_items" (
"product_id" int4 NOT NULL,
"order_id" int4 NOT NULL,
"quantity" int4,
CONSTRAINT "order_items_2__pkey" PRIMARY KEY ("product_id", "order_id")
)
WITHOUT OIDS;
COMMENT ON TABLE "supplier_orders_items" IS 'Служебная таблица для таблицы заказов у поставщиков. Каждый заказ может содержать несколько позиций.';
COMMENT ON COLUMN "supplier_orders_items"."product_id" IS 'внешний ключ к таблице продуктов';
COMMENT ON COLUMN "supplier_orders_items"."order_id" IS 'внешний ключ к таблице заказов у поставщиков';
COMMENT ON COLUMN "supplier_orders_items"."quantity" IS 'количество продукта';
ALTER TABLE "supplier_orders_items" OWNER TO "postgres";

CREATE TABLE "supplier_orders_" (
"id_" int4 NOT NULL DEFAULT nextval('supplier_orders__id__seq'::regclass),
"supplier_ID" int4 NOT NULL,
"UUID" varchar(255) COLLATE "default" NOT NULL DEFAULT uuid_generate_v4(),
"products_ID" int4 NOT NULL,
"quantity" int2 NOT NULL,
"metric_ID" int2 NOT NULL,
"price_" numeric(255) NOT NULL,
"timestamp" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT "supplier_orders__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "supplier_orders_" IS 'Таблица заказов продуктов у поставщиков.';
COMMENT ON COLUMN "supplier_orders_"."id_" IS 'идентификатор записи';
COMMENT ON COLUMN "supplier_orders_"."supplier_ID" IS 'внешний ключ к таблице поставщиков';
COMMENT ON COLUMN "supplier_orders_"."UUID" IS 'уникальный идентификатор заказа';
COMMENT ON COLUMN "supplier_orders_"."products_ID" IS 'внешний ключ к таблице продуктов';
COMMENT ON COLUMN "supplier_orders_"."quantity" IS 'количество продуктов';
COMMENT ON COLUMN "supplier_orders_"."metric_ID" IS 'внешний ключ к таблице размерностей продуктов';
COMMENT ON COLUMN "supplier_orders_"."price_" IS 'закупочная цена продукта';
COMMENT ON COLUMN "supplier_orders_"."timestamp" IS 'время создания записи';
ALTER TABLE "supplier_orders_" OWNER TO "postgres";

CREATE TABLE "stuff_" (
"id_" int4 NOT NULL DEFAULT nextval('stuff__id__seq'::regclass),
"name_" varchar(100) COLLATE "default" NOT NULL,
"surname_" varchar(100) COLLATE "default" NOT NULL,
"familyname_" varchar(100) COLLATE "default",
"passport_" varchar(50) COLLATE "default" NOT NULL,
"passport_photo_" varchar(255) COLLATE "default",
"phone_" int8 NOT NULL,
"email_" "public"."email" NOT NULL,
"city_ID" int4 NOT NULL,
"position_ID" int4 NOT NULL,
"UUID" varchar COLLATE "default" NOT NULL DEFAULT uuid_generate_v1(),
"timestamp_" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
"passport_issue_date_" date NOT NULL,
"passport_registration_address_" varchar(255) COLLATE "default" NOT NULL,
"release_date_" date NOT NULL,
"resignation_date_" date,
CONSTRAINT "stuff__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "stuff_" IS 'Таблица сотрудников ресторана.';
COMMENT ON COLUMN "stuff_"."id_" IS 'идетификатор записи';
COMMENT ON COLUMN "stuff_"."name_" IS 'имя сотрудника';
COMMENT ON COLUMN "stuff_"."surname_" IS 'фамилия сотрудника';
COMMENT ON COLUMN "stuff_"."familyname_" IS 'отчество сотрудника (если имеется)';
COMMENT ON COLUMN "stuff_"."passport_" IS 'номер и серия паспорта сотрудника';
COMMENT ON COLUMN "stuff_"."passport_photo_" IS 'имя файла с изображением паспорта';
COMMENT ON COLUMN "stuff_"."phone_" IS 'номер телефона сотрудника';
COMMENT ON COLUMN "stuff_"."email_" IS 'email сотрудника';
COMMENT ON COLUMN "stuff_"."city_ID" IS 'город проживания сотрудника';
COMMENT ON COLUMN "stuff_"."position_ID" IS 'должность сотрудника';
COMMENT ON COLUMN "stuff_"."UUID" IS 'уникальный идентификатор сотрудника';
COMMENT ON COLUMN "stuff_"."timestamp_" IS 'время создания записи о сотруднике';
COMMENT ON COLUMN "stuff_"."passport_issue_date_" IS 'дата выдачи паспорта сотрудника';
COMMENT ON COLUMN "stuff_"."passport_registration_address_" IS 'адрес регистрации сотрудника';
COMMENT ON COLUMN "stuff_"."release_date_" IS 'дата выхода на работу сотрудника';
COMMENT ON COLUMN "stuff_"."resignation_date_" IS 'дата увольнения сотрудника';
ALTER TABLE "stuff_" OWNER TO "postgres";

CREATE TABLE "products_" (
"id_" int4 NOT NULL DEFAULT nextval('products__id__seq'::regclass),
"product_name_" varchar(255) COLLATE "default" NOT NULL,
"UUID" varchar(255) COLLATE "default" NOT NULL DEFAULT uuid_generate_v1(),
CONSTRAINT "products__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "products_" IS 'Таблица продуктов.';
COMMENT ON COLUMN "products_"."id_" IS 'идентификатор записи';
COMMENT ON COLUMN "products_"."product_name_" IS 'наименование продукта';
COMMENT ON COLUMN "products_"."UUID" IS 'уникальный идетификатор продукта';
ALTER TABLE "products_" OWNER TO "postgres";

CREATE TABLE "product_items" (
"product_ID" int4 NOT NULL,
"supplier_ID" int4 NOT NULL,
CONSTRAINT "product_items__pkey" PRIMARY KEY ("product_ID", "supplier_ID")
)
WITHOUT OIDS;
COMMENT ON TABLE "product_items" IS 'Служебная таблица для связывания поставщика и продуктов, которые поставщик предоставляет ресторану.';
COMMENT ON COLUMN "product_items"."product_ID" IS 'внешний ключ к таблице продуктов';
COMMENT ON COLUMN "product_items"."supplier_ID" IS 'внешний ключ к таблице поставщиков продуктов';
ALTER TABLE "product_items" OWNER TO "postgres";

CREATE TABLE "position_" (
"id_" int2 NOT NULL DEFAULT nextval('position__id__seq'::regclass),
"position_name_" varchar(255) COLLATE "default" NOT NULL,
CONSTRAINT "position__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "position_" IS 'Таблица названия должностей в ресторане.';
COMMENT ON COLUMN "position_"."id_" IS 'идетификатор записи';
COMMENT ON COLUMN "position_"."position_name_" IS 'название должностей';
ALTER TABLE "position_" OWNER TO "postgres";

CREATE TABLE "payment_method_" (
"id_" int2 NOT NULL DEFAULT nextval('payment_method__id__seq'::regclass),
"method_" varchar(255) COLLATE "default" NOT NULL,
"isActive" bool NOT NULL DEFAULT false,
CONSTRAINT "payment_method__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "payment_method_" IS 'Таблица возможных способов оплаты в ресторане.';
COMMENT ON COLUMN "payment_method_"."id_" IS 'идентификатор записи';
COMMENT ON COLUMN "payment_method_"."method_" IS 'способ оплаты';
COMMENT ON COLUMN "payment_method_"."isActive" IS 'доступен/недоступен для использования';
ALTER TABLE "payment_method_" OWNER TO "postgres";

CREATE TABLE "orders_course_items" (
"order_ID" int4 NOT NULL,
"course_ID" int4 NOT NULL,
"quantity_" int2 NOT NULL,
CONSTRAINT "order_to_course__pkey" PRIMARY KEY ("order_ID", "course_ID")
)
WITHOUT OIDS;
COMMENT ON TABLE "orders_course_items" IS 'Служебная таблица для таблицы заказов. Каждый заказ может содержать несколько позиций.';
COMMENT ON COLUMN "orders_course_items"."order_ID" IS 'внешний ключ к таблице заказов';
COMMENT ON COLUMN "orders_course_items"."course_ID" IS 'внешний ключ к таблице блюд в меню';
COMMENT ON COLUMN "orders_course_items"."quantity_" IS 'количество блюд';
ALTER TABLE "orders_course_items" OWNER TO "postgres";

CREATE TABLE "orders_course_" (
"id_" int4 NOT NULL DEFAULT nextval('order__id__seq'::regclass),
"UUID" varchar(255) COLLATE "default" NOT NULL DEFAULT uuid_generate_v4(),
"table_ID" int4 NOT NULL,
"payment_method_ID" int4 NOT NULL,
"time_start_" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
"time_end_" timestamptz(6),
"isCancelled" bool NOT NULL DEFAULT false,
"isPayed" bool NOT NULL DEFAULT false,
"stuff_ID" int4,
"isClosed" bool DEFAULT false,
CONSTRAINT "order__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "orders_course_" IS 'Таблица заказов блюд в ресторане.';
COMMENT ON COLUMN "orders_course_"."id_" IS 'идетификатор записи';
COMMENT ON COLUMN "orders_course_"."UUID" IS 'уникальный идетификатор заказа';
COMMENT ON COLUMN "orders_course_"."table_ID" IS 'внешний ключ к таблице столиков в ресторане';
COMMENT ON COLUMN "orders_course_"."payment_method_ID" IS 'внешний ключ к таблице способов оплаты';
COMMENT ON COLUMN "orders_course_"."time_start_" IS 'время открытия заказа';
COMMENT ON COLUMN "orders_course_"."time_end_" IS 'время закрытия заказа';
COMMENT ON COLUMN "orders_course_"."isCancelled" IS 'факт отмена заказа';
COMMENT ON COLUMN "orders_course_"."isPayed" IS 'факт оплаты заказа';
COMMENT ON COLUMN "orders_course_"."stuff_ID" IS 'внешний ключ к таблице сотрудников, обслуживающих столик';
COMMENT ON COLUMN "orders_course_"."isClosed" IS 'факт закрытия заказа';
ALTER TABLE "orders_course_" OWNER TO "postgres";

CREATE TABLE "metrics_" (
"id_" int4 NOT NULL DEFAULT nextval('metrics__id__seq'::regclass),
"metric_" varchar(255) COLLATE "default" NOT NULL,
"weight_of_packing_" float8,
CONSTRAINT "metrics__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "metrics_" IS 'Таблица размерностей для продуктов.';
COMMENT ON COLUMN "metrics_"."id_" IS 'идетификатор записи';
COMMENT ON COLUMN "metrics_"."metric_" IS 'размерность величин - упаковка, килограмм';
COMMENT ON COLUMN "metrics_"."weight_of_packing_" IS 'вес упаковки';
ALTER TABLE "metrics_" OWNER TO "postgres";

CREATE TABLE "dish_items" (
"product_id" int4 NOT NULL,
"dish_id" int4 NOT NULL,
"quiantity_" int2,
CONSTRAINT "dish_items_pkey" PRIMARY KEY ("product_id", "dish_id")
)
WITHOUT OIDS;
COMMENT ON TABLE "dish_items" IS 'Блюдо приготовлено и некоторого количества продуктов. Служебная таблица, предназначена для списка продуктов, которое включает конкретное блюдо.';
COMMENT ON COLUMN "dish_items"."product_id" IS 'внешний ключ к таблице продуктов';
COMMENT ON COLUMN "dish_items"."dish_id" IS 'внешний ключ к таблице блюд';
COMMENT ON COLUMN "dish_items"."quiantity_" IS 'вес продукта в граммах';
ALTER TABLE "dish_items" OWNER TO "postgres";

CREATE TABLE "dish_" (
"id_" int4 NOT NULL DEFAULT nextval('dish__id__seq'::regclass),
"dish_" varchar(255) COLLATE "default" NOT NULL,
"price_" numeric(255) NOT NULL,
"isActive" bool NOT NULL DEFAULT false,
CONSTRAINT "dish__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "dish_" IS 'Таблица действующих блюд в ресторане.';
COMMENT ON COLUMN "dish_"."id_" IS 'идентификатор записи';
COMMENT ON COLUMN "dish_"."dish_" IS 'название блюда';
COMMENT ON COLUMN "dish_"."price_" IS 'стоимость блюда';
COMMENT ON COLUMN "dish_"."isActive" IS 'возможность/не возможность приготовления';
ALTER TABLE "dish_" OWNER TO "postgres";

CREATE TABLE "discount_" (
"id_" int2 NOT NULL DEFAULT nextval('discount__id__seq'::regclass),
"quantity_" int2 NOT NULL,
CONSTRAINT "discount__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "discount_" IS 'Таблица действующих скидок в ресторане.';
COMMENT ON COLUMN "discount_"."id_" IS 'идентификатор записи';
COMMENT ON COLUMN "discount_"."quantity_" IS 'величина скидки в процентах';
ALTER TABLE "discount_" OWNER TO "postgres";

CREATE TABLE "course_" (
"id_" int4 NOT NULL DEFAULT nextval('course__id__seq'::regclass),
"dish_ID" int4 NOT NULL,
"discount_ID" int4 NOT NULL,
"hasDiscout" bool NOT NULL DEFAULT false,
"isActive" bool NOT NULL DEFAULT false,
CONSTRAINT "course__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "course_" IS 'Таблица текущего меню ресторана.';
COMMENT ON COLUMN "course_"."id_" IS 'идентификатор записи';
COMMENT ON COLUMN "course_"."dish_ID" IS 'внешний ключ к таблице блюд';
COMMENT ON COLUMN "course_"."discount_ID" IS 'внешний ключ к таблице скидок';
COMMENT ON COLUMN "course_"."hasDiscout" IS 'есть/нет скидка на блюдо';
COMMENT ON COLUMN "course_"."isActive" IS 'блюдо доступно/не доступно для заказа';
ALTER TABLE "course_" OWNER TO "postgres";

CREATE TABLE "city_" (
"id_" int2 NOT NULL DEFAULT nextval('city__id__seq'::regclass),
"city_name_" varchar(255) COLLATE "default" NOT NULL,
CONSTRAINT "city__pkey" PRIMARY KEY ("id_")
)
WITHOUT OIDS;
COMMENT ON TABLE "city_" IS 'Таблица содержит список городов, в которых проживают сотрудники ресторана.';
COMMENT ON COLUMN "city_"."id_" IS 'идетификатор записи';
COMMENT ON COLUMN "city_"."city_name_" IS 'название города';
ALTER TABLE "city_" OWNER TO "postgres";

CREATE TABLE "passports_" (
"id_" serial2 NOT NULL,
"passport_" varchar(255) NOT NULL,
"passport_photo_" varchar(255) NOT NULL,
"passport_issue_date_" date NOT NULL,
"passport_registration_address_" varchar(255) NOT NULL,
PRIMARY KEY ("id_", "passport_")
)
WITHOUT OIDS;

ALTER TABLE "tables_reserve_" ADD CONSTRAINT "tables_reserve__tables_id_fkey" FOREIGN KEY ("table_ID") REFERENCES "tables_" ("id_") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "supplier_orders_items" ADD CONSTRAINT "supplier_orders_items_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "supplier_orders_" ("id_") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "supplier_orders_items" ADD CONSTRAINT "supplier_orders_items_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products_" ("id_") ON DELETE RESTRICT ON UPDATE NO ACTION;
ALTER TABLE "product_items" ADD CONSTRAINT "product_items_suppliers_id_fkey" FOREIGN KEY ("supplier_ID") REFERENCES "suppliers_" ("id_") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "product_items" ADD CONSTRAINT "product_items_products_id_fkey" FOREIGN KEY ("product_ID") REFERENCES "products_" ("id_") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "stuff_" ADD CONSTRAINT "stuff__position_id_fkey" FOREIGN KEY ("position_ID") REFERENCES "position_" ("id_") ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE "orders_course_items" ADD CONSTRAINT "orders_course_items_orders_course_id_fkey" FOREIGN KEY ("order_ID") REFERENCES "orders_course_" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "orders_course_" ADD CONSTRAINT "orders_course__table_id_fkey" FOREIGN KEY ("table_ID") REFERENCES "tables_" ("id_") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "orders_course_" ADD CONSTRAINT "orders_course__stuff_id_fkey" FOREIGN KEY ("stuff_ID") REFERENCES "stuff_" ("id_") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "orders_course_" ADD CONSTRAINT "orders_course__payment_method_id_fkey" FOREIGN KEY ("payment_method_ID") REFERENCES "payment_method_" ("id_") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "supplier_orders_" ADD CONSTRAINT "supplier_orders__metrics_id_fkey" FOREIGN KEY ("metric_ID") REFERENCES "metrics_" ("id_") ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE "dish_items" ADD CONSTRAINT "dish_items_products_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products_" ("id_") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "dish_items" ADD CONSTRAINT "dish_items_dish_id_fkey" FOREIGN KEY ("dish_id") REFERENCES "dish_" ("id_") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "orders_course_items" ADD CONSTRAINT "orders_course_items_course_id_fkey" FOREIGN KEY ("course_ID") REFERENCES "course_" ("id_") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "course_" ADD CONSTRAINT "course__dish_id_fkey" FOREIGN KEY ("dish_ID") REFERENCES "dish_" ("id_") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "course_" ADD CONSTRAINT "course__discount_id_fkey" FOREIGN KEY ("discount_ID") REFERENCES "discount_" ("id_") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "stuff_" ADD CONSTRAINT "stuff__city_id_fkey" FOREIGN KEY ("city_ID") REFERENCES "city_" ("id_") ON DELETE NO ACTION ON UPDATE CASCADE;

