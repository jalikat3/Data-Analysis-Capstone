

Update alleged_issues
SET Keyword= 
        CASE
			WHEN Issue LIKE '%Contrast%' AND ISSUE LIKE '%Low%' THEN 'Low Contrast'
			WHEN Issue LIKE '%keyboard%'AND (ISSUE LIKE '%lack%' or ISSUE LIKE '%missing%') And issue like '%focus%'  THEN 'Missing Keyboard Focus Indicator'
			WHEN Issue LIKE '%keyboard%' and (issue like '%no%' or issue like '%lack%' or issue like '%cannot%' or issue like '%missing%' or issue like '%denial%') THEN 'Lack of Proper Keyboard Support'
			WHEN (ISSUE LIKE '%same link%' or issue like '%adjacent link%') and issue like '%different destination%' then 'Redundant links' 
            WHEN Issue LIKE '%navigation%'or issue like '%navigate%' and (issue like '%lack%' or issue like '%not%' or issue like '%cannot%' or issue like '%no%') THEN 'Lack of Proper Navigation'
            WHEN (ISSUE LIKE '%alt-text%' OR ISSUE LIKE '%Alternative Text%' OR ISSUE LIKE '%Alt Text%' or issue like '%alt. text%' or issue like '%text equivalent%' or issue like '%alt attribute%') AND (Issue Like '%Missing%' OR ISSUE LIKE '%Lack%' or issue like '%not%') Then 'Missing Alt-Text'
            WHEN Issue LIKE '%Image%' and issue like  '%Alt-text%' THEN 'Missing Alt-Text'
            when issue like '%missing%' and issue like '%image%' and issue like '%description%' then 'Missing Alt-Text'
            when issue like '%no%' and issue like '%text%' then 'Missing Alt-Text'
            when issue like '%ALT%' then 'Missing Alt-Text'
			WHEN Issue LIKE '%reading sequence%' AND (ISSUE like '%not%' or ISSUE like '%incorrect%' or ISSUE like '%cannot%') THEN 'Incorrect Reading Sequence'
			WHEN (Issue LIKE '%mislabeled%' or ( (issue like '%no%' or issue like '%fail%') and issue like '%label%')) and Issue like '%button%' THEN 'Mislabeled Buttons'
            WHEN ISSUE LIKE '%Screen%' and issue like '%reader%' then 'Lack of Screen Reader Support'
            WHEN Issue LIKE 'role%' and (issue like '%cannot%' or issue like '%unclear%') THEN 'Unclear UI Element Identification'
            WHEN (Issue LIKE '%broken%' or issue like '%broke%') and issue like '%link%' THEN 'Broken Links'
            WHEN Issue LIKE '%Empty%' and Issue like '%button%' THEN 'Empty Buttons'
            WHEN Issue LIKE '%link%' and issue like '%determine%' THEN 'Unclear Link Purpose'
            when issue like '%fail%' and issue like '%distinguish%' and issue like '%page%' then 'Fails to distinguish pages'
            when issue like '%color%' and (issue like '%mean%' or issue like '%info%') then 'Only use color to convey information'
            when (issue like '%multiple%' or issue like '%duplicate%') and ISSUE LIKE '%ID%' then 'Element contains duplicate IDs'
            WHEN Issue LIKE '%lack%' and issue like '%title%' THEN 'Lack of Descriptive Titles'
            when issue like '%headings%' and issue like '%describe%' then 'Lack of Descriptive Heading'
            when (issue like '%no%' or issue like '%lack%') and issue like '%heading%' then 'Lack of Headings'
            WHEN Issue LIKE '%language%'and (issue like '%cannot%' or issue like '%unclear%' or issue like '%undefined%')THEN 'Undefined Page Language'
            WHEN Issue LIKE '%bypass blocks%' THEN 'Missing Mechanism to Bypass Content'
            WHEN Issue LIKE '%Empty%' AND Issue LIKE '%Link%' THEN 'Empty Links'
            WHEN (Issue LIKE '%Empty%' or issue like '%missing%') and issue like '%form %' and issue like '%label%' THEN 'Empty or Missing Form Labels'
            when issue like '%Empty%' or issue like '%broken%' then 'Empty or Broken Element'
			WHEN (Issue LIKE '%mislabeled%' and (issue like '%no%' or issue like '%fail%' or issue like '%element%'))  THEN 'Mislabeled Element'
            WHEN Issue like '%title%' and (issue like '%not%' or issue like '%without%') THEN 'Element without Title'
            WHEN Issue LIKE '%markup%' AND (Issue like '%error%' or Issue like '%not%' or Issue like '%missing%' or Issue like  '%failure%') THEN 'Markup Errors'
            WHEN Issue LIKE '%Text%' and issue like '%resize%' THEN 'Text Not Resizable'
			WHEN Issue LIKE '%resize%' THEN 'Element Not Resizable'
            WHEN (Issue LIKE '%label%' or issue like '%prompt%') and (issue like '%not%' or issue like '%no%' or issue like '%lack%' or issue like '%fail%') or issue like '%unlabeled%' then 'Missing label'
            WHEN Issue LIKE '%Mouse%' and (issue like '%only%' or issue like '%required%') THEN 'Lack of Proper Keyboard Support'
			When Issue LIKE '%lack%' and ISSUE LIKE '%navigation%' then 'Lack of Proper Navigation'
            When Issue LIKE '%lack%' and ISSUE LIKE  '%keyboard access%' then 'Lack of Proper Keyboard Support'
            WHEN Issue LIKE '%Redundant%' and ISSUE LIKE '%links%' THEN 'Redundant Links'
            WHEN Issue LIKE '%Inaccessible checkout system%' THEN 'Inaccessible Checkout System'
            WHEN Issue LIKE '%label%' and issue like '%without%' THEN 'Missing label'
            WHEN ISSUE LIKE '%Empty%' OR ISSUE LIKE '%blank%' Then 'Empty or Broken Element'
            WHEN ISSUE LIKE '%Inaccessible%' Then 'Inaccessible Element'
            WHEN ISSUE LIKE '%unaccessible%' then 'Inaccessible Element'
            WHEN ISSUE LIKE '%accessible%' and issue like '%forms%' then 'Inaccessible forms'
            WHEN ISSUE LIKE '%mouse%' and (issue like '%click%' or issue like '%require%') then 'Lack of Proper Keyboard Support'
            WHEN ISSUE LIKE '%contain%' and issue like '%same title elements%' then 'Duplicate Titles'
            WHEN ISSUE LIKE '%missing%' then 'Missing Element' 
            WHEN ISSUE LIKE '%unreadable%' then 'Unreadable element'
            WHEN ISSUE LIKE '%scaling%' or issue like '%zoom%' then 'Element not resizable'
            WHEN ISSUE LIKE '%image%' and issue like '%map%' then 'Lack of Image Mapping'
            when issue like '%missing%' and issue like '%description%' then 'Missing Description'
            WHEN ISSUE LIKE '%closed caption%' or issue like '%closed-caption%' then 'Lack of closed captioning'
            WHEN ISSUE LIKE '%link%' and issue like '%purpose%' then 'Unclear link purpose'
            when issue like '%mislabeled%' and issue like '%image%' then 'Mislabeled image'
            when issue like '%mislabel%' or issue like '%label%' then 'Mislabeled element'
            when issue like '%lack%' and issue like '%description%' then 'Lack of description'
            when issue like '%finger%' then 'Element required finger for use'
            when issue like '%UI%' and issue like '%determine%' then 'Unclear UI element'
            when issue like '%loss%' and issue like '%information%' then 'Loss of information'
            when issue like '%not%' and issue like '%readable%' then 'Unreadable element'
            when issue like '%form%' and issue like '%label%' then 'Other form label issue'
            when issue like '%image%' then 'Other image issue'
            when issue like '%keyboard%' then 'Other keyboard issue'
            when issue like '%radio%' and issue like '%button%' then 'Issue with radio buttons'
            when issue like '%not%' and issue like '%describe%' then 'Other description issue'
            WHEN (ISSUE LIKE '%violation%' or issue like '%NYSHRL%' or issue like '%damages%' or issue like '%New York City%' or issue like '%attorney%' or issue like '%Court%' or issue like '%act%' or ISSUE LIKE '%Americans with Disabilities%' or issue like '%civ. code%' or issue like '%law%' or issue like '%relief%' or issue like '%section%') or issue is null then 'N/A'
            when issue like '%access%' then 'Other accessibility issue'
            when issue like '%not%' and issue like '%language%' then 'Other language issue'
            when issue like '%navigating%' then 'Other navigating issue'
            when issue like '%access%' then 'Other access issue'
            when issue like '%no%' and (issue like '%return%' or issue like '%back%') then 'Lack of proper navigation'
            when issue like '%inaccessibility%' or issue like '%inaccessible%' then 'Other accessibility issue'
            when issue like '%information%' and issue like '%not%' then 'Loss of information'
            when issue like '%visual%' and issue like '%impair%' then 'Lack of access to visually impaired people'
            ELSE 'Other Non-Empty Issue'
    END;
    
    
    
select count(*) as total, issue, keyword
from alleged_issues
where keyword = 'Other Non-Empty Issue'
group by issue
order by total  desc;

select count(*) from alleged_issues
where keyword = 'Other Non-Empty Issue';

select ID, issue, keyword
from alleged_issues
where keyword='Other Non-Empty Issue'
and issue="Many pages on the Website also contain the same title elements"
;
select * from website_lawsuits_compiled
where ID in(select ID
from alleged_issues
where keyword='Other Non-Empty Issue'
and issue="Many pages on the Website also contain the same title elements"
);

SET SQL_SAFE_UPDATES = 0;

SELECT Count(*) as total, keyword FROM alleged_issues
where keyword in ('N/A', 'Other Non-Empty Issue')
group by Keyword
order by total desc;

Update alleged_issues
set Keyword=
case when issue like '%UI%' and issue like '%determine%' then 'Unclear UI element'
else Keyword
End;
