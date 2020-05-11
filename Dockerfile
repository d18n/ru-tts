FROM d18n/espnet-jupyter

RUN apt-get install sox -y
RUN pip install gdown

ENV PATH="/workspace/espnet/tools/kaldi/src/featbin:${PATH}"

RUN mkdir espnet/egs/ru
RUN mkdir espnet/egs/ru/tts1

COPY ru/tts1/ espnet/egs/ru/tts1/

RUN cd espnet/egs/ru/tts1 && ln -s ../../../tools/kaldi/egs/wsj/s5/steps/ steps
RUN cd espnet/egs/ru/tts1 && ln -s ../../../tools/kaldi/egs/wsj/s5/utils/ utils

ENTRYPOINT ["jupyter", "notebook", \
    "--allow-root", \
    "--ip=0.0.0.0", \
    "--no-browser", \
    "--NotebookApp.allow_remote_access=True", \
    "--NotebookApp.disable_check_xsrf=True", \
    "--NotebookApp.password=\"sha1:410ae5b662e7:b26e1049b8497f1801d93029f8a4ec8d0618b6e6\"" \
    # "-e CHOWN_HOME=yes" \
    # "-e CHOWN_EXTRA_OPTS='-R'" \
]