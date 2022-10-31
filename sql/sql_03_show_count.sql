select  1 as tab_num, 'features' as tab_name, count(*) as cnt from public.features union all
select  2 as tab_num, 'tags' as tab_name, count(*) as cnt from public.tags union all
select  3 as tab_num, 'points' as tab_name, count(*) as cnt from public.points union all
select  4 as tab_num, 'nearby' as tab_name, count(*) as cnt from public.nearby union all
select  5 as tab_num, 'weather' as tab_name, count(*) as cnt from public.weather union all
select  6 as tab_num, 'vehicles' as tab_name, count(*) as cnt from public.vehicles union all
select  7 as tab_num, 'vehicle_participants' as tab_name, count(*) as cnt from public.vehicle_participants union all
select  8 as tab_num, 'vehicle_violations' as tab_name, count(*) as cnt from public.vehicle_violations union all
select  9 as tab_num, 'participants' as tab_name, count(*) as cnt from public.participants union all
select 10 as tab_num, 'violations' as tab_name, count(*) as cnt from public.violations union all
select 11 as tab_num, 'road_conditions' as tab_name, count(*) as cnt from public.road_conditions union all
select 12 as tab_num, 'participant_categories' as tab_name, count(*) as cnt from public.participant_categories order by 1;

select parent_region,
	   count(*) as cnt
  from public.features
 group by parent_region
 order by parent_region;

select origin_file,
	   count(*) as cnt
  from public.features
 group by origin_file
 order by origin_file;
