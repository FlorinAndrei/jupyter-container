FROM ubuntu:noble-20250127

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:deadsnakes/ppa && \
  apt-get update && \
  apt-get install -y python3.13 python3.13-dev python3.13-venv build-essential python3-pip
RUN apt-get install -y tree && \
  apt-get clean

RUN --mount=type=cache,target=/root/.cache/pip python3.13 -m pip install --upgrade --user --root-user-action ignore pip
ENV PATH="/root/.local/bin:$PATH"
RUN --mount=type=cache,target=/root/.cache/pip pip3.13 install --upgrade --user --root-user-action ignore wheel setuptools ninja

COPY requirements.txt .
RUN --mount=type=cache,target=/root/.cache/pip pip3.13 install --user --root-user-action ignore -r requirements.txt

COPY hf.txt .
RUN --mount=type=cache,target=/root/.cache/pip pip3.13 install --user --root-user-action ignore -r hf.txt

CMD ["jupyter", "notebook", "--no-browser", "--allow-root", "--port=8080", "--ip=0.0.0.0", "--IdentityProvider.token=''", "--ServerApp.password=''", "--ServerApp.disable_check_xsrf=True"]
