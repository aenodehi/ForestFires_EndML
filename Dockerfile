# Use the base image provided by ruanbekker
FROM ruanbekker/vscode:python-3.7

# Install necessary dependencies
RUN apt-get update && apt-get install -y curl

# Install code-server
RUN curl -fsSL http://code-server.dev/install.sh | sh

# Copy files and folders from the local directory to the container
COPY ./ /code

RUN python3 -m venv /CODE/venv
ENV PATH="/code/venv/bin:$PATH"

RUN pipenv install

# Expose the port that code-server will run on
EXPOSE 8443

# Set the default command to start code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:8443", "--auth", "1"]