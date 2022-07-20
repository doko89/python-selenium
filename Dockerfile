FROM alpine

WORKDIR /app

RUN apk update && apk add --no-cache bash chromium chromium-chromedriver py3-pip supervisor nginx dcron && pip install selenium \
    webdriver_manager fake_useragent && ln -s /usr/lib/chromium/chromium-launcher.sh /usr/bin/google-chrome && \
    mkdir -p /root/.wdm/drivers/chromedriver/linux64/102.0.5005 && ln -s /usr/lib/chromium/chromedriver \
    /root/.wdm/drivers/chromedriver/linux64/102.0.5005/chromedriver && mkdir /etc/supervisor.d && touch /app/index.html
ADD services.ini /etc/supervisor.d/services.ini
ADD default.conf /etc/nginx/http.d/default.conf
ADD fake_useragent_0.1.11.json /tmp/fake_useragent_0.1.11.json
ADD drivers.json /root/.wdm/drivers.json
ADD run.py /usr/local/bin/fetcher

CMD ["/usr/bin/supervisord"]
