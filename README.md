# matlab_utilities

This repository contains several general MatLab utilities and functions that are deemed applicable to a wide range of projects.

## Set-up

To setup all tools within your main file, you can simply run the [SetupTools.m](SetupTools.m) script with:
	`run('<path to tools repository>/SetupTools.m')`
This will load all the folders so you can use all the functions.

## Integrity checker

Several functions make use of each-other, so it is important to check the integrity of the tool and make sure that all dependencies are met. If you are on a UNIX system, this can be done using the [integrity_checker.m](integrity_checker.m) script (you will have to provide the super-user password).

The script also checks for potential duplicate files (based on filename).

## Contributing

If you plan to contribute, the general guidelines for development are:

* Editing of existing functions to make them better (no bugs, faster, more robust) is highly encouraged. 
* Editing of existing comments to make them more comprehensive is also encouraged.
* Limit changing inputs/outputs of functions as other people using such functions may be confused in the future when their script doesn't work.
* Functions should be as general and robust as possible.
* Please comment your code as well as possible!
