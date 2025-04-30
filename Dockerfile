FROM --platform=linux/amd64 rocker/tidyverse as base

RUN mkdir /home/rstudio/project
WORKDIR /home/rstudio/project

# build code, output directory 
RUN mkdir code
RUN mkdir output
RUN mkdir data

# copy all relevant files
COPY code code
COPY data/cancer_patient_data_set_copy.csv data
COPY Makefile .
COPY Report.Rmd .

# copy only the essential renv files and not the renv library
COPY renv.lock .
COPY .Rprofile .

RUN mkdir -p renv

COPY renv/activate.R renv
COPY renv/settings.json renv

# mannully install packages
RUN install2.r --error jsonlite utf8 tidyverse vctrs fansi

RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE=renv/.cache

RUN Rscript -e "renv::restore(prompt=FALSE)"

################################################
FROM --platform=linux/amd64 rocker/tidyverse

WORKDIR /home/rstudio/project
COPY --from=base /home/rstudio/project .

RUN mkdir report

RUN apt-get update && apt-get install -y pandoc
CMD make && mv Report.html report

