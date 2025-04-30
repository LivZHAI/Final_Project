Report.html: output/table1_variable.rds output/table2_descriptive.rds output/table3_smoking.rds \
             output/table4_breath.rds output/figure1_heatmap.png output/figure2_barExposure.png \
             output/figure3_barSymptom.png Report.Rmd code/03_render_report.R
	Rscript code/03_render_report.R
	

output/table1_variable.rds output/table2_descriptive.rds output/table3_smoking.rds output/table4_breath.rds: code/01_make_tables.R data/cancer_patient_data_set_copy.csv
	Rscript code/01_make_tables.R

output/figure1_heatmap.png output/figure2_barExposure.png output/figure3_barSymptom.png: code/02_make_figures.R data/cancer_patient_data_set_copy.csv
	Rscript code/02_make_figures.R


.PHONY: Analysis
Analysis: Report.html
          
.PHONY: install
install:
	Rscript -e "renv::restore(project='.', prompt = FALSE)"
	
## make rule for docker build
PROJECTFILES = Report.Rmd code/01_make_tables.R code/02_make_figures.R code/03_render_report.R Makefile
RENVFILES = renv.lock renv/activate.R renv/settings.json

project_image: $(PROJECTFILES) $(RENVFILES)
	docker build -t project_image .
	#docker build -t livzhaidocker/project_image .
	touch $@

## if have dockerfile: make rule for docker run, and mounting report directory
report/Report.html:project_image
	docker run -v "$$(pwd)/report":/home/rstudio/project/report project_image
	
## if no dockerfile, while pull image from dockerhub: make rule for docker run
.PHONY: report
report: 
	docker run -v "$$(pwd)/report":/home/rstudio/project/report livzhaidocker/project_image:final_project_tag


.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f *.html && rm -f report/*.html