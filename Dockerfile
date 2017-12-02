FROM jupyter/scipy-notebook:cf6258237ff9

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

RUN jupiter nbextension enable --py --sys-prefix widgetsnbextension

RUN mkdir -p /home/jovyan/.jupyter/custom

ADD custom.css /home/jovyan/.jupyter/custom/
