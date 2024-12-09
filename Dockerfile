# Use NVIDIA CUDA base image
FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3.10 \
    python3-pip \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy all code at once
COPY . .

# Install dependencies
RUN pip3 install --no-cache-dir -r requirements.txt \
    && pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Create necessary directories
RUN mkdir -p output gradio_tmp

# Set default command to run web demo
CMD ["python3", "inference/gradio_web_demo.py"]
