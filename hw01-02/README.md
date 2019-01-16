
https://habr.com/post/193380/

SET DateStyle TO European;
set timezone = 'Europe/Moscow';

UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DEFAULT uuid_generate_v1()

email
additional type DOMAIN email

CREATE EXTENSION citext;

CREATE DOMAIN email AS citext
  CHECK ( value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' );


#phone number


79101234567



 SELECT stuff_.name_,
    stuff_.surname_,
    city_name_.city_name_,
    position_.position_
   FROM ((stuff_
     JOIN position_ ON ((position_.id_ = stuff_."position_ID")))
     JOIN city_name_ ON ((city_name_.id_ = stuff_."city_name_ID")))