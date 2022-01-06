# builder 스테이지. (node를 이용해 react의 build 산출물을 생선)
FROM node:alpine as builder
WORKDIR /usr/src/app
COPY package.json ./
RUN npm i
COPY ./ ./

# 운영에서는 start로 데브서버를 켜는게 아니라, build 산출물을 생성해낸다.
RUN npm run build
# 생성된 파일은 컨테이너 내부의 /usr/src/app/build 으로 떨어진다.


# 실행될 부분이니까 stage를 지정하지는 않고, 바로 베이스이미지로 이용한다.
FROM nginx 
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
