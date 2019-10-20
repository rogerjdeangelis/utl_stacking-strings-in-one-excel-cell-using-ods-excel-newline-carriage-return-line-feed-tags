Stacking strings in one excel cell using ods excel newline carriage return line feed tags

SAS Forum
https://tinyurl.com/y2g7967m
https://communities.sas.com/t5/SAS-Programming/Concatenate-with-Carriage-Return-and-special-formatting/td-p/467651

Bruno SAS
https://communities.sas.com/t5/user/viewprofilepage/user-id/32

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;


SASHELP.CLASS total obs=19

Obs    NAME       SEX    AGE    HEIGHT    WEIGHT

  1    Alfred      M      14     69.0      112.5
  2    Alice       F      13     56.5       84.0
  3    Barbara     F      13     65.3       98.0
  4    Carol       F      14     62.8      102.5
...

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;


  d:/xls/d:/xls/stackstrings.xlsx

   +------------------------+
   |  A    |  B |  C |  D   |
   +------------------------+
 1 |NAME   |AGE |SEX |HGTWGT|
   |-------+----+----+------|
 2 |Alfred |14  |M   |69.0  |  ** two strings in one cell
   |       |    |    |112.5 |
   |-------+----+----+------+
 3 |Alice  |13  |F   |56.5  |
   |       |    |    |84.0  |
   |-------+----+----+------+
 4 |Barbara|13  |F   |65.3  |
   |       |    |    |98.0  |
   --------------------------
   ...
   [class]

*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
;



data class;
  set sashelp.class;
  hgtWgt=catx(" ~{newline} ",height,weight);
  drop height weight;
run;quit;

/*
 WORK.CLASS total obs=19

  NAME       SEX    AGE           HGTWGT

  Alfred      M      14    69 ~{newline} 112.5
  Alice       F      13    56.5 ~{newline} 84
  Barbara     F      13    65.3 ~{newline} 98
  Carol       F      14    62.8 ~{newline} 102.5
  Henry       M      14    63.5 ~{newline} 102.5
 ...
*/


ods escapechar='~';

ods excel file="d:/xls/stackstrings.xlsx";

proc print data=class;
var name age sex hgtWgt;
run;quit;

ods excel close;


