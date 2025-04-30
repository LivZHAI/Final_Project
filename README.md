# Final Project Guidance

Welcome to Siyu's repo🏠! This repository will be updated with any changes or new information regarding my final project—Lung Cancer Data Analysis. All relevant materials are included in this repository, including the patient data set and all R code used to generate tables, figures, and reports.

------------------------------------------------------------------------

## 📝Contents of report

This report will follow a formal data analysis workflow involving variable description, exploratory analysis and model establishment to explore the main cause of lung cancer, and finally generate suggestions for preventing lung cancer efficiently.

## 📊Obtaining the data

Data is stored in the folder of `data` and you can directly download it if need.\
This data set contains information on 1000 patients with lung cancer, including their demographics (age, gender), levels of a series of exposure (air pollution exposure, alcohol use, dust allergy, occupational hazards, genetic risk, chronic lung disease, balanced diet, obesity, smoking, passive smoker) and specific body symptoms (chest pain, coughing of blood, fatigue, weight loss ,shortness of breath ,wheezing ,swallowing difficulty ,clubbing of finger nails and snoring), 26 columns in total.

## 💻Initial code description

`code/01_make_tables.R`

-   generates variable description table, saves as `table1_variable.rds`
-   generates descriptive statistics table, saves as `table2_descriptive.rds`
-   generates table of smoking level, saves as `table3_smoking.rds`
-   generates table of shortness of breath level, saves as `table4_breath.rds`
-   all tables are output in `output/` folder

`code/02_make_figures.R`

-   generates a correlation heat map, saves as `figure1_heatmap.png`
-   generates a stacked bar chart for variable of exposure, saves as `figure2_barExposure.png`
-   generates a stacked bar chart for variable of symptom, saves as `figure3_barSymptom.png`
-   all figures are output in `output/` folder

`code/03_render_report.R`

-   renders `Interim_Report.Rmd`

------------------------------------------------------------------------

## 📄 How to Generate the Final Report

To generate the final report, follow these steps:

1.  **Download Project folder from GitHub**

2.  **Ensure Required Packages are Installed in Your Rstudio**\
    `knitr`, `kableExtra`, `dplyr`,`labelled`, `gtsummary`, `ggplot2`, `reshape2`, `gt`

    Additionally, to make your preparation tasks easier, `renv` library is installed here to help you synchronize your local package repository. Please type `renv::activate()` `renv::status()` `renv::restore()` in turn in your R console.

    If you still feel a little bit cumbersome to synchronize packages, don't worry! Here is another much easier way. Please just run `make install` in your terminal, and everything is done!

3.  **Change terminal path to the project and click `make` in your terminal**

------------------------------------------------------------------------

## 🔗 Instructions for DockerHub and Building Image

**Way 1:**\
Directly pull the image from DockerHub to your local:\
`docker pull livzhaidocker/project_image: final_project_tag`

then run the image and make report in the container:\
`docker run -it livzhaidocker/project_image:final_project_tag`\
`make report/Report.html`

Link to The Image on DockerHub: <https://hub.docker.com/repository/docker/livzhaidocker/project_image/general>

**Way 2:**\
Since actually the project folder includes `Dockerfile`, you could rebuild the image and run the automated version of the image with typing the following instruction in your terminal:\
`docker build -t project_image .` （or use Makefile to do so: `make project_image`)\
`make report/Report.html`
