create table if not exists public.violations (
  id int4 not null,
  seq_num int4 not null,
  seq_num_2 int4 not null,
  description varchar(400) not null
);

comment on table public.violations is 'Нарушения правил участником без ТС';

comment on column public.violations.id is 'Идентификатор';
comment on column public.violations.seq_num is 'Порядковый № участника';
comment on column public.violations.seq_num_2 is 'Порядковый № нарушения правил';
comment on column public.violations.description is 'Нарушение правил';