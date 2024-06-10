FROM valkey/valkey

# Set the working directory to /usr/local/etc/valkey/
WORKDIR /usr/local/etc/valkey/


# Create the directory for the config file
RUN mkdir -p /usr/local/etc/valkey

# Copy the configuration file to the correct location
COPY valkey.conf /usr/local/etc/valkey/valkey.conf


CMD ["valkey-server", "/usr/local/etc/valkey/valkey.conf"]
