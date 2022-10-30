create table if not exists public.weather (
  id int4 not null,
  seq_num int4 not null,
  description varchar(50) not null
);

comment on table public.weather is 'Погодные условия';

comment on column public.weather.id is 'Идентификатор';
comment on column public.weather.seq_num is 'Порядковый № погодного условия';
comment on column public.weather.description is 'Погодное условие';