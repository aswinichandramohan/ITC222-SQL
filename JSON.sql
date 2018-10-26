--JSON

--Output the contents of the BusBarn table as JSON auto.
Select *
From BusBarn
for JSON AUTO;
[
  {
    "BusBarnKey": 1,
    "BusBarnAddress": "1341 City South",
    "BusBarnCity": "Seattle",
    "BusBarnZipCode": "98100",
    "BusBarnPhone": "2065554433"
  },
  {
    "BusBarnKey": 2,
    "BusBarnAddress": "980 Bellevue Plaza",
    "BusBarnCity": "Bellevue",
    "BusBarnZipCode": "98301",
    "BusBarnPhone": "3605551111"
  },
  {
    "BusBarnKey": 3,
    "BusBarnAddress": "1800 MoonLake Drive",
    "BusBarnCity": "Tukwilla",
    "BusBarnZipCode": "98101",
    "BusBarnPhone": "2535553332"
  },
  {
    "BusBarnKey": 4,
    "BusBarnAddress": "2020 RailYard Blvd.",
    "BusBarnCity": "Kent",
    "BusBarnZipCode": "98211",
    "BusBarnPhone": "2155550087"
  }
]
 
 
--Output the contents of Busbarn with JSON Path, make the Address and Inner Object. "Address.Street" etc.
Select 
	BusBarnKey, 
	BusbarnPhone, 
	BusBarnAddress as 'address.street',
	BusbarnCity as 'address.city', BusBarnZipCode as 'address.zipCode'
From BusBarn
for JSON Path;
[
  {
    "BusBarnKey": 1,
    "BusbarnPhone": "2065554433",
    "address": {
      "street": "1341 City South",
      "city": "Seattle",
      "zipCode": "98100"
    }
  },
  {
    "BusBarnKey": 2,
    "BusbarnPhone": "3605551111",
    "address": {
      "street": "980 Bellevue Plaza",
      "city": "Bellevue",
      "zipCode": "98301"
    }
  },
  {
    "BusBarnKey": 3,
    "BusbarnPhone": "2535553332",
    "address": {
      "street": "1800 MoonLake Drive",
      "city": "Tukwilla",
      "zipCode": "98101"
    }
  },
  {
    "BusBarnKey": 4,
    "BusbarnPhone": "2155550087",
    "address": {
      "street": "2020 RailYard Blvd.",
      "city": "Kent",
      "zipCode": "98211"
    }
  }
]
 
 
--Use OpenJSON to parse this JSON object
'{"_id" : 1, "product": "IPad", "price" : 894.50, "quantityAvailable" : 13}'
Ans:
Declare @JSON nvarchar(max)
Set @JSON=N'{"_id" : 1, "product": "IPad", "price" : 894.50, "quantityAvailable" : 13}'
SELECT *
FROM OPENJSON(@JSON);


--Now use OPENJSON with the path object to explicitly map the following records to columns and fields.
'[
    {"_id" : 1, "product": "IPad", "price" : 894.50, "quantityAvailable" : 13},
    {"_id" : 2, "product": "Chrome Book", "price" : 245.99, "quantityAvailable": 23},
    {"_id" : 3, "product": "Bose Lap Top Speakers", "price" : 89.50, "quantityAvailable" : 10},
    {"_id" : 4, "product": "Blue Tooth Game Controller", "price" : 149.99, "quantityAvailable" : 3},
    {"_id" : 5, "product": "Star Wars Mouse Pad", "price" : 1.50, "quantityAvailable" : 100},
    {"_id" : 6, "product": "Dell XPS Desk Top Computer", "price" : 945.00, "quantityAvailable" : 7},
    {"_id" : 7, "product": "Microsoft Surface Pro", "price" : 1250.75, "quantityAvailable" : 9},
    {"_id" : 8, "product": "Norton Anti Virus", "price" : 75.50, "quantityAvailable": 2},
    {"_id" : 9, "product": "Mechanical Keyboard", "price" : 125.50, "quantityAvailable" : 3},
    {"_id" : 10, "product": "Android Tablet", "price" : 345.23, "quantityAvailable" : 5}
  ]'
Ans:
Declare @JSON nvarchar(max)
Set @JSON=N'[
    {"_id" : 1, "product": "IPad", "price" : 894.50, "quantityAvailable" : 13},
    {"_id" : 2, "product": "Chrome Book", "price" : 245.99, "quantityAvailable": 23},
    {"_id" : 3, "product": "Bose Lap Top Speakers", "price" : 89.50, "quantityAvailable" : 10},
    {"_id" : 4, "product": "Blue Tooth Game Controller", "price" : 149.99, "quantityAvailable" : 3},
    {"_id" : 5, "product": "Star Wars Mouse Pad", "price" : 1.50, "quantityAvailable" : 100},
    {"_id" : 6, "product": "Dell XPS Desk Top Computer", "price" : 945.00, "quantityAvailable" : 7},
    {"_id" : 7, "product": "Microsoft Surface Pro", "price" : 1250.75, "quantityAvailable" : 9},
    {"_id" : 8, "product": "Norton Anti Virus", "price" : 75.50, "quantityAvailable": 2},
    {"_id" : 9, "product": "Mechanical Keyboard", "price" : 125.50, "quantityAvailable" : 3},
    {"_id" : 10, "product": "Android Tablet", "price" : 345.23, "quantityAvailable" : 5}
  ]'
Select * from OpenJSON(@JSON)
with(
Id int '$._id',
Product nvarchar(255) '$.product',
Price decimal(8,2) '$.price',
Quantity int '$.quantityAvailable'
)


