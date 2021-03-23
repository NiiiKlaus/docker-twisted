FROM alpine:latest

# Steps:
# 1. Backup the original repositories file and change mirror for faster build.
# 2. Install twisted and its dependencies.
# 3. Change repository url back.
RUN cp /etc/apk/repositories /etc/apk/repositories.default && \
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
	apk update && \
	apk add py3-twisted py3-openssl py3-service_identity --no-cache && \
	rm -rf /etc/apk/repositories && \
	mv /etc/apk/repositories.default /etc/apk/repositories

COPY start.sh /start.sh
EXPOSE 6080 6443
ENV KEY_FILE CRT_FILE
VOLUME /app /certs

ENTRYPOINT ["sh", "/start.sh"]
