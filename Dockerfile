# Setup compile environment
FROM gcc:9.4.0 AS server_compiler
RUN apt update && apt install -y \
	libgl-dev \
	libglu1-mesa-dev \
	libsdl1.2-dev

# Copy in 2hol source code and then build the server
WORKDIR /src
COPY ./2hol ./
WORKDIR OneLife/server
RUN ./configure 1 && make

# Cleanup / remove unwanted files
RUN rm -r \
	*.cpp *.h *.o *.dep2 \
	configure Makefile* makeFileList \
	installYourOwnServer runServer.bat

# Move in required files
RUN mv -t . \
	/src/OneLifeData7/categories \
	/src/OneLifeData7/dataVersionNumber.txt \
	/src/OneLifeData7/objects \
	/src/OneLifeData7/transitions \
	/src/OneLifeData7/tutorialMaps

# Move server into lean runtime environment
FROM debian:stable-slim

WORKDIR /server
COPY --from=server_compiler /src/OneLife/server ./

# Create symlinks for databases
WORKDIR /server_data/data
RUN ln -srt /server \
	biome.db \
	biomeRandSeed.txt \
	curseCount.db \
	curseSave.txt \
	curses.db \
	eve.db \
	eveRadius.txt \
	familyDataLog.txt \
	floor.db \
	floorTime.db \
	grave.db \
	lookTime.db \
	map.db \
	mapDummyRecall.txt \
	mapTime.db \
	meta.db \
	playerStats.db \
	recentPlacements.txt

# Create symlinks for cache
WORKDIR /server_data/cache
RUN \
	ln -sr ./categories_cache.fcz  /server/categories/cache.fcz && \
	ln -sr ./objects_cache.fcz     /server/objects/cache.fcz && \
	ln -sr ./transitions_cache.fcz /server/transitions/cache.fcz

WORKDIR /server_data/log
RUN ln -srt /server \
	curseLog \
	failureLog \
	foodLog \
	lifeLog \
	log.txt \
	mapChangeLogs

WORKDIR /server
COPY ./docker_entrypoint.sh ./
ENTRYPOINT ["./docker_entrypoint.sh"]

EXPOSE 8005
STOPSIGNAL SIGTSTP
CMD ["./OneLifeServer"]
