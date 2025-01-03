
select * from Housing

-- standardize date format
select FormatedSaleDate, convert(date, SaleDate) as FormatedDate
from Housing

update Housing
set SaleDate= convert(date, SaleDate) --not worked

--using alter to try
alter table Housing
add FormatedSaleDate date

update Housing
set FormatedSaleDate= convert(date, SaleDate)



-- populate property Address data

select *--PropertyAddress
from Housing
--where PropertyAddress is null
order by ParcelID


select a.ParcelID,a.PropertyAddress, b.ParcelID, b.PropertyAddress,
isnull(a.PropertyAddress, b.PropertyAddress)
from Housing a
join Housing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


update a
set PropertyAddress=isnull(a.PropertyAddress, b.PropertyAddress)
from Housing a
join Housing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null



--breaking out address into individual columns (address, city, state)

select PropertyAddress
from Housing
--where PropertyAddress is null
order by ParcelID

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, len(PropertyAddress)) as Address
from Housing


alter table Housing
add PropertySplitAddress nvarchar(255)

update Housing
set PropertySplitAddress= SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

alter table Housing
add PropertySplitCity nvarchar(255)

update Housing
set PropertySplitCity= SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, len(PropertyAddress))


select OwnerAddress
from Housing


select 
parsename(replace(OwnerAddress,',','.'),3),
parsename(replace(OwnerAddress,',','.'),2),
parsename(replace(OwnerAddress,',','.'),1)
from Housing


alter table Housing
add OwnerSplitAddress nvarchar(255)

update Housing
set OwnerSplitAddress= parsename(replace(OwnerAddress,',','.'),3)

alter table Housing
add OwnerSplitCity nvarchar(255)

update Housing
set OwnerSplitCity= parsename(replace(OwnerAddress,',','.'),2)

alter table Housing
add OwnerSplitState nvarchar(255)

update Housing
set OwnerSplitState= parsename(replace(OwnerAddress,',','.'),1)





-- change Y and N to Yes and No in "Sold as Vacant" field

select distinct (SoldAsVacant), count(SoldAsVacant)
from Housing
group by SoldAsVacant
order by 2


select SoldAsVacant,
case when SoldAsVacant='Y' then 'Yes'
when SoldAsVacant='N' then 'No'
else SoldAsVacant
end
from Housing

update Housing
set SoldAsVacant= case	when SoldAsVacant='Y' then 'Yes'
						when SoldAsVacant='N' then 'No'
						else SoldAsVacant
						end





--remove duplicates

with RowNumCTE as(
select *,
	ROW_NUMBER() over(
	partition by ParcelID,
	PropertyAddress,
	SalePrice,
	SaleDate,
	LegalReference
	order by 
	UniqueID
	) as row_num


from Housing
--order by ParcelID
)
select * 
from RowNumCTE
where row_num>1
order by PropertyAddress




--delete unused columns 

alter table Housing
drop column OwnerAddress, TaxDistrict, PropertyAddress

alter table Housing
drop column SaleDate 