FROM nodered/node-red

# download extensions
RUN npm install @flowfuse/node-red-dashboard
RUN npm install node-red-contrib-telegrambot
RUN npm install node-red-node-mysql
# RUN npm install node-red-contrib-influxdb
# RUN npm install node-red-contrib-redis
# RUN npm install node-red-contrib-postgresql
# RUN npm install node-red-contrib-s7
# RUN npm install node-red-contrib-opcua