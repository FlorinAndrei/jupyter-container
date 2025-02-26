My Jupyter Server container image.

It serves two purposes:

- general-purpose Jupyter server for various notebooks
- code execution and code interpreter for Open WebUI

Convenient, but super-insecure. Anybody could connect to your Jupyter server. Do not run it on a network you do not trust. It is entirely up to you to figure out how to secure it. Do not ask me.

`requirements-minimal.txt` is a minimal set of packages that probably works with Jupyter Code Execution / Code Interpreter in Open WebUI. It's a blend of a minimal Python venv that Cursor creates automatically for .ipynb files, and the Pyodide packages that Open WebUI uses.

`requirements.txt` has a variety of extra packages typically used in Data Science and Machine Learning. It generates bigger images. This is the default.

To build the image, simply run `sh build.sh`.

To run the container, run `sh run-jupyter-container.sh`. The container launched this way will be started again after you reboot the machine (you do not need to put it in the startup sequence).

To use it in Open WebUI, go to Admin / Settings / Code Execution, switch from Pyodide to Jupyter, and enter something like this for the URLs:

```
http://XXX.XXX.XXX.XXX:8080/tree
```

Replace the XXX... sequence with the IP address or hostname of the machine where Jupyter is running. If it's the same machine where Open WebUI is running, then `127.0.0.1` might work. Other addresses or hostnames may also work, depending on how your Docker installation is configured.

No Jupyter authentication is needed with the original way this image is configured. If you secure the image, that may or may not change.
