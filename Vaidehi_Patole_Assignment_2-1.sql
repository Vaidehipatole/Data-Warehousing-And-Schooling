USE hospital_schema;

Select Business_name AS Hospital_name, sum(license_beds) AS Total_License_Beds
FROM bed_fact
Join Business on bed_fact.ims_org_id = Business.ims_org_id
Where bed_id = 4 or bed_id = 15
Group by Hospital_name
order by Total_license_beds DESC
Limit 10;

Select Business_name AS Hospital_name, sum(census_beds) AS Total_Census_Beds
FROM bed_fact
Join Business on bed_fact.ims_org_id = Business.ims_org_id
Where bed_id = 4 or bed_id = 15
Group by Hospital_name
order by Total_Census_beds DESC
Limit 10;

-- 4a3
Select Business_name AS Hospital_name, sum(staffed_beds) AS Total_Staffed_Beds
FROM bed_fact
Join Business on bed_fact.ims_org_id = Business.ims_org_id
Where bed_id = 4 or bed_id = 15
Group by Hospital_name
order by Total_Staffed_beds DESC
Limit 10;

 
Select Business_name AS Hospital_name, sum(staffed_beds) AS Total_Staffed_Beds
FROM bed_fact
Join Business on bed_fact.ims_org_id = Business.ims_org_id
Where bed_id = 4 or bed_id = 15
Group by Hospital_name
order by Total_Staffed_beds DESC
Limit 10;

# Total license bed
Select Business_name AS Hospital_name, sum(license_beds) AS Total_License_Beds
FROM bed_fact
Join Business on bed_fact.ims_org_id = Business.ims_org_id
Where bed_id = 4 or bed_id = 15
Group by Hospital_name
having count(hospital_name) > 1
order by Total_license_beds DESC
Limit 10;
#census beds

Select Business_name AS Hospital_name, sum(census_beds) AS Total_Census_Beds
FROM bed_fact
Join Business on bed_fact.ims_org_id = Business.ims_org_id
Where bed_id = 4 or bed_id = 15
Group by Hospital_name
having count(hospital_name) > 1
order by Total_Census_beds DESC
Limit 10;

Select Business_name AS Hospital_name, sum(staffed_beds) AS Total_Staffed_Beds
FROM bed_fact
Join Business on bed_fact.ims_org_id = Business.ims_org_id
Where bed_id = 4 or bed_id = 15
Group by Hospital_name
having count(hospital_name) > 1
order by Total_Staffed_beds DESC
Limit 10;

