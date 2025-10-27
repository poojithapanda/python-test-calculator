FROM python:3.11-slim
# gives me a python environment based on python 3.11

# CORRECTION: LABEL instructions use a key-value format.
LABEL maintainer="poojithapanda7@gmail.com"
# Alternatively, you could use the MAINTAINER instruction, but LABEL is the modern, preferred way.
# MAINTAINER poojithapanda7@gmail.com 

COPY . /python-test-calculator 
# copying the project into the image
WORKDIR /python-test-calculator
# sets context for following instructions to this directory
# like pip install command
RUN pip install --no-cache-dir -r requirements.txt
# installs all dependencies in requirements


# ADDITION: You must create the 'reports' directory before pytest tries to write to it.
RUN mkdir reports
# then execute the installation and test comands
RUN ["pytest", "-v", "--junitxml=reports/result.xml"]

CMD tail -f /dev/null
# keeps the container running
# allowing you to inspect the container later
# so we can copy it from test container to jenkins later
# without this the container would stop after tests are done