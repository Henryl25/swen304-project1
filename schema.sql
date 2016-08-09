CREATE TABLE "Banks" (
    "BankName" char(64) NOT NULL,
    "City" char(64) NOT NULL,
    "NoAccounts" integer NOT NULL
        CONSTRAINT positive_or_zero_accounts
            CHECK ("NoAccounts" >= 0),
    "Security" char(64),
    PRIMARY KEY ("BankName", "City")
);

CREATE TABLE "Robberies" (
    "BankName" char(64),
    "City" char(64),
    "Date" date,
    "Amount" decimal
        CONSTRAINT positive_or_zero_amount
            CHECK ("Amount" >= 0),
    PRIMARY KEY ("BankName", "City", "Date"),
    FOREIGN KEY ("BankName", "City") REFERENCES "Banks" ("BankName", "City") ON DELETE RESTRICT
);

CREATE TABLE "Plans" (
    "PlanId" SERIAL PRIMARY KEY,
    "BankName" char(64) NOT NULL,
    "City" char(64) NOT NULL,
    "NoRobbers" integer
        CONSTRAINT at_least_one_robber
            CHECK ("NoRobbers" >= 1),
    "PlannedDate" date,
    FOREIGN KEY ("BankName", "City") REFERENCES "Banks"  ("BankName", "City") ON DELETE CASCADE
);

CREATE TABLE "Robbers" (
    "RobberId" SERIAL PRIMARY KEY,
    "NickName" char(64),
    "Age" integer
        CONSTRAINT realistic_age
            CHECK ("Age" > 0 AND "Age" < 120),
    "NoYears" integer
        CONSTRAINT valid_prison_time
            CHECK ("NoYears" >= 0 AND "NoYears"< "Age")
);

CREATE TABLE "Skills" (
    "SkillId" SERIAL PRIMARY KEY,
    "Description" char(64) UNIQUE
);

CREATE TABLE "HasSkills" (
    "RobberId" integer NOT NULL
        REFERENCES "Robbers" ("RobberId") ON DELETE CASCADE,
    "SkillId" integer NOT NULL
        REFERENCES "Skills" ("SkillId") ON DELETE RESTRICT,
    "Preference" integer
        CONSTRAINT valid_preference
            CHECK ("Preference" >= 1),
    "Grade" char(2)
        CONSTRAINT valid_grade
            CHECK ("Grade" IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', NULL)),
    PRIMARY KEY ("RobberId", "SkillId")
);

CREATE TABLE "HasAccounts" (
    "RobberId" integer NOT NULL
        REFERENCES "Robbers" ("RobberId") ON DELETE CASCADE,
    "BankName" char(64) NOT NULL,
    "City" char(64) NOT NULL,
    PRIMARY KEY ("RobberId", "BankName", "City"),
    FOREIGN KEY ("BankName", "City") REFERENCES "Banks" ("BankName", "City") ON DELETE CASCADE
);

CREATE TABLE "Accomplices" (
    "RobberId" integer
        REFERENCES "Robbers" ("RobberId") ON DELETE RESTRICT,
    "BankName" char(64),
    "City" char(64),
    "RobberyDate" date,
    "Share" decimal
        CONSTRAINT positive_or_zero_share
             CHECK ("Share" >= 0),
    PRIMARY KEY ("RobberId", "BankName", "City", "RobberyDate"),
    FOREIGN KEY ("BankName", "City", "RobberyDate") REFERENCES "Robberies" ("BankName", "City", "Date") ON DELETE CASCADE
);
