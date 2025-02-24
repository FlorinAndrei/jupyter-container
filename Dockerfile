FROM python:3.13.2-slim-bookworm

RUN echo 'deb http://deb.debian.org/debian bookworm contrib' >> /etc/apt/sources.list
RUN apt-get update; apt-get -y install ttf-mscorefonts-installer; apt-get clean

RUN --mount=type=cache,target=/root/.cache/pip ls -Alh /root/.cache/pip/
RUN --mount=type=cache,target=/root/.cache/pip pip install --upgrade --root-user-action ignore pip
RUN --mount=type=cache,target=/root/.cache/pip pip install --upgrade --root-user-action ignore wheel setuptools

COPY requirements.txt .
RUN --mount=type=cache,target=/root/.cache/pip pip install -r requirements.txt

RUN --mount=type=cache,target=/root/.cache/pip pip install --upgrade --root-user-action ignore torch torchvision torchaudio

CMD ["jupyter", "notebook", "--no-browser", "--allow-root", "--port=8080", "--ip=0.0.0.0", "--IdentityProvider.token=''", "--ServerApp.password=''", "--ServerApp.disable_check_xsrf=True"]
