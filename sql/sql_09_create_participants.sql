create table if not exists public.participants (
  id int4 not null,
  seq_num int4 not null,
  "role" varchar(150) not null,
  gender varchar(10),
  health_status varchar(250)
);

comment on table public.participants is 'Участники без ТС';

comment on column public.participants.id is 'Идентификатор';
comment on column public.participants.seq_num is 'Порядковый № участника';
comment on column public.participants."role" is 'Роль участника';
comment on column public.participants.gender is 'Пол участника';
comment on column public.participants.health_status is 'Состояние здоровья участника';