create table if not exists public.features (
  id int4 not null,
  light varchar(50) not null,
  region varchar(50) not null,
  "schema" varchar(10),
  address varchar(300),
  category varchar(150) not null,
  datetime timestamp not null,
  severity varchar(50) not null,
  dead_count int4 not null,
  injured_count int4 not null,
  parent_region varchar(50) not null,
  participants_count int4 not null,
  origin_file varchar(100) not null
);

comment on table public.features is 'Дорожно-траспортные проишествия';

comment on column public.features.id is 'Идентификатор';
comment on column public.features.light is 'Время суток';
comment on column public.features.region is 'Город / район';
comment on column public.features."schema" is 'Схема';
comment on column public.features.address is 'Адрес';
comment on column public.features.category is 'Тип ДТП';
comment on column public.features.datetime is 'Дата и время';
comment on column public.features.severity is 'Тяжесть ДТП / вред здоровью';
comment on column public.features.dead_count is 'Количество погибших в ДТП';
comment on column public.features.injured_count is 'Количество раненых в ДТП';
comment on column public.features.parent_region is 'Регион';
comment on column public.features.participants_count is 'Количество участников ДТП';
comment on column public.features.origin_file is 'Исходный файл';