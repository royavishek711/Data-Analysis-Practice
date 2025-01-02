drop table if exists string
create table string
(
id varchar(20),
names varchar(20),
loc varchar(50),
)

insert into string values
('    100', 'jon     ', '    aus'),
('102     ', '    mave n ', 'ind- jk')

select * from string

select names, trim(names) as err
from string 

select names, ltrim(names) as err
from string 

select id, rtrim(id) as err
from string 

select loc, replace(loc, '- jk', '') as fixedloc
from string 

select substring(id,2,6)
from string

select loc, upper(loc)
from string

select loc, lower(loc)
from string