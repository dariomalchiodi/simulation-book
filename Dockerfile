FROM jupyter/scipy-notebook:cf6258237ff9

LABEL maintainer "Dario Malchiodi <malchiodi@di.unimi.it>"

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

USER root

# libav-tools for matplotlib anim
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    libav-tools graphviz ttf-freefont && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.0.0/FiraCode.zip
RUN unzip FiraCode.zip -d /usr/local/share/fonts/
RUN fc-cache -fv 
RUN rm FiraCode.zip

RUN conda install --quiet --yes \
                  'ipython' \
                  'notebook' \
                  'ipywidgets' \
                  'pandas' \
                  'matplotlib' \
                  'scipy' \
                  'pyzmq' \
                  'scikit-learn' \
 && conda clean -tipsy

RUN conda install -c conda-forge jupyter_nbextensions_configurator
RUN conda install -c conda-forge jupyter_contrib_nbextensions

RUN jupyter nbextension enable hide_input/main
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
RUN chown -R ${NB_UID} ${HOME}

RUN mkdir -p /home/jovyan/.jupyter/custom

ADD custom.css /home/jovyan/.jupyter/custom/

USER ${NB_USER}

