# zTD_Month_Dim_Gen
IBM Planning Analytics Month level Dimension Generator

zTD_Month_Dim_Gen - Description

Copyright Success Cubed Ltd - www.successcubed.co.uk

Licensing - See the GNU LIcense.

This should be run in Perspectives. It uses a combination of Excel, VBA, and TI.

This generates a series of CSV files which can then be read by the provided
Turbo Integrator Processes to produce a month level time dimension.
The start and end calendar years can be selected.
It will always generate the dimension to include the given range of calendar years.
You can optionally select the generation of various financial years, eg the
financial year starting in month 4 and the financial year starting in month 7.
In this case it obviously cannot generate a full financial year for the first calendar 
year, so you should expand the range of calendar years to one before and one
after the full set of financial years that you require.

The calendar months will be given aliases for the appropriate financial year, eg
for the calendar period E_CL_2018-M04 the financial year starting in month 4, will
have an F4 Alias of E_F4_2018/19-P01.

Named Hierarchies (only visible in PAW or PAX, not Perspectives) will be generated
for various consolidations on the months. 
For consolidations such as YTD (Year to Date), different Named Hierarchies will be 
generated for the calendar year, and also for each of the selected financial years.
For consolidations such as MAT (Moving Annual Total), consolidations will only 
be generated for the calendar years, since the sum of 12 months up to and 
including any calendar month will be no different for a financial period.

The range of time consolidation types generated includes:
Time consolidation type
Year, Half-Year, Quarter, Month
Year, Month
Year to Date
Rest of Year from Date
Year to Date Average
Rest of Year from Date Average
Run Rate YTD Ave * 12
Check for Date
Cumulative to Date incl Starting Bal
Opening to Date (CTD of month before)
Moving Annual Total
Moving Annual Average (MAT/12)
Difference to period before

As well as genarating separate Named Hierarchies for each 
combination of Calendar / Financial Year with each time consolidation type,
you can opt to also have these appear as alternate hierarchies in the
default hierarchy, also known as the classic or conventional TM1 dimension.
See right --->

Relative Periods
It generates attributes giving relative periods:

Prev Per (Previous Period)
Prev Year (Same Period in Previous Year)
Next Per (Next Period)
Next Year (Same Period in the Next Year)

In addtition, each set of consolidations is generated in a logical order so that 
you can use eg DIMIX -3 to go back 3 periods.

Calendar Month Name Alias
The CalMthName Alias can be used to show eg E_CL_2008-M01 as 
E_CL_2008-Jan.
If the system is not being used by english speakers you can change the
month name abbreviations but it is recommended that you keep to 3 letters
so that the month name abbreviation is the same length as eg M01 or P01.

Subsets
It also generates a number of appropriate subsets
Subsets starting with e_ use the CalMthName Alias
Subsets starting with eg F4_ use the financial period alias for the financial year
starting in the given month.
Subsets starting with z_ do not have an alias.
There are subsets for 
base level elements
consolidated level elements
the full hierarchy
the default top level consolidation

Try it
The above attempts to describe what the generated dimension offers.
However, the best way to view it is probably to generate a trial dimension
on a non-production server at your site and to try it out.
It is not really possible in this documentation to show the numerous 
sub-consolidations.

Design Philosophy
We think it still holds true, as a general rule of thumb, that calculating something in rules is about 100 times slower than calculating it by consolidation. 
We have therefore aimed to put many of the common time calculations into consolidations.
This dimension combines year and month into a single dimension, rather than having a separate year dimension and month dimension.
We have often worked in organisations that require more than one time dimension with different meanings, eg Effective Month, Posting Month, Inception Month,
Accident Month, Shipping Month, Booking Month, etc
With multiple time dimensions using a separate year dimension and month dimension for each would mean that most of the dimensions in the cube were solely related to handling time.
We have often worked in organisations where a merger has meant the need to handle parts of the organisation having different financial years or a change of financial year. This is much easier to handle in a combined year and month dimension.
This approach has been in use for many years. With the advent of Named Hierarchies, the generator was modified to make it handle Named Hierarchies.
With Named Hierarchies it is possible to use one Named Hierarchy on Rows and
another Named Hierarchy from the same dimension on Columns. You can therefore
achieve the Year and Month separation without the need to have physically
separate dimensions.
The reason behind the CalMthName Alias is that when dealing with financial years,
in our experience people often still find it easier to see 2021-Jul rather 
than 2020/21-P04, particularly as not all users will be finance users.

Enhancements
If you develop additional time consolidation types that are not included here,
we would ask that you contact us to make them available to others.
If you find an error, then please make us aware of this so that it can be
corrected and made available to others.
If you need additional time consolidation types to be developed but don't have
the experience to do this, then please contact us, as we may be able to help.

info@successcubed.co.uk


