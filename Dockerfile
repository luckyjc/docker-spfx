FROM alpine:3.14.0
RUN apk add\
  --no-cache\
  --repository http://dl-cdn.alpinelinux.org/alpine/v3.7/main/ nodejs=8.9.3-r1
RUN addgroup spfx &&\
    adduser -D -G spfx spfx
ENV NPM_CONFIG_PREFIX=/home/spfx/.npm-global
ENV PATH=/home/spfx/.npm-global/bin:$PATH
RUN npm i -g gulp@3.9.1 yo@3.1.1 @microsoft/generator-sharepoint@1.4.1
RUN mkdir /home/spfx/app &&\
    chown -R spfx:spfx /home/spfx
EXPOSE 5432 4321 35729
ENV NODE_NO_HTTP2=1
USER spfx
WORKDIR /home/spfx/app
