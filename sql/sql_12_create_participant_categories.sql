create table if not exists public.participant_categories (
  id int4 not null,
  seq_num int4 not null,
  description varchar(50) not null
);

comment on table public.participant_categories is 'Категории участников';

comment on column public.participant_categories.id is 'Идентификатор';
comment on column public.participant_categories.seq_num is 'Порядковый № категории участника';
comment on column public.participant_categories.description is 'Категория участника';