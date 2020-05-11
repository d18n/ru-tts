# Russian Text-To-Speech

Used a couple of the other espnet TTS examples as a template for making this one. Ended up finding a decent dataset, but think that the clips
might be a bit too long. Had some trouble fitting everything into memory on my GPU, so I ended up dropping the minibatch size pretty significantly. I wasn't
able to get any good models yet, only made it through a couple of epochs, and it was incredibly slow, but it will train! I think that if we had some
shorter clips with some simpler words/phrases to do the initial training, and then scaled up to larger sentences, we might be able to converge a bit faster
and hopefully save a bit of memory.

In order to not re-download the dataset every time, I made a volume beforehand named downloads, and mount it in the container

`docker volume create downloads`

docker-compose does not seem to support gpus yet, so this is the command I use to start the container:

`docker run --gpus all -it -p 8888:8888 -v downloads:/workspace/espnet/egs/ru/tts1/downloads d18n/ru-tts`

You should be able to use `docker-compose up` and you'll be able to play around with the file structure or run some code in a notebook, but training
will be pretty painful without a gpu