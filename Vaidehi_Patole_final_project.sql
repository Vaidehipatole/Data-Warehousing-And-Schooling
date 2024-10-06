use final_project;

Select * from mem_dim;
Select * from drugform_dim;
Select * from drugndc_dim;
Select * from drugbrand_dim;
Select * from fact_table;

ALTER TABLE `final_project`.`drugbrand_dim` 
CHANGE COLUMN `drug_brand_generic_code` `drug_brand_generic_code` INT NOT NULL ,
ADD PRIMARY KEY (`drug_brand_generic_code`);
;

ALTER TABLE `final_project`.`drugform_dim` 
Modify drug_form_code CHAR(2),
CHANGE COLUMN `drug_form_code` `drug_form_code` CHAR(2) NOT NULL ,
ADD PRIMARY KEY (`drug_form_code`);
;

ALTER TABLE `final_project`.`drugndc_dim` 
CHANGE COLUMN `drug_ndc` `drug_ndc` INT NOT NULL ,
ADD PRIMARY KEY (`drug_ndc`);
;

ALTER TABLE `final_project`.`fact_table` 
CHANGE COLUMN `Fact_id` `Fact_id` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`Fact_id`),
ADD UNIQUE INDEX `Fact_id_UNIQUE` (`Fact_id` ASC) VISIBLE;
;

ALTER TABLE `final_project`.`mem_dim` 
CHANGE COLUMN `member_id` `member_id` INT NOT NULL ,
ADD PRIMARY KEY (`member_id`);
;


ALTER TABLE fact_table
ADD FOREIGN KEY (member_id)
REFERENCES mem_dim(member_id)
ON DELETE SET NULL
ON UPDATE SET NULL;

ALTER TABLE fact_table
ADD FOREIGN KEY (drug_brand_generic_code)
REFERENCES drugbrand_dim(drug_brand_generic_code)
ON DELETE SET NULL
ON UPDATE SET NULL;

Alter table fact_table
modify member_id BIGint;

ALTER TABLE fact_table
ADD FOREIGN KEY (drug_ndc)
REFERENCES drugndc_dim(drug_ndc)
ON DELETE SET NULL
ON UPDATE SET NULL;

Alter table fact_table
modify drug_form_code CHAR(2);

ALTER TABLE fact_table
ADD FOREIGN KEY (drug_form_code)
REFERENCES drugform_dim(drug_form_code)
ON DELETE SET NULL
ON UPDATE SET NULL;

Alter table fact_table
modify member_id int;

Alter table mem_dim
modify member_id int;


ALTER TABLE fact_table
ADD FOREIGN KEY (member_id)
REFERENCES mem_dim(member_id)
ON DELETE SET NULL
ON UPDATE SET NULL;
  

Select d.drug_name, count(f.member_id) as number_prescriptions
from drugndc_dim d  inner join fact_table f
on d.drug_ndc = f.drug_ndc
group by drug_name;

select case
when m.member_age >65 then '65+' 
when m.member_age < 65 then '<65'
end as age_group,
count(distinct m.member_id) as number_members, 
sum(f.copay1) as sum_copay, 
sum(f. insurancepaid1) as sum_insurancepaid, 
count(f.member_id) as number_prescriptions from mem_dim m inner join fact_table f
on m.member_id = f.member_id
group by age_group;

Drop table if exists fill_fact;
create table fill_fact as 
select m.member_id, m.member_first_name, m.member_last_name, d.drug_name,  
str_to_date(f.fill_date1, '%m/%d/%Y') as fill_date_fixed, f. insurancepaid1
from mem_dim m inner join fact_table f
on m.member_id = f.member_id
inner join drugndc_dim d
on d.drug_ndc = f.drug_ndc;

Select * from fill_fact;

Drop table if exists insurancepaid_info;
create table insurancepaid_info as
select member_id, member_first_name, member_last_name, drug_name, fill_date_fixed, insurancepaid1,
row_number()over(partition by member_id order by member_id, fill_date_fixed desc) as fill_times from fill_fact;

Select * from insurancepaid_info;

Select * from insurancepaid_info
Where fill_times =1 ;




