FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install dependencies
RUN apt-get update && apt-get install -y \
  curl \
  git \
  unzip \
  xz-utils \
  zip \
  libglu1-mesa \
  && rm -rf /var/lib/apt/lists/*


# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Pre-cache Flutter Web dependencies
RUN flutter upgrade && flutter precache --web && flutter doctor -v

# 👇 FIX: Give non-root user access to the flutter directory
RUN chown -R vscode:vscode /usr/local/flutter