select distinct keyword
FROM alleged_issues
where Keyword like 'Other non-empty issue'

group by issue
order by count desc;




ALTER TABLE alleged_issues
ADD COLUMN POUR_Principal VARCHAR(255);
Update alleged_issues
SET `POUR_Principal`= 
	 case when Keyword = 'Missing Alt-Text' then 'Perceivable'
     when Keyword = 'Empty Links' then 'Operable'
     when Keyword = 'Redundant Links' then 'Operable'
     when Keyword = 'Broken Links' then 'Operable'
     when Keyword = 'Duplicate Titles' then 'Perceivable'
	 when Keyword = 'Element contains duplicate IDs' then 'Understandable'
      when Keyword = 'Element not resizable' then 'Perceivable'
      when Keyword = 'Element without Title' then 'Perceivable'
      when Keyword = 'Empty Buttons' then 'Operable'
      when Keyword = 'Empty of Broken Element' then 'Operable'
      when Keyword = 'Empty or Missing Form Labels' then 'Perceivable'
      when Keyword = 'Inaccessible Checkout System' then 'Operable'
      when Keyword = 'Inaccessible Element' then 'Operable'
      when Keyword = 'Inaccessible forms' then 'Operable'
      when Keyword = 'Lack of closed captioning' then 'Perceivable'
      when Keyword = 'Lack of Descriptive Titles' then 'Perceivable'
      when Keyword = 'Lack of Descriptive Heading' then 'Perceivable'
      when Keyword = 'Missing Keyboard Focus Indicator' then 'Operable'
      when Keyword = 'Lack of Image Mapping' then 'Perceivable'
      when Keyword = 'Lack of Proper Keyboard Support' then 'Operable'
      when Keyword = 'Lack of Proper Navigation' then 'Operable'
      when Keyword = 'Lack of Screen Reader Support' then 'Perceivable'
      when Keyword = 'Low Contrast' then 'Perceivable'
      when Keyword = 'Markup Errors' then 'Robust'
      when Keyword = 'Mislabeled Buttons' then 'Understandable'
      when Keyword = 'Mislabeled Element' then 'Understandable'
      when Keyword = 'Missing Element' then 'Perceivable'
      when Keyword = 'Missing label' then 'Perceivable'
      when Keyword = 'Missing Mechanism to Bypass Content' then 'Operable'
      when Keyword = 'Other Non-Empty Issue' then 'N/A'
      when Keyword = 'Empty or Broken Element' then 'Operable'
      when Keyword = 'N/A' then 'N/A'
      when Keyword = 'Same link used for different destinations' then 'Operable'
      when Keyword = 'Unclear Link Purpose' then 'Understandable'
      when Keyword = 'Undefined Page Language' then 'Understandable'
      when Keyword = 'Unreadable element' then 'Understandable'
      when Keyword = 'Lack of Headings' then 'Perceivable'
      when Keyword = 'Loss of information' then 'Perceivable'
      when Keyword = 'Lack of description' then 'Understandable'
      when keyword = 'Lack of access to visually impaired people' then 'Perceivable'
      when Keyword = 'Element required finger for use' then 'Operable'
      when Keyword = 'Other navigating issue' then 'Operable'
      when Keyword = 'Fails to distinguish pages' then 'Understandable'
      when Keyword = 'Other keyboard issue' then 'Operable'
      else 'Not labeled'
      END;
	
      

update alleged_issues
set POUR_Principal=
Case 
when Keyword = 'Incorrect Reading Sequence' then 'Perceivable'
when Keyword = 'Issue with radio buttons' then 'Operable'
when Keyword = 'Mislabeled image' then 'Understandable'
when Keyword = 'Only use color to convey information' then 'Perceivable'
when Keyword = 'UI element cannot be determined via program' then 'Understandable'
else POUR_Principal
end;


SELECT Count(*) as Total, POUR_Principal
from alleged_issues
where POUR_Principal in ("Perceivable", "Operable", "Understandable", "Robust")
group by POUR_Principal
order by Total desc;

SELECT DISTINCT Keyword 
from alleged_issues
where POUR_Principal = 'Not labeled';
    
    