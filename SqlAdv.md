# The Advanced SQL Server Masterclass For Data Analysis

<!-- TOC -->

- [The Advanced SQL Server Masterclass For Data Analysis](#the-advanced-sql-server-masterclass-for-data-analysis)
    - [Introducing Window Functions With OVER [7]](#introducing-window-functions-with-over-7)
    - [Introducing Window Functions With OVER - Exercises [8]](#introducing-window-functions-with-over---exercises-8)
    - [PARTITION BY [9]](#partition-by-9)
    - [PARTITION BY - Exercises [10]](#partition-by---exercises-10)
    - [ROW_NUMBER [11]](#row_number-11)
    - [ROW_NUMBER - Exercises [12]](#row_number---exercises-12)
    - [RANK and DENSE_RANK [13]](#rank-and-dense_rank-13)
    - [RANK and DENSE_RANK - Exercises [14]](#rank-and-dense_rank---exercises-14)
    - [LEAD and LAG [15]](#lead-and-lag-15)
    - [LEAD and LAG - Exercises [16]](#lead-and-lag---exercises-16)
    - [Introducing Subqueries [17]](#introducing-subqueries-17)
    - [Introducing Subqueries - Exercises [18]](#introducing-subqueries---exercises-18)
    - [Scalar Subqueries [19]](#scalar-subqueries-19)
    - [Scalar Subqueries - Exercises [20]](#scalar-subqueries---exercises-20)
    - [Correlated Subqueries [21]](#correlated-subqueries-21)
    - [Correlated Subqueries - Exercises [22]](#correlated-subqueries---exercises-22)
    - [EXISTS [23]](#exists-23)
    - [EXISTS - Exercises [24]](#exists---exercises-24)
    - [FOR XML PATH With STUFF [25]](#for-xml-path-with-stuff-25)
    - [FOR XML PATH With STUFF - Exercises [26]](#for-xml-path-with-stuff---exercises-26)
    - [PIVOT - Part 1 [27]](#pivot---part-1-27)
    - [PIVOT - Part 2 [28]](#pivot---part-2-28)
    - [PIVOT - Exercises [29]](#pivot---exercises-29)
    - [CTEs - Part 1 [30]](#ctes---part-1-30)
    - [CTEs - Part 2 [31]](#ctes---part-2-31)
    - [CTEs - Exercise [32]](#ctes---exercise-32)
    - [Recursive CTEs [33]](#recursive-ctes-33)
    - [Recursive CTEs - Exercises [34]](#recursive-ctes---exercises-34)
    - [Temp Tables - Part 1 [35]](#temp-tables---part-1-35)
    - [Temp Tables - Part 2 [36]](#temp-tables---part-2-36)
    - [Temp Tables - Exercises [37]](#temp-tables---exercises-37)
    - [CREATE and INSERT [38]](#create-and-insert-38)
    - [CREATE and INSERT - Exercise [39]](#create-and-insert---exercise-39)
    - [TRUNCATE - Part 1 [40]](#truncate---part-1-40)
    - [TRUNCATE - Part 2 [41]](#truncate---part-2-41)
    - [TRUNCATE - Exercise [42]](#truncate---exercise-42)
    - [UPDATE - Part 1 [43]](#update---part-1-43)
    - [UPDATE - Part 2 [44]](#update---part-2-44)
    - [UPDATE - Exercise [45]](#update---exercise-45)
    - [DELETE [46]](#delete-46)
    - [Optimizing With UPDATE - Part 1 [47]](#optimizing-with-update---part-1-47)
    - [Optimizing With UPDATE - Part 2 [48]](#optimizing-with-update---part-2-48)
    - [Optimizing With UPDATE - Exercise [49]](#optimizing-with-update---exercise-49)
    - [An Improved EXISTS With UPDATE [50]](#an-improved-exists-with-update-50)
    - [An Improved EXISTS With UPDATE - Exercise [51]](#an-improved-exists-with-update---exercise-51)
    - [Introducing Indexes [52]](#introducing-indexes-52)
    - [Optimizing With Indexes - Example [53]](#optimizing-with-indexes---example-53)
    - [Optimizing With Indexes - Exercise [54]](#optimizing-with-indexes---exercise-54)
    - [Lookup Tables - Part 1 [55]](#lookup-tables---part-1-55)
    - [Lookup Tables - Part 2 [56]](#lookup-tables---part-2-56)
    - [Lookup Tables - Exercises [57]](#lookup-tables---exercises-57)
    - [Variables - Part 1 [58]](#variables---part-1-58)
    - [Variables - Exercise 1 [59]](#variables---exercise-1-59)
    - [Variables - Part 2 [60]](#variables---part-2-60)
    - [Variables - Exercise 2 [61]](#variables---exercise-2-61)
    - [Introducing User Defined Functions [62]](#introducing-user-defined-functions-62)
    - [NOTE TO STUDENTS [63]](#note-to-students-63)
    - [Making Functions Flexible With Parameters [64]](#making-functions-flexible-with-parameters-64)
    - [User Defined Functions - Exercises [65]](#user-defined-functions---exercises-65)
    - [Stored Procedures [66]](#stored-procedures-66)
    - [Stored Procedures - Exercise [67]](#stored-procedures---exercise-67)
    - [Control Flow With IF Statements [68]](#control-flow-with-if-statements-68)
    - [Control Flow With IF Statements - Exercise [69]](#control-flow-with-if-statements---exercise-69)
    - [Using Multiple IF Statements [70]](#using-multiple-if-statements-70)
    - [Using Multiple IF Statements - Exercise [71]](#using-multiple-if-statements---exercise-71)
    - [Dynamic SQL - Part 1 [72]](#dynamic-sql---part-1-72)
    - [Dynamic SQL - Part 2 [73]](#dynamic-sql---part-2-73)
    - [Dynamic SQL - Exercises [74]](#dynamic-sql---exercises-74)

<!-- /TOC -->

## Introducing Window Functions With OVER [7]
## Introducing Window Functions With OVER - Exercises [8]
## PARTITION BY [9]
## PARTITION BY - Exercises [10]
## ROW_NUMBER [11]
## ROW_NUMBER - Exercises [12]
## RANK and DENSE_RANK [13]
## RANK and DENSE_RANK - Exercises [14]
## LEAD and LAG [15]
## LEAD and LAG - Exercises [16]
## Introducing Subqueries [17]
## Introducing Subqueries - Exercises [18]
## Scalar Subqueries [19]
## Scalar Subqueries - Exercises [20]
## Correlated Subqueries [21]
## Correlated Subqueries - Exercises [22]
## EXISTS [23]
## EXISTS - Exercises [24]
## FOR XML PATH With STUFF [25]
## FOR XML PATH With STUFF - Exercises [26]
## PIVOT - Part 1 [27]
## PIVOT - Part 2 [28]
## PIVOT - Exercises [29]
## CTEs - Part 1 [30]
## CTEs - Part 2 [31]
## CTEs - Exercise [32]
## Recursive CTEs [33]
## Recursive CTEs - Exercises [34]
## Temp Tables - Part 1 [35]
## Temp Tables - Part 2 [36]
## Temp Tables - Exercises [37]
## CREATE and INSERT [38]
## CREATE and INSERT - Exercise [39]
## TRUNCATE - Part 1 [40]
## TRUNCATE - Part 2 [41]
## TRUNCATE - Exercise [42]
## UPDATE - Part 1 [43]
## UPDATE - Part 2 [44]
## UPDATE - Exercise [45]
## DELETE [46]
## Optimizing With UPDATE - Part 1 [47]
## Optimizing With UPDATE - Part 2 [48]
## Optimizing With UPDATE - Exercise [49]
## An Improved EXISTS With UPDATE [50]
## An Improved EXISTS With UPDATE - Exercise [51]
## Introducing Indexes [52]
## Optimizing With Indexes - Example [53]
## Optimizing With Indexes - Exercise [54]
## Lookup Tables - Part 1 [55]
## Lookup Tables - Part 2 [56]
## Lookup Tables - Exercises [57]
## Variables - Part 1 [58]
## Variables - Exercise 1 [59]
## Variables - Part 2 [60]
## Variables - Exercise 2 [61]
## Introducing User Defined Functions [62]
## NOTE TO STUDENTS [63]
## Making Functions Flexible With Parameters [64]
## User Defined Functions - Exercises [65]
## Stored Procedures [66]
## Stored Procedures - Exercise [67]
## Control Flow With IF Statements [68]
## Control Flow With IF Statements - Exercise [69]
## Using Multiple IF Statements [70]
## Using Multiple IF Statements - Exercise [71]
## Dynamic SQL - Part 1 [72]
## Dynamic SQL - Part 2 [73]
## Dynamic SQL - Exercises [74]
