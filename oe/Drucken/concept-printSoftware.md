# Concept for Print Software

This concept will describe the problem, the solution
and how the software should work.

## Problem

Every year the OU prints an overwhelming amount
of paper. It becomes increasingly hard to manage
the amount and to ensure that (only) enough is printed.

## Solution

Our solution to this problem is a command line tool written in Python.
It will live on the server and will make printing the needed amounts
a lot easier. 

### Approach

All the pdf files will be named uniquely and stored in a clearly defined
directory structure. Every file will live in its own directory. A unique
name could be of the following pattern:

<year>_<identifier>_<version>.pdf

The year is 2015 and the version follows a simple schema: V<version number>
The identifier is unique and could contain the name of the responsible work
group or similar. It must only contain alphanumeric characters (no spaces, dashes
or underscores or anything else).

In addition there should be a simple text file named version.txt in each
of these directories. Its content should be the most recent version number.

Now comes the real juicy stuff. There will be a configuration file, which
defines multiple builds. Each build is roughly structured like this:

* identifiers (the identifiers of all files that are included)
* numbers for each identifier (how many times the file should be printed)
* print options for each file (like collate=true, sides=one-sided)

The final command could look like this:
./oe-print --printer=d116_sw <build> <number of prints>

Internally the software will translate that into several lpr shell calls
with the respective options. It will always use the oe user for printing
and some standard print options like -o fit-to-page or -o fitplot which 
are always used for reasons.

To clarify: Every time you press ENTER with a correct command entered,
it will result in several lpr calls. Therefore don't overload the print
system of the iRZ with dozens of prints but wait until these prints have
finished.