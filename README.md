# HappyNash
A Nashville happy hour finder.

This small command-line program asks that the user input a zip code and day of the week, and the program will output a local bar/restaurant with a happy-hour special for that day of the week.

Users will be able to add/edit/delete options.

##Features

    -Adding a new happy hour bar / restaurant
    -Editing a happy hour bar / restaurant
    -Deleting a happy hour bar / restaurant

###Searching for happy hour in Nashville by weekday and zip code
By inputing a day of the week (e.g. "Wednesday") and a Nashville zip code, the user will receive a bar and/or restaurant suggestion that has a drink and/or food special for that day of the week. Output will also include the suggested bar's/restaurant's address, phone number, website, offered special(including price) and happy-hour hours.

Usage Example:
```
> ./happy_nash  
    Search for a Nashville happy hour by day of week and/or zip code:  
    > Wednesday 37217  
    Wilhagan's  
    314 Wilhagan Rd  
    37217  
    615-360-9175  
    https://plus.google.com/116455568721224326104/about?gl=us&hl=en  
    Wednesday 5:00 - 7:00  
    $2 PBRs and $4 Margaritas  

    1. Start over
    >1
```
###Adding a new bar/restaurant with happy hour
In order to provide users with a robust number of results, users can add a new happy-hour location to the database, so long as they can provide, at minimum, the name and address of the location, the day(s) of the week that location offers happy hour, and the drink/food specials offered on that day, including price.

Usage Example:
```
    > ./happy_nash manage
    What would you like to do?
    1. Add a happy hour location
    2. List all happy hour locations  
    3. Exit management menu  
    > 1
    What is the name of the location you want to add?  
    > Wilhagan's  
    What is the street address of this location?  
    > 314 Wilhagan Rd  
    What is the 5-digit zip code of this location?  
    >37217  
    What is the 10-digit phone number of this location? Use the following format: xxx-xxx-xxxx  
    >615-360-9175  
    Does this location have a website? If so, please provide it here:  
    > https://plus.google.com/116455568721224326104/about?gl=us&hl=en  
    Does this location have a Monday happy hour (y/n)?  
    > y  
    What are the hours of the happy hour? Use the following format: 0:00 - 0:00  
    > 5:00 - 7:00  
    Does this location have a Tuesday happy hour (y/n)?  
    > n  
    Does this location have a Wednesday happy hour (y/n)?  
    > n  
    Does this location have a Thursday happy hour (y/n)?  
    > n  
    Does this location have a Friday happy hour (y/n)?  
    > n  
    Does this location have a Saturday happy hour (y/n)?  
    > n  
    Does this location have a Sunday happy hour (y/n)?  
    > n  
    Describe the Monday Happy Hour:  
    > $2 PBRs and $4 Margaritas  
    Thank you for adding Wilhagens to the HappyNash database!  
    What would you like to do?  
    1. Add a happy hour location  
    2. List all happy hour locations
    3. Exit management menu  
```

###Editing an existing bar/restaurant
Editing will allow the users to keep drink/food specials and contact details up to date and accurate as bars and restaurants change their offerings and/or contact information.

Usage Example:
```
    > ./happy_nash manage
    What would you like to do?  
    1. Add a happy hour location  
    2. List all happy hour locations  
    3. Exit management menu  
    > 2  
    1. Wilhagan's  
    2. 3 Crow Bar  
    3. The Green House Bar  
    > 1  
    What would you like to do?  
    1. Edit this location  
    2. Delete this location  
    1 >  
    Wilhagan's  
    314 Wilhagan Rd  
    37217  
    615-360-9175  
    https://plus.google.com/116455568721224326104/about?gl=us&hl=en  
    Monday 5:00 - 7:00  
    $2 PBRs and $4 Margaritas  
    Select the information you would like to edit:  
    1. Name  
    2. Street Address  
    3. Zip Code  
    4. Phone Number  
    5. Website URL  
    6. Happy Hour Hours  
    7. Specials  
    8. Exit Edit Menu  
    > 5  
    Please enter the updated URL below:  
    > www.wilhagans.com  
    You edit has been saved. Select the information you would like to edit:  
    1. Name  
    2. Street address  
    3. Zip code  
    4. Phone number  
    5. Website URL  
    6. Happy hour hours  
    7. Specials  
    8. Exit edit menu  
    > 8  
    What would you like to do?  
    1. Add a happy hour location  
    2. List all happy hour locations  
    3. Exit management menu  
```

###Deleting an existing bar/restaurant
Should a location close or stop offering happy hour users have the ability to remove that bar/restaurant from the database.

Usage Example:
```
    > ./happy_nash manage  
    What would you like to do?  
    1. Add a happy hour location  
    2. List all happy hour locations
    3. Exit management menu  
    > 2  
    1. Wilhagan's  
    2. 3 Crow Bar  
    3. The Green House Bar  
    > 1  
    What would you like to do?  
    1. Edit this location  
    2. Delete this location  
    2 >  
    Wilhagan's  
    314 Wilhagan Rd  
    37217  
    615-360-9175  
    https://plus.google.com/116455568721224326104/about?gl=us&hl=en  
    Monday 5:00 - 7:00  
    $2 PBRs and $4 Margaritas  
    Are you sure you want to delete this location? (y/n):  
    > y  
    You have deleted this happy hour location.  
    What would you like to do?  
    1. Add a happy hour location  
    2. List all happy hour locations  
    3. Exit management menu  
    > 3  
```

###Viewing all happy hours in Nashville
If the user doesn't know their zip code, or simply wants to browse all of the happy hours listed in the database, they can leave the input field blank and receive a list of all of happy hours in Nashville. This complete list will additionally include the day of week details when the locations do happy hour.

Usage Example:
```
    > ./happy_nash
    What would you like to do?  
    1. Add a happy hour location  
    2. List all happy hour locations
    3. Exit management menu  
    > 2  
    1. Wilhagan's  
    2. 3 Crow Bar  
    3. The Green House Bar  
    > 1  
    What would you like to do?  
    1. Edit this location  
    2. Delete this location  
    2 >  
    Wilhagen's  
    314 Wilhagan Rd  
    37217  
    615-360-9175  
    https://plus.google.com/116455568721224326104/about?gl=us&hl=en  
    Monday 5:00 - 7:00  
    $2 PBRs and $4 Margaritas  
    Are you sure you want to delete this location? (y/n):  
    > y  
    You have deleted this happy hour location.  
    What would you like to do?  
    1. Add a happy hour location  
    2. List all happy hour locations  
    3. Exit management menu  
    > 3  
```

###Searching for happy hour in Nashville by weekday
Users may input day of week only to receive a complete list of drink / food specials on that day in Nashville.

Usage Example:
```
    > ./happy_nash  
    Search for a Nashville happy hour by day of week and/or zip code:  
    > Wednesday  
    Wilhagan's  
    314 Wilhagan Rd  
    37217  
    615-360-9175  
    https://plus.google.com/116455568721224326104/about?gl=us&hl=en  
    Wednesday 5:00 - 7:00  
    $2 PBRs and $4 Margaritas  

    3 Crow Bar  
    1024 Woodland St  
    37206  
    615-262-3345  
    3crowbar.com  
    Wednesday 5:00 - 7:00  
    $2 Miller Light and $4 Well Drinks  

    1. Start over  
    >1  
```

###Viewing all happy hours in specific zip code
Users may input zip code only to receive a complete list of drink / food specials in that zip code for every day of the week.
