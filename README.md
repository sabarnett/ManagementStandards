# ManagementStandards
Tool to assess knowledge against a set of management standards.

Many years ago, I worked with a company that sought to simplify the UK Management Standards books and make it easier for prospective managers to determine which of the many standards applied to them in their role. Back then, I wrote a tool in VB6 that parsed a questionnaire file and, based on the answers given, identified which of the management standards applied to them.

This tool is the iOS version of that questionnaire tool. 

## Description

The user is presented with a series of questions. Which questions are presented depends on the answer they gave to the previous question, so the path through the questions is not linear. As they answer questions, units from the management standards are added to their profile. Once the questionnaire has been completed, the list of units is presented to the user in various formats. They use these to index into the master documentation.

## Getting Started

### Dependencies

This app is dependent on a package called MaurkdowUI which I use to convert the final report into several formats.

### Installing

Download the source and compile it. 


