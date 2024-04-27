the server's data is stored in "/var/lib/minecraft" and a volume can be created for this directory to preserve its data even if the container is deleted

make sure to set the `EULA` environment variable to `true` to accept the minecraft EULA by adding `-e EULA=true` right after `docker run`

you should also expose the container's internal 25565 port

example run commands:
```
docker run -e EULA=true -dit -p 25565 dynadude/minecraft-fabric-server:latest
```
```
docker run -e EULA=true -dit --memory=4g --cpus=2 -p 25565 dynadude/minecraft-fabric-server:latest
```