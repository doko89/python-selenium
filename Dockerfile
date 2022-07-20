FROM alpine

WORKDIR /app

RUN apk update && apk add --no-cache bash chromium chromium-chromedriver py3-pip supervisor nginx
RUN pip install selenium webdriver_manager fake_useragent
RUN ln -s /usr/lib/chromium/chromium-launcher.sh /usr/bin/google-chrome && mkdir -p /root/.wdm/drivers/chromedriver/linux64/102.0.5005 && \
    ln -s /usr/lib/chromium/chromedriver /root/.wdm/drivers/chromedriver/linux64/102.0.5005/chromedriver
#RUN mkdir -p /root/ && \
#        /usr/bin/chromedriver /root/.wdm/drivers/chromedriver/linux64/102.0.5005/chromedriver && \
#        cp /usr/bin/chromium-browser /usr/bin/google-chrome
ADD fake_useragent_0.1.11.json /tmp/fake_useragent_0.1.11.json
ADD drivers.json /root/.wdm/drivers.json
ADD run.py .

