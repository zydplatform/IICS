
INSERT INTO public.facilityservices(active, dateadded, dateupdated, servicename, description, servicekey, addedby, updatedby, released)
	VALUES (true, NOW(), NOW(), 'Admission','Admit Patient in Hospital', 'key_admission', '1', '1', true);
	
UPDATE public.facilityunit set administrative = 'false' where facilityunitname = 'Maternity';