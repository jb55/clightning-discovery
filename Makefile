
BIN=clightning-discover

LDFLAGS=-static -L. $(shell pkg-config --static --libs-only-L dbus-1) -l:libavahi.a -l:libdbus-1.a

AVAHI_LIB=$(shell pkg-config --libs-only-L avahi-client | sed 's,^-L,,')
AVAHI_ARS=$(AVAHI_LIB)/libavahi-common.a $(AVAHI_LIB)/libavahi-client.a

all: example

libavahi.a: $(AVAHI_ARS)
	rm -rf .objs;\
	mkdir -p .objs;\
	cd .objs;\
	ar -x $(AVAHI_LIB)/libavahi-common.a;\
	ar -x $(AVAHI_LIB)/libavahi-client.a;\
	ar -qc libavahi.a *.o;\
	mv libavahi.a ..;\
	cd ..;\
	rm -rf .objs

$(BIN): main.c
	$(CC) $< $(LDFLAGS) -o $@

example: avahi-example.c libavahi.a
	$(CC) $< $(LDFLAGS) -o $@

clean:
	rm -f $(BIN) example libavahi.a
