clone

docker build -t x-ray:latest .

docker run -it --rm -v "$PWD":/app x-ray