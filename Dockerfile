FROM squidfunk/mkdocs-material as builder

# ARG DOCS_PASSWORD=changeme
ARG APP_NAME=changeme

# Install mkdocs extensions
RUN pip install \
        mkdocs-table-reader-plugin \
        mkdocs-encryptcontent-plugin

# Prepare the workdir
RUN mkdir -p /opt/cublueprint/${APP_NAME}
WORKDIR /opt/cublueprint/${APP_NAME}
COPY . .

# Build the documentation
# ENV DOCS_PASSWORD=${DOCS_PASSWORD}
RUN mkdocs build



FROM nginx:latest as runner

# Copy the built app
COPY --from=builder /opt/cublueprint/serverpro/site /usr/share/nginx/html/

# Serve the documentation
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
