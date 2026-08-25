FROM alpine:latest

# تثبيت الحزم المطلوبة
RUN apk add --no-cache curl unzip gettext

# تحميل أحدث نسخة من Xray-core
RUN curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip /tmp/xray.zip -d /usr/local/bin/ \
    && rm /tmp/xray.zip

# فتح البورت الذي ترسله منصة جوجل ديناميكياً
EXPOSE 8080

# إنشاء ملف إعدادات مؤقت يقرأ بورت جوجل (\$PORT) مباشرة عند التشغيل ثم يشغل البرنامج
CMD sh -c 'cat <<EOF > /etc/xray/config.json\
{\
  "inbounds": [\
    {\
      "port": ${PORT:-8080},\
      "protocol": "vless",\
      "settings": {\
        "clients": [\
          {\
            "id": "9b1d4e77-8852-4c23-b1d9-5287f311c102",\
            "level": 0\
          }\
        ],\
        "decryption": "none"\
      },\
      "streamSettings": {\
        "network": "ws",\
        "security": "none",\
        "wsSettings": {\
          "path": "/radwan/Mo7a"\
        }\
      }\
    }\
  ],\
  "outbounds": [\
    {\
      "protocol": "freedom",\
      "settings": {}\
    }\
  ]\
}\
EOF\
xray -config /etc/xray/config.json'
