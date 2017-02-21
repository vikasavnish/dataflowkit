FROM golang

ARG app_env
ENV APP_ENV $app_env

COPY ./ /go/src/github.com/slotix/dfk-parser
WORKDIR /go/src/github.com/slotix/dfk-parser

RUN go get ./
RUN go build -ldflags "-X main.buildTime=`date -u '+%Y-%m-%d_%I:%M:%S%p'` -X main.githash=`git rev-parse HEAD`"

CMD if [ ${APP_ENV} = production ]; \
	then \
	dfk-parser; \
	else \
	go get github.com/pilu/fresh && \
	fresh; \
	fi
	
EXPOSE 8080