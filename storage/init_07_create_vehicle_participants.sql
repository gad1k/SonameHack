create table if not exists public.vehicle_participants (
  id int4 not null,
  seq_num int4 not null,
  seq_num_2 int4 not null,
  "role" varchar(150) not null,
  gender varchar(10),
  health_status varchar(250),
  years_of_driving_experience int4
);

comment on table public.vehicle_participants is 'Участники внутри ТС';

comment on column public.vehicle_participants.id is 'Идентификатор';
comment on column public.vehicle_participants.seq_num is 'Порядковый № ТС';
comment on column public.vehicle_participants.seq_num_2 is 'Порядковый № участника';
comment on column public.vehicle_participants."role" is 'Роль участника';
comment on column public.vehicle_participants.gender is 'Пол участника';
comment on column public.vehicle_participants.health_status is 'Состояние здоровья участника';
comment on column public.vehicle_participants.years_of_driving_experience is 'Стаж вождения участника (только у водителей)';