FROM python:3.13.2-slim-bookworm

RUN echo 'deb http://deb.debian.org/debian bookworm contrib' >> /etc/apt/sources.list
RUN apt-get update; apt-get -y install build-essential pkgconf cmake ttf-mscorefonts-installer; apt-get clean

RUN --mount=type=cache,target=/root/.cache/pip ls -Alh /root/.cache/pip/
RUN --mount=type=cache,target=/root/.cache/pip pip install --upgrade --root-user-action ignore pip
RUN --mount=type=cache,target=/root/.cache/pip pip install --upgrade --root-user-action ignore wheel setuptools ninja

COPY requirements.txt .
RUN --mount=type=cache,target=/root/.cache/pip pip install --root-user-action ignore -r requirements.txt

COPY hf.txt .
RUN --mount=type=cache,target=/root/.cache/pip pip install --root-user-action ignore -r hf.txt

CMD ["jupyter", "notebook", "--no-browser", "--allow-root", "--port=8080", "--ip=0.0.0.0", "--IdentityProvider.token=''", "--ServerApp.password=''", "--ServerApp.disable_check_xsrf=True"]
