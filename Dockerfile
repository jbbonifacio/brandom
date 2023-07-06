FROM rocker/verse:4.2.3
RUN apt-get update && apt-get install -y   && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /usr/local/lib/R/etc/ /usr/lib/R/etc/
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" | tee /usr/local/lib/R/etc/Rprofile.site | tee /usr/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_version("pkgload",upgrade="never", version = "1.3.2")'
RUN Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.7.4")'
RUN Rscript -e 'remotes::install_version("config",upgrade="never", version = "0.3.1")'
RUN Rscript -e 'remotes::install_version("testthat",upgrade="never", version = "3.1.8")'
RUN Rscript -e 'remotes::install_version("shinydashboard",upgrade="never", version = "0.7.2")'
RUN Rscript -e 'remotes::install_version("golem",upgrade="never", version = "0.4.0")'
RUN Rscript -e 'remotes::install_version("shinydashboard",upgrade="never", version = "0.7.2")'

RUN mkdir ./private_pkgs

COPY source_pkgs/DiGGer_1.0.5_R_x86_64-redhat-linux-gnu.tar.gz ./private_pkgs/DiGGer_1.0.5_R_x86_64-redhat-linux-gnu.tar.gz

# Install from source
RUN R -e 'install.packages("private_pkgs/DiGGer_1.0.5_R_x86_64-redhat-linux-gnu.tar.gz", repos = NULL)'

RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'
RUN rm -rf /build_zone
EXPOSE 80
CMD  ["R", "-e", "options('shiny.port'=80,shiny.host='0.0.0.0');require(brandom);brandom::run_app()"]
