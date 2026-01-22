# 1. Start with the developer's pre-built image
FROM ghcr.io/g0ldyy/comet:latest

# Switch to root user
USER root

# 2. Install git (Alpine Linux)
RUN apk add --no-cache git

# 3. Nuke the existing app folder completely
# This ensures NO hidden files are left behind
RUN rm -rf /app && mkdir /app

# 4. Move into the fresh empty folder
WORKDIR /app

# 5. Clone YOUR fork into the empty folder
RUN git clone --depth 1 --branch main https://github.com/CallumJRobertson/comet-fork .

# 6. Delete the conflicting folder (from your fork)
RUN rm -rf deployment

# 7. Install your customized code
# --no-deps skips installing heavy libraries (since the base image has them)
RUN pip install --no-cache-dir --no-deps .

# 8. Start the app
CMD ["python", "-m", "comet.main"]
