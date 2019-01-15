/*
 Navicat Premium Data Transfer

 Source Server         : test
 Source Server Type    : PostgreSQL
 Source Server Version : 110001
 Source Host           : localhost:5432
 Source Catalog        : test
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 110001
 File Encoding         : 65001

 Date: 14/01/2019 18:02:45
*/


-- ----------------------------
-- Type structure for citext
-- ----------------------------
DROP TYPE IF EXISTS "citext";
CREATE TYPE "citext" (
  INPUT = "public"."citextin",
  OUTPUT = "public"."citextout",
  RECEIVE = "public"."citextrecv",
  SEND = "public"."citextsend",
  INTERNALLENGTH = VARIABLE,
  STORAGE = extended,
  CATEGORY = S,
  DELIMITER = ',',
  COLLATABLE = true
);

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

-- ----------------------------
-- Function structure for citext
-- ----------------------------
DROP FUNCTION IF EXISTS "citext"(bpchar);
CREATE OR REPLACE FUNCTION "citext"(bpchar)
  RETURNS "public"."citext" AS $BODY$rtrim1$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext
-- ----------------------------
DROP FUNCTION IF EXISTS "citext"(inet);
CREATE OR REPLACE FUNCTION "citext"(inet)
  RETURNS "public"."citext" AS $BODY$network_show$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext
-- ----------------------------
DROP FUNCTION IF EXISTS "citext"(bool);
CREATE OR REPLACE FUNCTION "citext"(bool)
  RETURNS "public"."citext" AS $BODY$booltext$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_cmp
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_cmp"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_cmp"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."int4" AS '$libdir/citext', 'citext_cmp'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_eq
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_eq"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_eq"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS '$libdir/citext', 'citext_eq'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_ge
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_ge"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_ge"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS '$libdir/citext', 'citext_ge'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_gt
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_gt"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_gt"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS '$libdir/citext', 'citext_gt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_hash
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_hash"("public"."citext");
CREATE OR REPLACE FUNCTION "citext_hash"("public"."citext")
  RETURNS "pg_catalog"."int4" AS '$libdir/citext', 'citext_hash'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_larger
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_larger"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_larger"("public"."citext", "public"."citext")
  RETURNS "public"."citext" AS '$libdir/citext', 'citext_larger'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_le
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_le"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_le"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS '$libdir/citext', 'citext_le'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_lt
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_lt"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_lt"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS '$libdir/citext', 'citext_lt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_ne
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_ne"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_ne"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS '$libdir/citext', 'citext_ne'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_pattern_cmp
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_pattern_cmp"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_pattern_cmp"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."int4" AS '$libdir/citext', 'citext_pattern_cmp'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_pattern_ge
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_pattern_ge"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_pattern_ge"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS '$libdir/citext', 'citext_pattern_ge'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_pattern_gt
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_pattern_gt"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_pattern_gt"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS '$libdir/citext', 'citext_pattern_gt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_pattern_le
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_pattern_le"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_pattern_le"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS '$libdir/citext', 'citext_pattern_le'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_pattern_lt
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_pattern_lt"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_pattern_lt"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS '$libdir/citext', 'citext_pattern_lt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citext_smaller
-- ----------------------------
DROP FUNCTION IF EXISTS "citext_smaller"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "citext_smaller"("public"."citext", "public"."citext")
  RETURNS "public"."citext" AS '$libdir/citext', 'citext_smaller'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citextin
-- ----------------------------
DROP FUNCTION IF EXISTS "citextin"(cstring);
CREATE OR REPLACE FUNCTION "citextin"(cstring)
  RETURNS "public"."citext" AS $BODY$textin$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citextout
-- ----------------------------
DROP FUNCTION IF EXISTS "citextout"("public"."citext");
CREATE OR REPLACE FUNCTION "citextout"("public"."citext")
  RETURNS "pg_catalog"."cstring" AS $BODY$textout$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citextrecv
-- ----------------------------
DROP FUNCTION IF EXISTS "citextrecv"(internal);
CREATE OR REPLACE FUNCTION "citextrecv"(internal)
  RETURNS "public"."citext" AS $BODY$textrecv$BODY$
  LANGUAGE internal STABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for citextsend
-- ----------------------------
DROP FUNCTION IF EXISTS "citextsend"("public"."citext");
CREATE OR REPLACE FUNCTION "citextsend"("public"."citext")
  RETURNS "pg_catalog"."bytea" AS $BODY$textsend$BODY$
  LANGUAGE internal STABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for regexp_match
-- ----------------------------
DROP FUNCTION IF EXISTS "regexp_match"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "regexp_match"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."_text" AS $BODY$
    SELECT pg_catalog.regexp_match( $1::pg_catalog.text, $2::pg_catalog.text, 'i' );
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100;

-- ----------------------------
-- Function structure for regexp_match
-- ----------------------------
DROP FUNCTION IF EXISTS "regexp_match"("public"."citext", "public"."citext", text);
CREATE OR REPLACE FUNCTION "regexp_match"("public"."citext", "public"."citext", text)
  RETURNS "pg_catalog"."_text" AS $BODY$
    SELECT pg_catalog.regexp_match( $1::pg_catalog.text, $2::pg_catalog.text, CASE WHEN pg_catalog.strpos($3, 'c') = 0 THEN  $3 || 'i' ELSE $3 END );
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100;

-- ----------------------------
-- Function structure for regexp_matches
-- ----------------------------
DROP FUNCTION IF EXISTS "regexp_matches"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "regexp_matches"("public"."citext", "public"."citext")
  RETURNS SETOF "pg_catalog"."_text" AS $BODY$
    SELECT pg_catalog.regexp_matches( $1::pg_catalog.text, $2::pg_catalog.text, 'i' );
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100
  ROWS 1;

-- ----------------------------
-- Function structure for regexp_matches
-- ----------------------------
DROP FUNCTION IF EXISTS "regexp_matches"("public"."citext", "public"."citext", text);
CREATE OR REPLACE FUNCTION "regexp_matches"("public"."citext", "public"."citext", text)
  RETURNS SETOF "pg_catalog"."_text" AS $BODY$
    SELECT pg_catalog.regexp_matches( $1::pg_catalog.text, $2::pg_catalog.text, CASE WHEN pg_catalog.strpos($3, 'c') = 0 THEN  $3 || 'i' ELSE $3 END );
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100
  ROWS 10;

-- ----------------------------
-- Function structure for regexp_replace
-- ----------------------------
DROP FUNCTION IF EXISTS "regexp_replace"("public"."citext", "public"."citext", text, text);
CREATE OR REPLACE FUNCTION "regexp_replace"("public"."citext", "public"."citext", text, text)
  RETURNS "pg_catalog"."text" AS $BODY$
    SELECT pg_catalog.regexp_replace( $1::pg_catalog.text, $2::pg_catalog.text, $3, CASE WHEN pg_catalog.strpos($4, 'c') = 0 THEN  $4 || 'i' ELSE $4 END);
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100;

-- ----------------------------
-- Function structure for regexp_replace
-- ----------------------------
DROP FUNCTION IF EXISTS "regexp_replace"("public"."citext", "public"."citext", text);
CREATE OR REPLACE FUNCTION "regexp_replace"("public"."citext", "public"."citext", text)
  RETURNS "pg_catalog"."text" AS $BODY$
    SELECT pg_catalog.regexp_replace( $1::pg_catalog.text, $2::pg_catalog.text, $3, 'i');
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100;

-- ----------------------------
-- Function structure for regexp_split_to_array
-- ----------------------------
DROP FUNCTION IF EXISTS "regexp_split_to_array"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "regexp_split_to_array"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."_text" AS $BODY$
    SELECT pg_catalog.regexp_split_to_array( $1::pg_catalog.text, $2::pg_catalog.text, 'i' );
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100;

-- ----------------------------
-- Function structure for regexp_split_to_array
-- ----------------------------
DROP FUNCTION IF EXISTS "regexp_split_to_array"("public"."citext", "public"."citext", text);
CREATE OR REPLACE FUNCTION "regexp_split_to_array"("public"."citext", "public"."citext", text)
  RETURNS "pg_catalog"."_text" AS $BODY$
    SELECT pg_catalog.regexp_split_to_array( $1::pg_catalog.text, $2::pg_catalog.text, CASE WHEN pg_catalog.strpos($3, 'c') = 0 THEN  $3 || 'i' ELSE $3 END );
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100;

-- ----------------------------
-- Function structure for regexp_split_to_table
-- ----------------------------
DROP FUNCTION IF EXISTS "regexp_split_to_table"("public"."citext", "public"."citext", text);
CREATE OR REPLACE FUNCTION "regexp_split_to_table"("public"."citext", "public"."citext", text)
  RETURNS SETOF "pg_catalog"."text" AS $BODY$
    SELECT pg_catalog.regexp_split_to_table( $1::pg_catalog.text, $2::pg_catalog.text, CASE WHEN pg_catalog.strpos($3, 'c') = 0 THEN  $3 || 'i' ELSE $3 END );
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for regexp_split_to_table
-- ----------------------------
DROP FUNCTION IF EXISTS "regexp_split_to_table"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "regexp_split_to_table"("public"."citext", "public"."citext")
  RETURNS SETOF "pg_catalog"."text" AS $BODY$
    SELECT pg_catalog.regexp_split_to_table( $1::pg_catalog.text, $2::pg_catalog.text, 'i' );
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for replace
-- ----------------------------
DROP FUNCTION IF EXISTS "replace"("public"."citext", "public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "replace"("public"."citext", "public"."citext", "public"."citext")
  RETURNS "pg_catalog"."text" AS $BODY$
    SELECT pg_catalog.regexp_replace( $1::pg_catalog.text, pg_catalog.regexp_replace($2::pg_catalog.text, '([^a-zA-Z_0-9])', E'\\\\\\1', 'g'), $3::pg_catalog.text, 'gi' );
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100;

-- ----------------------------
-- Function structure for split_part
-- ----------------------------
DROP FUNCTION IF EXISTS "split_part"("public"."citext", "public"."citext", int4);
CREATE OR REPLACE FUNCTION "split_part"("public"."citext", "public"."citext", int4)
  RETURNS "pg_catalog"."text" AS $BODY$
    SELECT (pg_catalog.regexp_split_to_array( $1::pg_catalog.text, pg_catalog.regexp_replace($2::pg_catalog.text, '([^a-zA-Z_0-9])', E'\\\\\\1', 'g'), 'i'))[$3];
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100;

-- ----------------------------
-- Function structure for strpos
-- ----------------------------
DROP FUNCTION IF EXISTS "strpos"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "strpos"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."int4" AS $BODY$
    SELECT pg_catalog.strpos( pg_catalog.lower( $1::pg_catalog.text ), pg_catalog.lower( $2::pg_catalog.text ) );
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100;

-- ----------------------------
-- Function structure for texticlike
-- ----------------------------
DROP FUNCTION IF EXISTS "texticlike"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "texticlike"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS $BODY$texticlike$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for texticlike
-- ----------------------------
DROP FUNCTION IF EXISTS "texticlike"("public"."citext", text);
CREATE OR REPLACE FUNCTION "texticlike"("public"."citext", text)
  RETURNS "pg_catalog"."bool" AS $BODY$texticlike$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for texticnlike
-- ----------------------------
DROP FUNCTION IF EXISTS "texticnlike"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "texticnlike"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS $BODY$texticnlike$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for texticnlike
-- ----------------------------
DROP FUNCTION IF EXISTS "texticnlike"("public"."citext", text);
CREATE OR REPLACE FUNCTION "texticnlike"("public"."citext", text)
  RETURNS "pg_catalog"."bool" AS $BODY$texticnlike$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for texticregexeq
-- ----------------------------
DROP FUNCTION IF EXISTS "texticregexeq"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "texticregexeq"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS $BODY$texticregexeq$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for texticregexeq
-- ----------------------------
DROP FUNCTION IF EXISTS "texticregexeq"("public"."citext", text);
CREATE OR REPLACE FUNCTION "texticregexeq"("public"."citext", text)
  RETURNS "pg_catalog"."bool" AS $BODY$texticregexeq$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for texticregexne
-- ----------------------------
DROP FUNCTION IF EXISTS "texticregexne"("public"."citext", text);
CREATE OR REPLACE FUNCTION "texticregexne"("public"."citext", text)
  RETURNS "pg_catalog"."bool" AS $BODY$texticregexne$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for texticregexne
-- ----------------------------
DROP FUNCTION IF EXISTS "texticregexne"("public"."citext", "public"."citext");
CREATE OR REPLACE FUNCTION "texticregexne"("public"."citext", "public"."citext")
  RETURNS "pg_catalog"."bool" AS $BODY$texticregexne$BODY$
  LANGUAGE internal IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for translate
-- ----------------------------
DROP FUNCTION IF EXISTS "translate"("public"."citext", "public"."citext", text);
CREATE OR REPLACE FUNCTION "translate"("public"."citext", "public"."citext", text)
  RETURNS "pg_catalog"."text" AS $BODY$
    SELECT pg_catalog.translate( pg_catalog.translate( $1::pg_catalog.text, pg_catalog.lower($2::pg_catalog.text), $3), pg_catalog.upper($2::pg_catalog.text), $3);
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100;

-- ----------------------------
-- Function structure for uuid_generate_v1
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v1"();
CREATE OR REPLACE FUNCTION "uuid_generate_v1"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v1'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_generate_v1mc
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v1mc"();
CREATE OR REPLACE FUNCTION "uuid_generate_v1mc"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v1mc'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_generate_v3
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v3"("namespace" uuid, "name" text);
CREATE OR REPLACE FUNCTION "uuid_generate_v3"("namespace" uuid, "name" text)
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v3'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_generate_v4
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v4"();
CREATE OR REPLACE FUNCTION "uuid_generate_v4"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v4'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_generate_v5
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v5"("namespace" uuid, "name" text);
CREATE OR REPLACE FUNCTION "uuid_generate_v5"("namespace" uuid, "name" text)
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v5'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_nil
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_nil"();
CREATE OR REPLACE FUNCTION "uuid_nil"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_nil'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_ns_dns
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_ns_dns"();
CREATE OR REPLACE FUNCTION "uuid_ns_dns"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_dns'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_ns_oid
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_ns_oid"();
CREATE OR REPLACE FUNCTION "uuid_ns_oid"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_oid'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_ns_url
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_ns_url"();
CREATE OR REPLACE FUNCTION "uuid_ns_url"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_url'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_ns_x500
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_ns_x500"();
CREATE OR REPLACE FUNCTION "uuid_ns_x500"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_x500'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "city__id__seq"
OWNED BY "city_"."id_";
SELECT setval('"city__id__seq"', 4, true);
ALTER SEQUENCE "course__id__seq"
OWNED BY "course_"."id_";
SELECT setval('"course__id__seq"', 2, false);
ALTER SEQUENCE "discount__id__seq"
OWNED BY "discount_"."id_";
SELECT setval('"discount__id__seq"', 4, true);
ALTER SEQUENCE "dish__id__seq"
OWNED BY "dish_"."id_";
SELECT setval('"dish__id__seq"', 2, false);
ALTER SEQUENCE "metrics__id__seq"
OWNED BY "metrics_"."id_";
SELECT setval('"metrics__id__seq"', 3, true);
ALTER SEQUENCE "order__id__seq"
OWNED BY "orders_course_"."id_";
SELECT setval('"order__id__seq"', 2, false);
ALTER SEQUENCE "payment_method__id__seq"
OWNED BY "payment_method_"."id_";
SELECT setval('"payment_method__id__seq"', 2, false);
ALTER SEQUENCE "position__id__seq"
OWNED BY "position_"."id_";
SELECT setval('"position__id__seq"', 4, true);
ALTER SEQUENCE "products__id__seq"
OWNED BY "products_"."id_";
SELECT setval('"products__id__seq"', 6, true);
ALTER SEQUENCE "stuff__id__seq"
OWNED BY "stuff_"."id_";
SELECT setval('"stuff__id__seq"', 4, true);
ALTER SEQUENCE "supplier_orders__id__seq"
OWNED BY "supplier_orders_"."id_";
SELECT setval('"supplier_orders__id__seq"', 4, true);
ALTER SEQUENCE "suppliers__id__seq"
OWNED BY "suppliers_"."id_";
SELECT setval('"suppliers__id__seq"', 2, true);
ALTER SEQUENCE "tables__id__seq"
OWNED BY "tables_"."id_";
SELECT setval('"tables__id__seq"', 2, false);

-- ----------------------------
-- Primary Key structure for table city_
-- ----------------------------
ALTER TABLE "city_" ADD CONSTRAINT "city__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table course_
-- ----------------------------
ALTER TABLE "course_" ADD CONSTRAINT "course__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table discount_
-- ----------------------------
ALTER TABLE "discount_" ADD CONSTRAINT "discount__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table dish_
-- ----------------------------
ALTER TABLE "dish_" ADD CONSTRAINT "dish__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table dish_items
-- ----------------------------
ALTER TABLE "dish_items" ADD CONSTRAINT "dish_items_pkey" PRIMARY KEY ("product_id", "dish_id");

-- ----------------------------
-- Primary Key structure for table metrics_
-- ----------------------------
ALTER TABLE "metrics_" ADD CONSTRAINT "metrics__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Uniques structure for table orders_course_
-- ----------------------------
ALTER TABLE "orders_course_" ADD CONSTRAINT "UUID__" UNIQUE ("UUID_");

-- ----------------------------
-- Primary Key structure for table orders_course_
-- ----------------------------
ALTER TABLE "orders_course_" ADD CONSTRAINT "order__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table orders_course_items
-- ----------------------------
ALTER TABLE "orders_course_items" ADD CONSTRAINT "order_to_course__pkey" PRIMARY KEY ("order_ID", "course_ID");

-- ----------------------------
-- Primary Key structure for table payment_method_
-- ----------------------------
ALTER TABLE "payment_method_" ADD CONSTRAINT "payment_method__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table position_
-- ----------------------------
ALTER TABLE "position_" ADD CONSTRAINT "position__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table product_items
-- ----------------------------
ALTER TABLE "product_items" ADD CONSTRAINT "product_items__pkey" PRIMARY KEY ("product_ID", "supplier_ID");

-- ----------------------------
-- Primary Key structure for table products_
-- ----------------------------
ALTER TABLE "products_" ADD CONSTRAINT "products__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Indexes structure for table stuff_
-- ----------------------------
CREATE UNIQUE INDEX "email" ON "stuff_" USING btree (
  "email_" COLLATE "pg_catalog"."default" "public"."citext_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table stuff_
-- ----------------------------
ALTER TABLE "stuff_" ADD CONSTRAINT "passport" UNIQUE ("passport_");
ALTER TABLE "stuff_" ADD CONSTRAINT "email" UNIQUE ("email_");
ALTER TABLE "stuff_" ADD CONSTRAINT "UUID" UNIQUE ("UUID");

-- ----------------------------
-- Primary Key structure for table stuff_
-- ----------------------------
ALTER TABLE "stuff_" ADD CONSTRAINT "stuff__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Uniques structure for table supplier_orders_
-- ----------------------------
ALTER TABLE "supplier_orders_" ADD CONSTRAINT "UUID_" UNIQUE ("UUID_");

-- ----------------------------
-- Primary Key structure for table supplier_orders_
-- ----------------------------
ALTER TABLE "supplier_orders_" ADD CONSTRAINT "supplier_orders__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table supplier_orders_items
-- ----------------------------
ALTER TABLE "supplier_orders_items" ADD CONSTRAINT "order_items_2__pkey" PRIMARY KEY ("product_id", "order_id");

-- ----------------------------
-- Indexes structure for table suppliers_
-- ----------------------------
CREATE UNIQUE INDEX "email_check" ON "suppliers_" USING btree (
  "email_" COLLATE "pg_catalog"."default" "public"."citext_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table suppliers_
-- ----------------------------
ALTER TABLE "suppliers_" ADD CONSTRAINT "email_check" UNIQUE ("email_");

-- ----------------------------
-- Primary Key structure for table suppliers_
-- ----------------------------
ALTER TABLE "suppliers_" ADD CONSTRAINT "suppliers__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Primary Key structure for table tables_
-- ----------------------------
ALTER TABLE "tables_" ADD CONSTRAINT "tables__pkey" PRIMARY KEY ("id_");

-- ----------------------------
-- Foreign Keys structure for table course_
-- ----------------------------
ALTER TABLE "course_" ADD CONSTRAINT "course__discount_id_fkey" FOREIGN KEY ("discount_ID") REFERENCES "discount_" ("id_") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "course_" ADD CONSTRAINT "course__dish_id_fkey" FOREIGN KEY ("dish_ID") REFERENCES "dish_" ("id_") ON DELETE RESTRICT ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table dish_items
-- ----------------------------
ALTER TABLE "dish_items" ADD CONSTRAINT "dish_items_dish_id_fkey" FOREIGN KEY ("dish_id") REFERENCES "dish_" ("id_") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "dish_items" ADD CONSTRAINT "dish_items_products_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products_" ("id_") ON DELETE RESTRICT ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table orders_course_
-- ----------------------------
ALTER TABLE "orders_course_" ADD CONSTRAINT "orders_course__payment_method_id_fkey" FOREIGN KEY ("payment_method_ID") REFERENCES "payment_method_" ("id_") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "orders_course_" ADD CONSTRAINT "orders_course__stuff_id_fkey" FOREIGN KEY ("stuff_ID") REFERENCES "stuff_" ("id_") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "orders_course_" ADD CONSTRAINT "orders_course__table_id_fkey" FOREIGN KEY ("table_ID") REFERENCES "tables_" ("id_") ON DELETE RESTRICT ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table orders_course_items
-- ----------------------------
ALTER TABLE "orders_course_items" ADD CONSTRAINT "orders_course_items_course_id_fkey" FOREIGN KEY ("course_ID") REFERENCES "course_" ("id_") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "orders_course_items" ADD CONSTRAINT "orders_course_items_orders_course_id_fkey" FOREIGN KEY ("order_ID") REFERENCES "orders_course_" ("id_") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table product_items
-- ----------------------------
ALTER TABLE "product_items" ADD CONSTRAINT "product_items_products_id_fkey" FOREIGN KEY ("product_ID") REFERENCES "products_" ("id_") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "product_items" ADD CONSTRAINT "product_items_suppliers_id_fkey" FOREIGN KEY ("supplier_ID") REFERENCES "suppliers_" ("id_") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table stuff_
-- ----------------------------
ALTER TABLE "stuff_" ADD CONSTRAINT "stuff__city_id_fkey" FOREIGN KEY ("city_ID") REFERENCES "city_" ("id_") ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE "stuff_" ADD CONSTRAINT "stuff__position_id_fkey" FOREIGN KEY ("position_ID") REFERENCES "position_" ("id_") ON DELETE NO ACTION ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table supplier_orders_
-- ----------------------------
ALTER TABLE "supplier_orders_" ADD CONSTRAINT "supplier_orders__metrics_id_fkey" FOREIGN KEY ("metric_ID") REFERENCES "metrics_" ("id_") ON DELETE NO ACTION ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table supplier_orders_items
-- ----------------------------
ALTER TABLE "supplier_orders_items" ADD CONSTRAINT "supplier_orders_items_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "supplier_orders_" ("id_") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "supplier_orders_items" ADD CONSTRAINT "supplier_orders_items_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products_" ("id_") ON DELETE RESTRICT ON UPDATE NO ACTION;
