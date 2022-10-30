create table if not exists public.vehicle_violations (
  id int4 not null,
  seq_num int4 not null,
  seq_num_2 int4 not null,
  seq_num_3 int4 not null,
  description varchar(350) not null
);

comment on table public.vehicle_violations is 'Нарушения правил участником внутри ТС';

comment on column public.vehicle_violations.id is 'Идентификатор';
comment on column public.vehicle_violations.seq_num is 'Порядковый № ТС';
comment on column public.vehicle_violations.seq_num_2 is 'Порядковый № участника';
comment on column public.vehicle_violations.seq_num_3 is 'Порядковый № нарушения правил';
comment on column public.vehicle_violations.description is 'Нарушение правил';