FROM jupyter/scipy-notebook:cf6258237ff9

RUN mkdir -p /home/jovyan/.jupyter/custom

ADD custom.css /home/jovyan/.jupyter/custom/
