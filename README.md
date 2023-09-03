# autify_test

## Fetch and Save Web Content with Docker
This repository contains a Ruby script that allows you to fetch and save web content from specified URLs. It uses Docker for easy containerization and execution. The script also supports fetching metadata for previously fetched URLs.

## Prerequisites
- Docker installed on your system

## Usage

## Build the Docker Image
Before running the script, you need to build the Docker image. Make sure you are in the project directory containing the Dockerfile and fetch.rb script.

```bash
sudo docker build -t my-fetch-app .
```

## Fetch and Save Web Content
To fetch and save web content, run the following command:

```bash
sudo docker run -v "$(pwd)":/app my-fetch-app ruby fetch.rb [URL1] [URL2] ...
```
Replace [URL1], [URL2], and so on with the URLs you want to fetch and save. For example:

```bash
sudo docker run -v "$(pwd)":/app my-fetch-app ruby fetch.rb https://www.google.com https://autify.com
```
This command will fetch the content of the specified URLs and save them as HTML files in the current directory.

## Fetch Metadata for Previously Fetched URLs
To fetch metadata for previously fetched URLs, use the --metadata flag followed by the URLs you want to fetch metadata for. For example:

```bash
sudo docker run -v "$(pwd)":/app my-fetch-app ruby fetch.rb --metadata https://www.google.com
```

This command will display the metadata for the specified URL(s) if it was previously fetched and saved.

## Notes
- The fetched HTML content will be saved as files with names like google.com.html, where the URL's host is used as the filename.
- Metadata for fetched URLs is saved in files with names like google.com.html.metadata.
- If the script encounters an error while fetching a URL, it will display an error message.

Enjoy fetching and analyzing web content with this Dockerized Ruby script!
