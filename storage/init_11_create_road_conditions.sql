create table if not exists public.road_conditions (
  id int4 not null,
  seq_num int4 not null,
  description varchar(200) not null
);

comment on table public.road_conditions is 'Cостояния дорожного покрытия';

comment on column public.road_conditions.id is 'Идентификатор';
comment on column public.road_conditions.seq_num is 'Порядковый № состояния дорожного покрытия';
comment on column public.road_conditions.description is 'Cостояние дорожного покрытия';