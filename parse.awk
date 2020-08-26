#!/usr/bin/awk -f


function fields_setup(fpattern) {
    Fields_pattern=fpattern
}

function fields_setupN(n,tag) {
    Fields_tag[n]=tag;
}

function fields_process(i,v,fields) {  # i and v are local variables as is fields
    v=match($0,Fields_pattern,fields)
    if (v=1)  {
	for (i in Fields_tag) 	{
	    Fields_fields[Fields_tag[i]]=fields[i];  # copy to named values
	}
    }
    else delete Fields_fields
    return RLENGTH!=-1;
}


# Data file format:
# MM/DD/YY HH:MM item, price *
# MM/DD/YY (date with two digits for all months, e.g., 01/01/2009 not 1/1/2009. Year must be from 2000-2199.
# HH:MM (Hour and minute using 24 hour time with two digits, e.g. 01:02 not 1:02.
# text - Any text that does not contain a comma
# extra - some more text, no comma and no "*" character
# * - An optional 0 to 5 * characters (space between extra and * is optional)

BEGIN {
    fields_setup("^(([01][0-9])/([0-3][0-9])/(2[01][0-9][0-9]))[[:space:]]*(([0-2][0-9]):([0-5][0-9]))[[:space:]]+([^,]+),[[:space:]]*([0-9.]+)[[:space:]]*([*]{1,5})?[[:space:]]*$")
    fields_setupN(1,"date")
    fields_setupN(2,"month")
    fields_setupN(3,"day")
    fields_setupN(4,"year")
    fields_setupN(5,"time")
    fields_setupN(6,"hours")
    fields_setupN(7,"minutes")
    fields_setupN(8,"item")
    fields_setupN(9,"price")
    fields_setupN(10,"star")
}


   {
       v=fields_process()
       if (v) {
	   for (i in Fields_fields) {
	       print i " : " Fields_fields[i]
	   }
       }
       else 
	   print "No data"
       
   }

   
