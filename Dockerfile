# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libffi-dev \
    libssl-dev \
    libvirt-dev \
    # Add other system dependencies required by your Python packages here
    && rm -rf /var/lib/apt/lists/*

# Install poetry
RUN pip install poetry

# Copy the dependency management files
COPY poetry.lock pyproject.toml /app/

# Install project dependencies
RUN poetry install --no-root --without dev

# Copy the rest of the application's source code
COPY . /app/

# Specify the command to run on container startup
CMD ["tail", "-f", "/dev/null"]
