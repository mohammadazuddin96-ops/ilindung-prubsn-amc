FROM node:20-alpine

RUN apk add --no-cache unzip

WORKDIR /app
COPY ilindung-prubsn-amc-build-package.zip /tmp/project.zip
RUN unzip -q /tmp/project.zip -d /tmp/project \
    && cp -a /tmp/project/ilindung-prubsn-amc-build/. /app/ \
    && rm -rf /tmp/project /tmp/project.zip

WORKDIR /app/backend
RUN npm install --omit=dev

ENV NODE_ENV=production
ENV PORT=8080
EXPOSE 8080

CMD ["npm", "start"]
