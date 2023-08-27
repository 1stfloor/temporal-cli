FROM alpine:latest as build

RUN apk --no-cache add curl
RUN curl -sSf https://temporal.download/cli.sh | sh

FROM gcr.io/distroless/static as temporal

COPY --from=build /root/.temporalio/bin/temporal /temporal

EXPOSE 8233/tcp
EXPOSE 7233/tcp

CMD ["/temporal", "server", "start-dev", "--ip", "0.0.0.0"]