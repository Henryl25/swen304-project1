select a."RobberId", r."NickName", sum(a."Share") as "Earnings"
from "Accomplices" a, "Robbers" r
where r."RobberId"=a."RobberId"
group by a."RobberId", r."NickName"
having sum(a."Share")>30000
order by sum(a."Share") desc;
