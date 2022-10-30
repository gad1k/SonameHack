create table if not exists public.nearby (
  id int4 not null,
  seq_num int4 not null,
  description varchar(150) not null
);

comment on table public.nearby is 'Ориентиры';

comment on column public.nearby.id is 'Идентификатор';
comment on column public.nearby.seq_num is 'Порядковый № ориентира';
comment on column public.nearby.description is 'Ориентир';