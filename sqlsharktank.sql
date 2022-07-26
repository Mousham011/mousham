select * from project1..data

--  total episodes
select max(epno) from project1..data
select count(distinct epno) from project1..data

--pitches

select count(distinct brand) from project1..data

--pitches converted

select cast(sum (a.converted_not_converted ) as float) / count(*) from
(select amountinvestedlakhs , case when amountinvestedlakhs>0 then 1 else 0 end as converted_not_converted from project1..data) a

--total male

select sum(male) from project1..data

--total female 

select sum(female) from project1..data

--gender ratio

select sum(female)/sum(male) from project1..data

--total amount invested

select sum(amountinvestedlakhs) from project1..data

--avg equity taken

select avg(a.Equitytakeninp) from(
select * from project1..data where Equitytakeninp>0) a

--highet deal taken

select max(amountinvestedlakhs) from project1..data

--highest equity taken

select max(Equitytakeninp) from project1..data


select sum(a.female_count)  startups  from(
select female, case when female>0 then 1 else 0 end as female_count from project1..data) a

--pitches converted having at least one women

select * from project1..data

select sum(b.female_count) from(
select * , case when female>0 then 1 else 0 end as female_count from(
(select* from project1..data where deal != 'No deal'))a)b

--avg team member

select avg( Teammembers) from project1..data

--amount invested per deal

select avg(a.amountinvestedlakhs) amount_invested_per_deal from
(select * from project1..data where deal!='No deal') a

--avg age of contestent 

select avgage,count(avgage)cnt from project1..data group by avgage order by cnt desc

--location group of contestent

select location, count(location) cnt from project1..data group by location order by cnt desc

select sector, count(sector) cnt from project1..data group by sector order by cnt desc

--partner deals

select partners,count(partners)cnt  from project1..data where partners!='-' group by partners order by cnt desc

--making the materix

select * from project1..data

select 'Ashneer'  as keyy , count(ashneeramountinvested) from project1..data where ashneeramountinvested is not null

select 'Ashneer' as keyy , count(ashneeramountinvested )from project1..data where ashneeramountinvested is not null AND ashneeramountinvested!=0

select'Ashneer' as keyy, sum (ashneeramountinvested),avg(c.ashneerequitytakenp)
from (select * from project1..data where ashneerequitytakenp!=0  and ashneerequitytakenp is not null) c

select m.keyy,m.total_deals_present,total_deals ,n.total_amount_invested,n.avg_equity_taken from
(select a.keyy,a.total_deals_present,b.total_deals from(
select 'Ashneer'  as keyy , count(ashneeramountinvested)total_deals_present from project1..data where ashneeramountinvested is not null)a

inner join (
select 'Ashneer' as keyy , count(ashneeramountinvested ) total_deals from project1..data where ashneeramountinvested is not null AND ashneeramountinvested!=0)b

on a.keyy=b.keyy)m

inner join
(select'Ashneer' as keyy, sum (ashneeramountinvested)total_amount_invested,avg(c.ashneerequitytakenp)avg_equity_taken
from (select * from project1..data where ashneerequitytakenp!=0  and ashneerequitytakenp is not null) c)n

on m.keyy=n.keyy

--which is the startup in which the highest amount has been invested in each domain/sector


select c.*from 
(select brand,sector,amountinvestedlakhs,rank()over(partition by sector order by amountinvestedlakhs desc)rnk
from project1..data)c
where c.rnk=1
