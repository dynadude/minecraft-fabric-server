FROM alpine:3

ARG MINECRAFT_VERSION=1.20.5
ARG JAVA_VERSION=21
ARG FABRIC_VERSION=0.15.10
ARG FABRIC_INSTALLER_VERSION=1.0.1

RUN apk add openjdk${JAVA_VERSION}

ENV SERVER_PATH=/usr/bin/minecraft-server.jar

RUN wget -O ${SERVER_PATH} https://meta.fabricmc.net/v2/versions/loader/${MINECRAFT_VERSION}/${FABRIC_VERSION}/${FABRIC_INSTALLER_VERSION}/server/jar && \
    chmod a+r ${SERVER_PATH}

RUN addgroup minecraft -g 1000 && \
    adduser minecraft -u 1000 -G minecraft -D

ARG WORKDIR=/var/lib/minecraft
RUN mkdir ${WORKDIR} && \
    chown 1000:1000 ${WORKDIR}
USER 1000

WORKDIR ${WORKDIR}

EXPOSE 25565

CMD if [[ "${EULA}" == true ]]; then echo 'eula=true' > eula.txt && java -XX:MaxRAMPercentage=100 -XX:+UseContainerSupport -jar ${SERVER_PATH} nogui ; else echo 'Please set the EULA environment variable to true to accept the minecraft EULA by adding "-e EULA=true" right after "docker run"' ; fi