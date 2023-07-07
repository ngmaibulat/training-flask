# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install .

EXPOSE 5000

ENV FLASK_ENV=production

# Define the command to run your app using CMD which defines your runtime

# CMD ["python", "src/__main__.py"]
# CMD ["python", "-m", "src"]

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "src.__main__:app"]
