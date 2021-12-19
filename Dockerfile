FROM gcc:9.4.0 AS compiler

WORKDIR /src

# copy 2hol source code into image
COPY ./2hol ./

# RUN ["git", "clone", "https://github.com/twohoursonelife/OneLife.git"]
# RUN ["git", "clone", "https://github.com/twohoursonelife/OneLifeData7.git"]
# RUN ["git", "clone", "https://github.com/twohoursonelife/minorGems.git"]

# install compile-time dependencies
RUN apt update
RUN apt -y install libgl-dev libglu1-mesa-dev libsdl1.2-dev

# build client and server
RUN ./OneLife/scripts/pullAndBuildTestSystem.sh


FROM debian:stable-slim

WORKDIR /server

# copy over compiled server
COPY --from=compiler /src/OneLife/server ./

# remove unwanted files
RUN rm *.cpp *.h *.o *.dep2
RUN rm configure Makefile* makeFileList
RUN rm -r installYourOwnServer runServer.bat

# copy over assets
COPY --from=compiler /src/OneLifeData7/dataVersionNumber.txt ./
COPY --from=compiler /src/OneLifeData7/categories ./categories
COPY --from=compiler /src/OneLifeData7/objects ./objects
COPY --from=compiler /src/OneLifeData7/transitions ./transitions
COPY --from=compiler /src/OneLifeData7/tutorialMaps ./tutorialMaps

CMD ["./OneLifeServer"]
