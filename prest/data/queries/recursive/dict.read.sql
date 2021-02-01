with recursive rec as
(
select id,parent_id,item_key,item_value,ct_company_id,ct_dept_id,status,version_id,remark from dict.inf_common_dict_type
where item_value like '%{{.item_value}}%'
union all
select d.id,d.parent_id,d.item_key,d.item_value,d.ct_company_id,d.ct_dept_id,d.status,d.version_id,d.remark from rec inner join dict.inf_common_dict_type d
on rec.parent_id = d.id 
)

select distinct on(id) id,parent_id,item_key,item_value,ct_company_id,ct_dept_id,status,version_id,remark  from rec
