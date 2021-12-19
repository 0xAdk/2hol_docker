# Setup compile environment
FROM gcc:9.4.0 AS server_compiler
RUN apt update
RUN apt -y install libgl-dev libglu1-mesa-dev libsdl1.2-dev

# Copy in 2hol source code and then build the server
WORKDIR /src
COPY ./2hol ./
WORKDIR OneLife/server
RUN ./configure 1 && make

# Cleanup / remove unwanted files
RUN rm *.cpp *.h *.o *.dep2
RUN rm configure Makefile* makeFileList
RUN rm -r installYourOwnServer runServer.bat

# Move in required files
RUN mv /src/OneLifeData7/dataVersionNumber.txt .
RUN mv /src/OneLifeData7/objects .
RUN mv /src/OneLifeData7/categories .
RUN mv /src/OneLifeData7/transitions .
RUN mv /src/OneLifeData7/tutorialMaps .

# Move server into lean runtime environment
FROM debian:stable-slim
WORKDIR /server
COPY --from=server_compiler /src/OneLife/server ./
CMD ["./OneLifeServer"]
