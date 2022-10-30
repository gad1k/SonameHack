create table if not exists public.vehicles (
  id int4 not null,
  seq_num int4 not null,
  "year" int4,
  brand varchar(50),
  color varchar(50),
  model varchar(100),
  category varchar(150) not null
);

comment on table public.vehicles is 'Транспортные средства';

comment on column public.vehicles.id is 'Идентификатор';
comment on column public.vehicles.seq_num is 'Порядковый № ТС';
comment on column public.vehicles."year" is 'Год производства ТС';
comment on column public.vehicles.brand is 'Марка ТС';
comment on column public.vehicles.color is 'Цвет ТС';
comment on column public.vehicles.model is 'Модель ТС';
comment on column public.vehicles.category is 'Категория ТС';