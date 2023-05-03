resuparse
=========

Converts a text resume to a JSON structure.

## SYNOPSIS

This is an awk script for converting a text resume into JSON. The
output can be used with a templating system to generate PDF resumes
using tools like LaTeX.

## USAGE

```
awk -f resuparse.awk resume.txt > resume.json
```

## EXAMPLE

Here is an example text resume:

```
Rosie Miller

Pittsburgh, PA 15201
(555) 555-5555
example@example.com

PROFESSIONAL SUMMARY
====================

Experienced Restaurant Manager bringing demonstrated success in developing and motivating strong restaurant teams capable of handling over 200 customers hourly. Keeps all areas clean and sanitized while managing inventory and preventing waste. Consistent career history of operations improvement, team building and revenue increases.

WORK HISTORY
====================

March 2014 to Current
Outback Steakhouse – Pittsburgh, PA
Restaurant Manager

+ Reduced labor costs by 17% percent while maintaining excellent service and profit levels
+ Managed a 7-person team of cooks and back of house staff and a team of 8 front house staff for a busy steakhouse restaurant
+ Continuously evaluated business operations to effectively align workflows for optimal area coverage increasing customer satisfaction rating by 80%

December 2010 to February 2014
TGI Fridays – Pittsburgh, PA Assistant
Restaurant Manager

+ Reduced restaurant’s annual food and labor costs by 15% through proper budgeting, scheduling and management of inventory
+ Kept restaurant compliant with all federal, state and local hygiene and food safety regulations which kept food safety score between 95-100 every inspection
+ Coordinated kitchen stations with managers to cut down on customer wait times by 50%

July 2007 to November 2010
BJ’s Restaurants, Inc – Pittsburgh, PA
Restaurant Team Leader

+ Assisted customers in placing special orders for large-scale events such as corporate events and birthday parties
+ Recruited and hired over 10 employees offering talent, charisma and experience to restaurant team
+ Pitched in to help host, waitstaff and bussers during exceptionally busy times such as dinner hour

SKILLS
====================

Conflict resolution techniques
Performance improvement
Staff management
Service-oriented
Trained in performance and wage reviews
Business operations
Inventory control and record keeping
Marketing and advertising

EDUCATION
====================

Park Point University - Pittsburgh, PA
Bachelor of Arts Hospitality Management
2001 - 2005
```

And example output:

```
{
  "name": "Rosie Miller",
  "location": "Pittsburgh, PA 15201",
  "phone": "(555) 555-5555",
  "email": "example@example.com",
  "summary": "Experienced Restaurant Manager bringing demonstrated success in developing and motivating strong restaurant teams capable of handling over 200 customers hourly. Keeps all areas clean and sanitized while managing inventory and preventing waste. Consistent career history of operations improvement, team building and revenue increases.",
  "experience": [
    {
      "date": "March 2014 to Current",
      "name": "Outback Steakhouse – Pittsburgh, PA",
      "location": "",
      "title": "Restaurant Manager":
      "bullets": [
        "+ Reduced labor costs by 17% percent while maintaining excellent service and profit levels",
        "+ Managed a 7-person team of cooks and back of house staff and a team of 8 front house staff for a busy steakhouse restaurant",
        "+ Continuously evaluated business operations to effectively align workflows for optimal area coverage increasing customer satisfaction rating by 80% December 2010 to February 2014 TGI Fridays – Pittsburgh, PA Assistant Restaurant Manager",
        "+ Reduced restaurant’s annual food and labor costs by 15% through proper budgeting, scheduling and management of inventory",
        "+ Kept restaurant compliant with all federal, state and local hygiene and food safety regulations which kept food safety score between 95-100 every inspection",
        "+ Coordinated kitchen stations with managers to cut down on customer wait times by 50% July 2007 to November 2010 BJ’s Restaurants, Inc – Pittsburgh, PA Restaurant Team Leader",
        "+ Assisted customers in placing special orders for large-scale events such as corporate events and birthday parties",
        "+ Recruited and hired over 10 employees offering talent, charisma and experience to restaurant team",
        "+ Pitched in to help host, waitstaff and bussers during exceptionally busy times such as dinner hour"
      ]
    }
  ],
  "skills": [
    "Conflict resolution techniques",
    "Performance improvement",
    "Staff management",
    "Service-oriented",
    "Trained in performance and wage reviews",
    "Business operations",
    "Inventory control and record keeping",
    "Marketing and advertising"
  ],
  "education": [
    {
      "institution": "Park Point University",
      "location": "Pittsburgh, PA",
      "degree": "Bachelor of Arts Hospitality Management",
      "date": "2001 - 2005"
    }
  ]
}
```
