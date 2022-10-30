create table if not exists public.tags (
  id int4 not null,
  seq_num int4 not null,
  description varchar(100) not null
);

comment on table public.tags is 'Показатели с официального сайта ГИБДД';

comment on column public.tags.id is 'Идентификатор';
comment on column public.tags.seq_num is 'Порядковый № показателя с официального сайта ГИБДД';
comment on column public.tags.description is 'Показатель с официального сайта ГИБДД';
