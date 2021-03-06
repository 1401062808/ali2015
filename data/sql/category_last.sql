set @behavior_type='4';
set @begin_time='2014-11-19 00';
set @end_time='2014-12-17 23';

/*
drop table category_last;
create table category_last
(
item_category integer,
behavior_type varchar(1),
begin_time varchar(13),
end_time varchar(13),
datediff integer,
primary key(item_category, behavior_type, begin_time, end_time));*/

insert into category_last
select item_category, @behavior_type, @begin_time, @end_time,
ifnull((select datediff(substr(@end_time, 1, 10), substr(u.time, 1, 10)) from user u
where behavior_type = @behavior_type
and u.item_category = i_c.item_category
and u.time between @before_time and @end_time
order by time desc
limit 1), 45)
from item_category i_c;

/*
select behavior_type, begin_time, end_time, count(*) from category_last
group by behavior_type, begin_time, end_time;*/