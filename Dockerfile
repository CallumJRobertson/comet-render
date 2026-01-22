FROM python:3.11-slim

# 1. Install git and basic tools
RUN apt-get update && apt-get install -y git build-essential && rm -rf /var/lib/apt/lists/*

# 2. Install 'uv' (The fix for OOM errors)
# 'uv' is much more memory efficient than 'pip' and won't crash the free tier
RUN pip install uv

WORKDIR /app

# 3. Clone YOUR fork
RUN git clone --depth 1 --branch main https://github.com/CallumJRobertson/comet-fork .

# 4. Delete the conflicting folder (Crucial for your fork)
RUN rm -rf deployment

# 5. Install dependencies using 'uv' instead of 'pip'
# --system tells it to install to the main python environment
RUN uv pip install --system --no-cache -r requirements.txt || uv pip install --system --no-cache .

# 6. Start the app
CMD ["python", "-m", "comet.main"]
