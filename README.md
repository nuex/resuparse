resuparse
=========

Tools for converting text resumes and cover letters to JSON.

## SYNOPSIS

This project contains resuparse and coverparse, awk scripts for
converting text resumes and cover letters to JSON. The output
can be used with a templating system to generate PDF resumes
using tools like LaTeX.

## USAGE

Parsing resumes:

```
awk -f resuparse.awk resume.txt > resume.json
```

Parsing cover letters:

```
awk -f coverparse.awk letter.txt > letter.json
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

March 2014 - Current
Outback Steakhouse - Pittsburgh, PA
Restaurant Manager

+ Reduced labor costs by 17% percent while maintaining excellent service and profit levels
+ Managed a 7-person team of cooks and back of house staff and a team of 8 front house staff for a busy steakhouse restaurant
+ Continuously evaluated business operations to effectively align workflows for optimal area coverage increasing customer satisfaction rating by 80%

December 2010 - February 2014
TGI Fridays - Pittsburgh, PA Assistant
Restaurant Manager

+ Reduced restaurant’s annual food and labor costs by 15% through proper budgeting, scheduling and management of inventory
+ Kept restaurant compliant with all federal, state and local hygiene and food safety regulations which kept food safety score between 95-100 every inspection
+ Coordinated kitchen stations with managers to cut down on customer wait times by 50%

July 2007 - November 2010
BJ’s Restaurants, Inc - Pittsburgh, PA
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

Pittsburgh Technical College - Pittsburgh, PA
Associate Degree, Culinary Arts
1999 - 2001
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
      "date": "March 2014 - Current",
      "name": "Outback Steakhouse",
      "location": "Pittsburgh, PA",
      "title": "Restaurant Manager",
      "bullets": [
        "Reduced labor costs by 17% percent while maintaining excellent service and profit levels",
        "Managed a 7-person team of cooks and back of house staff and a team of 8 front house staff for a busy steakhouse restaurant",
        "Continuously evaluated business operations to effectively align workflows for optimal area coverage increasing customer satisfaction rating by 80%"
      ]
    },
    {
      "date": "December 2010 - February 2014",
      "name": "TGI Fridays",
      "location": "Pittsburgh, PA Assistant",
      "title": "Restaurant Manager",
      "bullets": [
        "Reduced restaurant’s annual food and labor costs by 15% through proper budgeting, scheduling and management of inventory",
        "Kept restaurant compliant with all federal, state and local hygiene and food safety regulations which kept food safety score between 95-100 every inspection",
        "Coordinated kitchen stations with managers to cut down on customer wait times by 50%"
      ]
    },
    {
      "date": "July 2007 - November 2010",
      "name": "BJ’s Restaurants, Inc",
      "location": "Pittsburgh, PA",
      "title": "Restaurant Team Leader",
      "bullets": [
        "Assisted customers in placing special orders for large-scale events such as corporate events and birthday parties",
        "Recruited and hired over 10 employees offering talent, charisma and experience to restaurant team",
        "Pitched in to help host, waitstaff and bussers during exceptionally busy times such as dinner hour"
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
    },
    {
      "institution": "Pittsburgh Technical College",
      "location": "Pittsburgh, PA",
      "degree": "Associate Degree, Culinary Arts",
      "date": "1999 - 2001"
    }
  ]
}
```

Here is an example cover letter:

```
MARTIN STEIN
15 Applegate Way
Sometown, PA 19000
(215) 555-5555
martinstein@somedomain.com

March 21, 2017

Christine Smith
XYZ Company
1224 Main St.
Anytown, PA 55555

Dear Ms. Smith:

Are you searching for a software engineer with a proven ability to develop high-performance applications and technical innovations? If so, please consider my enclosed resume.

Since 2015, I have served as a software engineer for Action Company, where I have been repeatedly recognized for developing innovative solutions for multimillion-dollar, globally deployed software and systems. I am responsible for full lifecycle development of next-generation software, from initial requirement gathering to design, coding, testing, documentation and implementation.

Known for excellent client-facing skills, I have participated in proposals and presentations that have landed six-figure contracts. I also excel in merging business and user needs into high-quality, cost-effective design solutions while keeping within budgetary constraints.

My technical expertise includes cross-platform proficiency (Windows, Unix, Linux and VxWorks); fluency in 13 scripting/programming languages (including C, C++, VB, Java, Perl and SQL); and advanced knowledge of developer applications, tools, methodologies and best practices (including OOD, client/server architecture and self-test automation).

My experience developing user-friendly solutions on time and on budget would enable me to step into a software engineering role at XYZ Company and hit the ground running. I will follow up with you next week, and you may reach me at (215) 555-5555. I look forward to speaking with you.

Sincerely,

Martin Stein
```

And example letter output:

```
{
  "name": "MARTIN STEIN",
  "street": "15 Applegate Way",
  "city": "Sometown, PA 19000",
  "phone": "(215) 555-5555",
  "email": "martinstein@somedomain.com",
  "date": "March 21, 2017",
  "recipient_name": "Christine Smith",
  "recipient_company": "XYZ Company",
  "recipient_street": "1224 Main St.",
  "recipient_city": "Anytown, PA 55555",
  "opening": "Dear Ms. Smith:",
  "body": "Are you searching for a software engineer with a proven ability to develop high-performance applications and technical innovations? If so, please consider my enclosed resume.\n\nSince 2015, I have served as a software engineer for Action Company, where I have been repeatedly recognized for developing innovative solutions for multimillion-dollar, globally deployed software and systems. I am responsible for full lifecycle development of next-generation software, from initial requirement gathering to design, coding, testing, documentation and implementation.\n\nKnown for excellent client-facing skills, I have participated in proposals and presentations that have landed six-figure contracts. I also excel in merging business and user needs into high-quality, cost-effective design solutions while keeping within budgetary constraints.\n\nMy technical expertise includes cross-platform proficiency (Windows, Unix, Linux and VxWorks); fluency in 13 scripting/programming languages (including C, C++, VB, Java, Perl and SQL); and advanced knowledge of developer applications, tools, methodologies and best practices (including OOD, client/server architecture and self-test automation).\n\nMy experience developing user-friendly solutions on time and on budget would enable me to step into a software engineering role at XYZ Company and hit the ground running. I will follow up with you next week, and you may reach me at (215) 555-5555. I look forward to speaking with you.\n",
  "closing": "Sincerely,",
  "sender_name": "Martin Stein"
}
```
