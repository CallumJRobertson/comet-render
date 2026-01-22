# 1. Start with the developer's pre-built image
FROM ghcr.io/g0ldyy/comet:latest

# Switch to root user to allow file changes
USER root

# 2. Install git (Using 'apk' because this is Alpine Linux)
RUN apk add --no-cache git

# 3. Swap the code
WORKDIR /app

# Delete the original code
RUN rm -rf ./*

# Download YOUR fork
RUN git clone --depth 1 --branch main https://github.com/CallumJRobertson/comet-fork .

# Delete the confusing folder
RUN rm -rf deployment

# 4. Install just your package code
# We use --no-deps so pip doesn't crash checking heavy libraries
RUN pip install --no-cache-dir --no-deps .

# 5. Start the app
CMD ["python", "-m", "comet.main"]
