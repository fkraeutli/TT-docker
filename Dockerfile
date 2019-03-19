FROM nginx
RUN apt-get update
RUN apt-get install -y \
  curl \
  git
# Install node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y \
  nodejs

# Build TT
RUN git clone https://github.com/fkraeutli/TT
WORKDIR TT
RUN npm i -g grunt
RUN grunt concat

# Copy dist
RUN mkdir /usr/share/nginx/html/dist/
RUN cp dist/TT.js /usr/share/nginx/html/dist/

# Retrieve data
RUN mkdir /usr/share/nginx/html/Tate
RUN curl -L https://github.com/fkraeutli/collection/blob/master/artwork_data.csv?raw=true -o /usr/share/nginx/html/Tate/artwork_data_latest.csv

# Copy example files
RUN cp -r examples/ /usr/share/nginx/html/examples/
