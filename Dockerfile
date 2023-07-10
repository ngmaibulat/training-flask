# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install .

# Informational only
# show default port
EXPOSE 8080

ENV FLASK_ENV=production
ENV PORT 8080


# CMD ["python", "ngmapi/__main__.py"]
# CMD ["python", "-m", "ngmapi"]

# The CMD command in a Dockerfile has two forms:
# CMD ["executable","param1","param2"] (exec form, this is the preferred form)
# CMD command param1 param2 (shell form)

# In the exec form, the command is executed without a shell.
# This means that environment variable substitution does not happen.

# On the other hand, the shell form does allow for variable substitution
# because the command is executed within a shell.


# CMD ["gunicorn", "--bind", "0.0.0.0:${PORT}", "ngmapi.app:app"]
CMD gunicorn --bind 0.0.0.0:$PORT ngmapi.app:app
