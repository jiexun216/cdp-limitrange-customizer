FROM alpine:latest

ADD cdp-limitrange-customizer /cdp-limitrange-customizer
ENTRYPOINT ["./cdp-limitrange-customizer"]