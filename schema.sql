/* TODO: 
-On deletes
-Field Validation regexes
-Primary key for accomplices
    should i use robbery id to refer to a particular robbery
    can the same place be robbed twice on the same day buy the same guy
*/
CREATE TABLE "Banks" (
    "BankName" char(64) NOT NULL,
    "City" char(64) NOT NULL,
    "NoAccounts" integer NOT NULL
        CHECK ("NoAccounts" >= 0),
    "Security" char(64),
    PRIMARY KEY ("BankName", "City")
)

CREATE TABLE "Robberies" (
    "RobberyId" SERIAL PRIMARY KEY,
    "BankName" char(64) NOT NULL,
    "City" char(64) NOT NULL,
    "Date" date,
    "Amount" decimal 
        CHECK ("Amount" >= 0),
    FOREIGN KEY ("BankName", "City") REFERENCES "Banks" ("BankName", "City")
)

CREATE TABLE "Plans" (
    "PlanId" SERIAL PRIMARY KEY,
    "BankName" char(64) NOT NULL,
    "City" char(64) NOT NULL,
    "NoRobbers" integer
        CHECK ("NoRobbers" >= 0),
    "PlannedDate" date,
    FOREIGN KEY ("BankName", "City") REFERENCES "Banks"  ("BankName", "City")
)

CREATE TABLE "Robbers" (
    "RobberId" SERIAL PRIMARY KEY,
    "Nickname" char(64),
    "Age" integer
        CHECK ("Age" > 0 AND "Age" < 120),
    "NoYears" integer
        CHECK ("NoYears" >= 0 AND "NoYears"< "Age")
)

CREATE TABLE "Skills" (
    "SkillId" SERIAL PRIMARY KEY,
    "Description" char(256)
)

CREATE TABLE "HasSkills" (
    "RobberId" integer NOT NULL
        REFERENCES "Robbers" ("RobberId"),
    "SkillId" integer NOT NULL
        REFERENCES "Skills" ("SkillId"),
    "Preference" integer
        CHECK ("Preference" >= 1),
    "Grade" char(2)
        CONSTRAINT valid_grade 
            CHECK ("Grade" IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', NULL)),
    PRIMARY KEY ("RobberId", "SkillId")
)

CREATE TABLE "HasAccounts" (
    "RobberId" integer NOT NULL
        REFERENCES "Robbers" ("RobberId"),
    "BankName" integer NOT NULL,
    "City" char(64) NOT NULL,
    PRIMARY KEY ("RobberId", "BankName", "City"),
    FOREIGN KEY ("BankName", "City") REFERENCES "Banks" ("BankName", "City")
)

CREATE TABLE "Accomplices" (
    "RobberId" integer
        REFERENCES "Robbers" ("RobberId"),
    "BankName" integer NOT NULL,
    "City" char(64) NOT NULL,
    "RobberyDate" date NOT NULL,
    "Share" decimal
        CHECK ("Share" > 0),
    PRIMARY KEY ("RobberId", "BankName", "City", "RobberyDate") --cant rob the same bank twice on the same day
    FOREIGN KEY ("BankName", "City") REFERENCES "Banks" ("BankName", "City")
)

