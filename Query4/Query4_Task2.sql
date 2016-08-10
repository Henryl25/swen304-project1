select distinct ha."BankName"
from "HasAccounts" ha, "Robbers" r
where ha."RobberId"=r."RobberId" and r."NickName"='Calamity Jane';

