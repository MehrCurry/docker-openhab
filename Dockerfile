FROM dockerfile/java

WORKDIR /opt/openhab
RUN curl -L -o runtime.zip https://github.com/openhab/openhab/releases/download/v1.6.0/distribution-1.6.0-runtime.zip && unzip runtime.zip && rm runtime.zip

RUN chmod +x /opt/openhab/start.sh

RUN curl -L -o greent.zip https://github.com/openhab/openhab/releases/download/v1.6.0/distribution-1.6.0-greent.zip && cd webapps && unzip ../greent.zip && rm ../greent.zip

RUN curl -L -o addons.zip https://github.com/openhab/openhab/releases/download/v1.6.0/distribution-1.6.0-addons.zip && cd addons && unzip ../addons.zip && rm ../addons.zip

RUN curl -L -o habmin.zip https://github.com/cdjackson/HABmin/releases/download/0.1.3-snapshot/habmin.zip && unzip habmin.zip && rm habmin.zip

RUN mv configurations configurations.dist

EXPOSE 8080
CMD git clone https://MehrCurry:$GIT_PASS@bitbucket.org/MehrCurry/openhab-config.git /opt/openhab/configurations && /opt/openhab/start.sh
