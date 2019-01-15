-- ----------------------------
-- Table structure for city_
-- ----------------------------
DROP TABLE IF EXISTS "city_";
CREATE TABLE "city_" (
  "id_" int2 NOT NULL DEFAULT nextval('city__id__seq'::regclass),
  "city_name_" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "city_"."city_name_" IS 'Название города';

-- ----------------------------
-- Records of city_
-- ----------------------------
BEGIN;
INSERT INTO "city_" VALUES (1, 'Москва');
INSERT INTO "city_" VALUES (2, 'Истра');
INSERT INTO "city_" VALUES (3, 'Воскресенск');
COMMIT;

-- ----------------------------
-- Table structure for course_
-- ----------------------------
DROP TABLE IF EXISTS "course_";
CREATE TABLE "course_" (
  "id_" int4 NOT NULL DEFAULT nextval('course__id__seq'::regclass),
  "dish_ID" int4 NOT NULL,
  "discount_ID" int4 NOT NULL,
  "hasDiscout" bool NOT NULL DEFAULT false,
  "isActive" bool NOT NULL DEFAULT false
)
;

-- ----------------------------
-- Table structure for discount_
-- ----------------------------
DROP TABLE IF EXISTS "discount_";
CREATE TABLE "discount_" (
  "id_" int2 NOT NULL DEFAULT nextval('discount__id__seq'::regclass),
  "quantity" int2 NOT NULL
)
;

-- ----------------------------
-- Records of discount_
-- ----------------------------
BEGIN;
INSERT INTO "discount_" VALUES (1, 10);
INSERT INTO "discount_" VALUES (2, 20);
INSERT INTO "discount_" VALUES (3, 30);
COMMIT;

-- ----------------------------
-- Table structure for dish_
-- ----------------------------
DROP TABLE IF EXISTS "dish_";
CREATE TABLE "dish_" (
  "id_" int4 NOT NULL DEFAULT nextval('dish__id__seq'::regclass),
  "dish_" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "price_" numeric(255) NOT NULL,
  "isActive" bool NOT NULL DEFAULT false
)
;

-- ----------------------------
-- Table structure for dish_items
-- ----------------------------
DROP TABLE IF EXISTS "dish_items";
CREATE TABLE "dish_items" (
  "product_id" int4 NOT NULL,
  "dish_id" int4 NOT NULL,
  "quiantity_" int2
)
;

-- ----------------------------
-- Table structure for metrics_
-- ----------------------------
DROP TABLE IF EXISTS "metrics_";
CREATE TABLE "metrics_" (
  "id_" int4 NOT NULL DEFAULT nextval('metrics__id__seq'::regclass),
  "metric" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of metrics_
-- ----------------------------
BEGIN;
INSERT INTO "metrics_" VALUES (1, 'грамм');
INSERT INTO "metrics_" VALUES (2, 'штук');
COMMIT;

-- ----------------------------
-- Table structure for orders_course_
-- ----------------------------
DROP TABLE IF EXISTS "orders_course_";
CREATE TABLE "orders_course_" (
  "id_" int4 NOT NULL DEFAULT nextval('order__id__seq'::regclass),
  "UUID_" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT uuid_generate_v4(),
  "table_ID" int4 NOT NULL,
  "payment_method_ID" int4 NOT NULL,
  "time_start_" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "time_end_" timestamptz(6),
  "isCancelled" bool NOT NULL DEFAULT false,
  "isPayed" bool NOT NULL DEFAULT false,
  "stuff_ID" int4,
  "isClosed" bool DEFAULT false
)
;

-- ----------------------------
-- Table structure for orders_course_items
-- ----------------------------
DROP TABLE IF EXISTS "orders_course_items";
CREATE TABLE "orders_course_items" (
  "order_ID" int4 NOT NULL,
  "course_ID" int4 NOT NULL,
  "quantity_" int2 NOT NULL
)
;

-- ----------------------------
-- Table structure for payment_method_
-- ----------------------------
DROP TABLE IF EXISTS "payment_method_";
CREATE TABLE "payment_method_" (
  "id_" int2 NOT NULL DEFAULT nextval('payment_method__id__seq'::regclass),
  "method_" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for position_
-- ----------------------------
DROP TABLE IF EXISTS "position_";
CREATE TABLE "position_" (
  "id_" int2 NOT NULL DEFAULT nextval('position__id__seq'::regclass),
  "position_name_" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "position_"."position_name_" IS 'Название должности';

-- ----------------------------
-- Records of position_
-- ----------------------------
BEGIN;
INSERT INTO "position_" VALUES (1, 'официант');
INSERT INTO "position_" VALUES (2, 'кассир');
INSERT INTO "position_" VALUES (3, 'директор');
COMMIT;

-- ----------------------------
-- Table structure for product_items
-- ----------------------------
DROP TABLE IF EXISTS "product_items";
CREATE TABLE "product_items" (
  "product_ID" int4 NOT NULL,
  "supplier_ID" int4 NOT NULL
)
;

-- ----------------------------
-- Table structure for products_
-- ----------------------------
DROP TABLE IF EXISTS "products_";
CREATE TABLE "products_" (
  "id_" int4 NOT NULL DEFAULT nextval('products__id__seq'::regclass),
  "product_name_" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of products_
-- ----------------------------
BEGIN;
INSERT INTO "products_" VALUES (1, 'помидоры');
INSERT INTO "products_" VALUES (2, 'огурцы');
INSERT INTO "products_" VALUES (3, 'масло');
INSERT INTO "products_" VALUES (4, 'куриное филе');
INSERT INTO "products_" VALUES (5, 'сахар');
COMMIT;

-- ----------------------------
-- Table structure for stuff_
-- ----------------------------
DROP TABLE IF EXISTS "stuff_";
CREATE TABLE "stuff_" (
  "id_" int4 NOT NULL DEFAULT nextval('stuff__id__seq'::regclass),
  "name_" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "surname_" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "familyname_" varchar(100) COLLATE "pg_catalog"."default",
  "passport_" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "passport_photo_" varchar(255) COLLATE "pg_catalog"."default",
  "phone_" int8 NOT NULL,
  "email_" "public"."email" COLLATE "pg_catalog"."default" NOT NULL,
  "city_ID" int4 NOT NULL,
  "position_ID" int4 NOT NULL,
  "UUID" varchar COLLATE "pg_catalog"."default" NOT NULL DEFAULT uuid_generate_v1(),
  "timestamp_" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "stuff_"."name_" IS 'Имя';
COMMENT ON COLUMN "stuff_"."surname_" IS 'Фамилия';
COMMENT ON COLUMN "stuff_"."familyname_" IS 'Отчество';
COMMENT ON COLUMN "stuff_"."passport_" IS 'Номер паспорта';
COMMENT ON COLUMN "stuff_"."passport_photo_" IS 'Имя файла с изображением паспорта';
COMMENT ON COLUMN "stuff_"."phone_" IS 'номер телефона';
COMMENT ON COLUMN "stuff_"."email_" IS 'email';
COMMENT ON COLUMN "stuff_"."city_ID" IS 'город, где живет';
COMMENT ON COLUMN "stuff_"."position_ID" IS 'должность';
COMMENT ON COLUMN "stuff_"."UUID" IS 'UUID';
COMMENT ON COLUMN "stuff_"."timestamp_" IS 'timestamp';

-- ----------------------------
-- Records of stuff_
-- ----------------------------
BEGIN;
INSERT INTO "stuff_" VALUES (1, 'Григорий', 'Максимов', 'Витальевич', '4501289651', '4501289651.jpg', 79101234567, 'ka@ru.ru', 1, 1, '62f29a0c-172f-11e9-b56a-0242ac110002', '2019-01-13 12:33:10.2469+00');
INSERT INTO "stuff_" VALUES (3, 'Павел', 'Иванов', NULL, '4210789654', 'qwe.jpg', 79881213223, 'asda@s.eu', 2, 2, '454a39aa-1730-11e9-b56a-0242ac110002', '2019-01-13 12:39:29.986876+00');
COMMIT;

-- ----------------------------
-- Table structure for supplier_orders_
-- ----------------------------
DROP TABLE IF EXISTS "supplier_orders_";
CREATE TABLE "supplier_orders_" (
  "id_" int4 NOT NULL DEFAULT nextval('supplier_orders__id__seq'::regclass),
  "supplier_ID" int4 NOT NULL,
  "UUID_" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT uuid_generate_v4(),
  "products_ID" int4 NOT NULL,
  "quantity" int2 NOT NULL,
  "metric_ID" int2 NOT NULL,
  "price_" numeric(255) NOT NULL,
  "timestamp" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of supplier_orders_
-- ----------------------------
BEGIN;
INSERT INTO "supplier_orders_" VALUES (2, 1, '52edcb7a-8287-4ced-99b0-2efb4df736e0', 1, 1, 1, 5, '2019-01-13 19:39:37.089155+00');
INSERT INTO "supplier_orders_" VALUES (3, 1, 'a38eadac-e795-4820-ab69-d13bf244dca6', 3, 3, 2, 10, '2019-01-13 19:39:37.089155+00');
COMMIT;

-- ----------------------------
-- Table structure for supplier_orders_items
-- ----------------------------
DROP TABLE IF EXISTS "supplier_orders_items";
CREATE TABLE "supplier_orders_items" (
  "product_id" int4 NOT NULL,
  "order_id" int4 NOT NULL,
  "quantity" int4
)
;

-- ----------------------------
-- Table structure for suppliers_
-- ----------------------------
DROP TABLE IF EXISTS "suppliers_";
CREATE TABLE "suppliers_" (
  "id_" int4 NOT NULL DEFAULT nextval('suppliers__id__seq'::regclass),
  "supplier_name_" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "address_" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "phone_" int8 NOT NULL,
  "email_" "public"."email" COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of suppliers_
-- ----------------------------
BEGIN;
INSERT INTO "suppliers_" VALUES (1, 'ИП Петров', 'Петровка 38', 79214568787, 'ptrov@petrov.ru');
INSERT INTO "suppliers_" VALUES (2, 'Ашан', 'Марфино 7', 74952223222, 'auchan@auchan.ru');
COMMIT;

-- ----------------------------
-- Table structure for tables_
-- ----------------------------
DROP TABLE IF EXISTS "tables_";
CREATE TABLE "tables_" (
  "id_" int2 NOT NULL DEFAULT nextval('tables__id__seq'::regclass),
  "table_num_" int2 NOT NULL
)
;