FROM node:22-alpine

RUN apk add --no-cache unzip

WORKDIR /app
COPY ilindung-prubsn-amc-build-package.zip /tmp/project.zip
RUN unzip -q /tmp/project.zip -d /tmp/project \
    && cp -a /tmp/project/ilindung-prubsn-amc-build/. /app/ \
    && sed -i 's/  } catch {/  } catch (error) {/' /app/backend/src/server.js \
    && sed -i "/Tidak dapat mengesahkan akses admin/i\\      console.error('Admin authorization failed:', error);" /app/backend/src/server.js \
    && rm -rf /tmp/project /tmp/project.zip
COPY frontend/app.js /app/frontend/app.js
COPY frontend/styles.css /app/frontend/styles.css

WORKDIR /app/backend
RUN npm install --omit=dev

ENV NODE_ENV=production
ENV PORT=8080
EXPOSE 8080

CMD ["npm", "start"]
