# Use a small base image with Docker Compose pre-installed
FROM docker/compose:1.29.2 AS builder

WORKDIR /app

# Copy the docker-compose.yml file to the build stage
COPY docker-compose.yml /app/

# Final Stage
FROM alpine:latest

# Copy the docker-compose.yml file from the builder stage
COPY --from=builder /usr/local/bin/docker-compose /usr/local/bin/docker-compose
COPY --from=builder /app/docker-compose.yml /app/

# Set the working directory
WORKDIR /app

# Optionally, you can perform additional steps or install tools here

# Command to run when the container starts
CMD ["docker-compose", "up"]
