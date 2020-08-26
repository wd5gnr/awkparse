# AwkParse
Public domain by Al Williams @ Hackaday

## Steps to use
1. include functions in your script
2. Call fields_setup with your regular expression (see below)
3. Call fields_setupN to identify each () expression with a name
4. For each line, call fields_process
5. If the call returns true, you can extract data from Fields_fields by name.

## Example
    BEGIN  {
	   fields_setup("^(([0-9]{3})-([0-9]{3})-([0-9]{4}))$")
	   fields_setupN(1,"phone")
	   fields_setupN(2,"areacode")
	   fields_setupN(3,"prefix")
	   fields_setupN(4,"digits")
	   }
	   
	   {
	   v=if (fields_process()) {
	     # do things with Fields_fields["prefix"] etc.
		 }
		 
## Notes
1. Good idea to start with ^ and end with $, although not required
2. Can make a "remainder" field with "(.*)$" at the end of pattern
3. Note that nested parenthesis work. Number of field is the count of open parentheis characters (e.g., field 1 above is the entire phone number, but field 2 is the area code).
4. Don't forget spaces if you want them. For example: "^[[:space:]]*(([0-9]{3}..."
5. You can use FPAT to split a line into fields using multiple regex repeated over and over. This library lets you totally define the entire line using multiple seperator characters. For example: ^([a-zA-z]{1,3})(0-9]*)$ would pick up a field with 1-3 alpha characters and another with any number of digits following.
6. Requires gawk (not awk, mawk, etc.) due to extensions to match()
