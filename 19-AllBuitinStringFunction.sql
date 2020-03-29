--Built in String methods
--Return the ascii code of given char
Select ASCII('A')
--Return the character of given number
Select CHAR(65)

Declare @start int
set @start=65
while(@start<=122)
begin
	print char(@start)
	set @start=@start+1
End
-- trim the Blank spaces on left side
select LTRIM('      hELLO ')
-- Similarly with RTRIM
select RTRIM('      hELLO      ')

-- using above function at a time
SELECT RTRIM(LTRIM('     HELLO'))  
-- convert the given string in upper /lower case respectively 
select Upper('afshan')
select Lower('AFSHAN')
--reverse the given string
SELECT REVERSE('AFSHAN')
--calculate the spaces and letter of string...space between the string and left side of string is counted in this funtion
Select LEN('AFSHAN')

--Left function return specfied number of character from left side
select LEFT('ABCDRFK',3)

--Right function return specfied number of character from right side
select RIGHT('ABCDRFK',3)

-- CHARINDEX fun return the position of specfied string in given string.
select CHARINDEX('@','sara@aaa.com',1)

-- USING Substring dynamically
Select SUBSTRING('PAM@aaa.com',CHARINDEX('@','PAM@aaa.com',1)+1,LEN('PAM@aaa.com')-CHARINDEX('@','PAM@aaa.com',1))

--Assignment of using above functions
select SUBSTRING(Email,CHARINDEX('@',Email,1)+1,LEN(Email)-CHARINDEX('@',Email,1)) as EmailDomain ,
COUNT(Email) as Total
from tbl_Person
Group by SUBSTRING(Email,CHARINDEX('@',Email,1)+1,LEN(Email)-CHARINDEX('@',Email,1))

--Replicate 
select REPLICATE('  afshan  ',3)

select Name , 
SUBSTRING(Email,1,2) +  REPLICATE('*',5) +
SUBSTRING(Email,CHARINDEX('@',Email), LEN(Email) - CHARINDEX('@',Email)+1) as Email
from tbl_Person

--Space function
Select Space(5)
--Patindex
Select Email , PATINDEX('%@%.com',Email) as occurance from
tbl_Person

--Replace 

Select Email , REPLACE(Email,'com','net') as Replaced from
tbl_Person

--Stuff 
select Name,Email,STUFF(Email,2,3,'*****') as stuffed 
from tbl_Person


