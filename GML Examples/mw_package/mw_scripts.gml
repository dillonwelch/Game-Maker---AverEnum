#define mw_init
/*

Starts up the multiple window system.

mw_init(file)
argument0 - the file to be used to data transfering

It is suggested you put the file in the temporary folder.

*/

globalvar _mw_active _mw_file _mw_file_handling;
{
_mw_active=1
_mw_file=argument0
ini_open(_mw_file)
ini_close()
_mw_file_handling=0
}

#define mw_data_begin
/*

Starts data reading/writing for the multiple window system

*/

if !variable_global_exists("_mw_active") exit
{
_mw_file_handling=1
ini_open(_mw_file)
}

#define mw_data_end
/*

Ends data reading/writing for the multiple window system

*/

if !variable_global_exists("_mw_active") exit
{
_mw_file_handling=0
ini_close()
}

#define mw_data_write
/*

Writes data to the transfer file

mw_data_write(place,data,type)

argument0 - The place to write the data to (remember this so you can retrive it later)
argument1 - The data
argument2 - The type of data (0 is real, 1 is string)

*/

var n
if !variable_global_exists("_mw_active") exit
if _mw_file_handling=0 exit
{
n=boolean(argument2)
if n=0 ini_write_real("Data",string(argument0),real(argument1))
if n=1 ini_write_string("Data",string(argument0),string(argument1))
}

#define mw_data_read
/*

Writes data to the transfer file

Returns the read data

mw_data_read(place,type)

argument0 - The place to read the from
argument1 - The type of data (0 is real, 1 is string)

*/

var n r
if !variable_global_exists("_mw_active") exit
if _mw_file_handling=0 exit
{
n=boolean(argument1)
if n=0 r=real(ini_read_real("Data",string(argument0),0))
if n=1 r=string(ini_read_string("Data",string(argument0),""))
return r
}

#define boolean
var ___;
{
___=round(argument0)
if ___>1 ___=1
if ___<0 ___=0
return ___
}

