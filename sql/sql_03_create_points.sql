create table if not exists public.points (
  id int4 not null,
  lat varchar(20),
  long varchar(20)
);

comment on table public.points is 'Координаты';

comment on column public.points.id is 'Идентификатор';
comment on column public.points.lat is 'Широта';
comment on column public.points.long is 'Долгота';