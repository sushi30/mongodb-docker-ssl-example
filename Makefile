# Makefile for creating SSL certificates

SSL_DIR=ssl
CERT_FILE=$(SSL_DIR)/server.crt
KEY_FILE=$(SSL_DIR)/server.key
PEM_FILE=$(SSL_DIR)/server.pem
OPENSSL_CNF=openssl.cnf

all: $(CERT_FILE) $(KEY_FILE) $(PEM_FILE)
	chmod 644 $(CERT_FILE)
	chmod 600 $(KEY_FILE)

$(CERT_FILE) $(KEY_FILE): $(SSL_DIR) $(OPENSSL_CNF)
	openssl req -newkey rsa:2048 -nodes -keyout $(KEY_FILE) -x509 -days 365 -out $(CERT_FILE) -config $(OPENSSL_CNF)

$(PEM_FILE): $(CERT_FILE) $(KEY_FILE)
	cat $(CERT_FILE) $(KEY_FILE) > $(PEM_FILE)

$(SSL_DIR):
	mkdir -p $(SSL_DIR)

clean:
	rm -rf $(SSL_DIR)

.PHONY: all clean