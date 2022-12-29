alter table public.features add constraint features_pk primary key (id);

alter table public.tags add constraint tags_pk primary key (id, seq_num);
alter table public.tags add constraint tags_fk foreign key (id) references public.features(id);

alter table public.points add constraint points_pk primary key (id);
alter table public.points add constraint points_fk foreign key (id) references public.features(id);

alter table public.nearby add constraint nearby_pk primary key (id, seq_num);
alter table public.nearby add constraint nearby_fk foreign key (id) references public.features(id);

alter table public.weather add constraint weather_pk primary key (id, seq_num);
alter table public.weather add constraint weather_fk foreign key (id) references public.features(id);

alter table public.vehicles add constraint vehicles_pk primary key (id, seq_num);
alter table public.vehicles add constraint vehicles_fk foreign key (id) references public.features(id);

alter table public.vehicle_participants add constraint vehicle_participants_pk primary key (id, seq_num, seq_num_2);
alter table public.vehicle_participants add constraint vehicle_participants_fk foreign key (id, seq_num) references public.vehicles(id, seq_num);

alter table public.vehicle_violations add constraint vehicle_violations_pk primary key (id, seq_num, seq_num_2, seq_num_3);
alter table public.vehicle_violations add constraint vehicle_violations_fk foreign key (id, seq_num, seq_num_2) references public.vehicle_participants(id, seq_num, seq_num_2);

alter table public.participants add constraint participants_pk primary key (id, seq_num);
alter table public.participants add constraint participants_fk foreign key (id) references public.features(id);

alter table public.violations add constraint violations_pk primary key (id, seq_num, seq_num_2);
alter table public.violations add constraint violations_fk foreign key (id, seq_num) references public.participants(id, seq_num);

alter table public.road_conditions add constraint road_conditions_pk primary key (id, seq_num);
alter table public.road_conditions add constraint road_conditions_fk foreign key (id) references public.features(id);

alter table public.participant_categories add constraint participant_categories_pk primary key (id, seq_num);
alter table public.participant_categories add constraint participant_categories_fk foreign key (id) references public.features(id);