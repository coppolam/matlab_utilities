# matlab_utilities

This repository contains several general MatLab utilities and functions that are deemed applicable to a wide range of projects.

## Set-up

To setup all tools within your main file, you can simply run the [SetupTools.m](SetupTools.m) script as follows:
	`run('$MATLABTOOLS/tools/SetupTools.m')`
Feel free to define the environment variable **$MATLABTOOLS_HOME** as you like or just write the path manually into the command, since this is the only time in which it will be used.

## Consistency checker

Several functions make use of each-other, so it is important to check the integrity of tool. If you are on a UNIX system, this can be done using the [integrity_checker.m](integrity_checker.m) script (you will have to provide the super-user password).

The script also checks for potential duplicate files (based on filename), so that we can make sure no duplicates are present.

## Contributing

If you plan to contribute, the general rules for development:

* Editing of existing functions to make them better (no bugs/faster/more robust) is highly encouraged. 
* However, try to not change inputs/outputs of functions as other people using such functions may be confused in the future when their code doesn't work.
* Functions should be as general and robust as possible.
* Please comment your code as well as possible!