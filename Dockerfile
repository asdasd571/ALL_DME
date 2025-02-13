FROM python:3.6-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . /usr/src/app
# swagger_server 소스를 포함시켜 복사
COPY .nak_access/swagger_server /usr/src/app/swagger_server1
COPY .nak_offer/swagger_server /usr/src/app/swagger_server2
COPY .nak_discovery/swagger_server /usr/src/app/swagger_server3
COPY .nak_reg/swagger_server_reg /usr/src/app/swagger_server_reg


EXPOSE 8080

CMD ["sh", "-c", "python3 -m nak_reg.swagger_server_reg & python3 -m nak_offer.swagger_server & python3 -m nak_discovery.swagger_server & python3 -m nak_access.swagger_server &  wait "]

