# 1. Start with the developer's pre-built image
# (This image already has Python, Cryptography, and all heavy libraries installed)
FROM ghcr.io/g0ldyy/comet:latest

# Switch to root user to allow file changes
USER root

# 2. Install git
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# 3. Swap the code
WORKDIR /app

# Delete the original code
RUN rm -rf ./*

# Download YOUR fork (with the custom titles)
RUN git clone --depth 1 --branch main https://github.com/CallumJRobertson/comet-fork .

# Delete the folder that causes errors
RUN rm -rf deployment

# 4. Install just your package code (Skip checking heavy dependencies)
# We use --no-deps so pip doesn't check the heavy libraries and crash the memory
RUN pip install --no-cache-dir --no-deps .

# 5. Start the app
CMD ["python", "-m", "comet.main"]
