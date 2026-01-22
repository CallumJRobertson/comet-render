# Use a lightweight Python image
FROM python:3.11-slim

# Install git (needed to clone the app)
RUN apt-get update && apt-get install -y git build-essential && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone the latest Comet code directly from the developer
# (This ensures you get the official app, not a custom modified version)
RUN git clone --depth 1 --branch main https://github.com/CallumJRobertson/comet-fork .

# Install dependencies
RUN pip install --no-cache-dir .

# Start the app
CMD ["python", "-m", "comet.main"]
