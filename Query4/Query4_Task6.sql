select s."Description", hs."RobberId", r."NickName"
from "HasSkills" hs, "Skills" s, "Robbers" r
where hs."SkillId"=s."SkillId" and hs."RobberId"=r."RobberId"
order by s."Description";
