FROM alpine

WORKDIR /app

RUN apk update && apk add --no-cache bash chromium chromium-chromedriver py3-pip supervisor nginx && pip install selenium \
    webdriver_manager fake_useragent && ln -s /usr/lib/chromium/chromium-launcher.sh /usr/bin/google-chrome && \
    mkdir -p /root/.wdm/drivers/chromedriver/linux64/102.0.5005 && ln -s /usr/lib/chromium/chromedriver \
    /root/.wdm/drivers/chromedriver/linux64/102.0.5005/chromedriver && mkdir /etc/supervisor.d
ADD services.ini /etc/supervisor.d/services.ini
ADD fake_useragent_0.1.11.json /tmp/fake_useragent_0.1.11.json
ADD drivers.json /root/.wdm/drivers.json

CMD ["/usr/bin/supervisord"]
