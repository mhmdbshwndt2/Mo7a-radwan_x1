FROM alpine:latest

RUN apk add --no-cache curl unzip gettext

RUN curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip /tmp/xray.zip -d /usr/local/bin/ \
    && rm /tmp/xray.zip

COPY config.json /etc/xray/config.json

# سكربت صغير يقوم بتحديث البورت بناءً على ما ترسله منصة Google Cloud Run ثم يشغل السيرفر
EXPOSE 8080

CMD sed -i "s/\"port\": 8080/\"port\": ${PORT:-8080}/g" /etc/xray/config.json && xray -config /etc/xray/config.json
