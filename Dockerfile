FROM alpine:latest

RUN mkdir /template

ADD templates/CDK-full-template.yaml /template

CMD ["sh"]
