hereFROM alpine:latest

# تثبيت الحزم اللازمة لتحميل وتشغيل Xray/V2ray
RUN apk add --no-cache curl unzip

# تحميل أحدث نسخة من Xray
RUN curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip /tmp/xray.zip -d /usr/local/bin/ \
    && rm /tmp/xray.zip

# نسخ ملف الإعدادات الخاص بك إلى مسار العمل
COPY config.json /etc/xray/config.json

# فتح المنفذ 8080 المتوافق مع جوجل كلود
EXPOSE 8080

# أمر تشغيل الخدمة مع الاعتماد على متغير المنفذ
CMD ["xray", "-config", "/etc/xray/config.json"]
