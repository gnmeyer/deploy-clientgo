FROM ubuntu

# Copy the lister binary into the image
COPY ./lister ./lister

# Start the container and put it to sleep

ENTRYPOINT [ "./lister" ]

