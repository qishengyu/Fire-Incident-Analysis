# Fire Incidents Data Analysis

## Overview

This repo provides students with a foundation for their own projects associated with *Telling Stories with Data*. You do not need every aspect for every paper and you should delete aspects that you do not need.


## File Structure

The repo is organized as follows:

- `data/raw_data/`: Contains the raw data as obtained from the Toronto Open Data Portal. The original dataset is `Fire Incidents Data`.
- `data/analysis_data/`: Contains the cleaned and processed dataset used for analysis. This includes the transformations and filtering steps applied to the raw data.
- `models/`: Contains any models that were fitted during the analysis (if applicable).
- `scripts/`: Contains R scripts used to simulate, download, clean, and visualize the data. The scripts include:
  - `00-simulate_data.R`: Generates simulated data for initial analysis (if required).
  - `01-download_data.R`: Downloads the actual fire incidents data from the Toronto Open Data Portal.
  - `02-data_cleaning.R`: Cleans and preprocesses the raw data for analysis.
- `paper/`: Contains the files used to generate the final research paper. This includes:
  - `paper.qmd`: The Quarto file used to generate the paper.
  - `references.bib`: A bibliography file that contains all the sources and R packages cited in the paper.
  - `paper.pdf`: The final generated PDF of the analysis.
- `other/`: Contains additional files, sketches, and related literature or notes, including interaction history with LLMs or other relevant information.


## Statement on LLM usage

No

## Some checks

- [ ] Change the rproj file name so that it's not starter_folder.Rproj
- [ ] Change the README title so that it's not Starter folder
- [ ] Remove files that you're not using
- [ ] Update comments in R scripts
- [ ] Remove this checklist