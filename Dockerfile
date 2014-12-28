FROM core/java:oracle-java8

RUN apt-get -y update && apt-get install -qqy curl unzip

WORKDIR /opt/openhab
ENV VERSION 1.6.1

RUN curl -L -o runtime.zip https://github.com/openhab/openhab/releases/download/v$VERSION/distribution-$VERSION-runtime.zip && unzip runtime.zip && rm runtime.zip

RUN chmod +x /opt/openhab/start.sh

RUN curl -L -o greent.zip https://github.com/openhab/openhab/releases/download/v$VERSION/distribution-$VERSION-greent.zip && cd webapps && unzip ../greent.zip && rm ../greent.zip

RUN curl -L -o habmin.zip https://github.com/cdjackson/HABmin/releases/download/0.1.3-snapshot/habmin.zip && unzip habmin.zip && rm habmin.zip

RUN mkdir -p /opt/addons && cd /opt/addons && curl -L -o addons.zip https://github.com/openhab/openhab/releases/download/v$VERSION/distribution-$VERSION-addons.zip && unzip addons.zip && rm addons.zip

RUN for BINDING in denon xbmc homematic milight exec http fritzbox jointspace; do ln -sf /opt/addons/org.openhab.binding.$BINDING-$VERSION.jar /opt/openhab/addons; done

RUN for PERSISTENCE in db4o; do ln -sf /opt/addons/org.openhab.persistence.$PERSISTENCE-$VERSION.jar /opt/openhab/addons; done

RUN mv configurations configurations.dist

VOLUME /opt/openhab/logs

EXPOSE 8080 9123
CMD /opt/openhab/start.sh
