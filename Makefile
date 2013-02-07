THINLINC_PACKAGE=thinlinc-client_4.0.0-3717_i386.deb
THINLINC_PACKAGE_URL=http://www.cendio.com/downloads/clients/$(THINLINC_PACKAGE)
THINLINC_PACKAGE_DIR=config/packages.chroot
THINLINC_PACKAGE_LOCAL=$(THINLINC_PACKAGE_DIR)/$(THINLINC_PACKAGE)

all: binary.hybrid.iso

clean:
	sudo lb clean

clobber:
	rm -f binary.hybrid.iso $(THINLINC_PACKAGE_LOCAL)

binary.hybrid.iso: $(THINLINC_PACKAGE_LOCAL)
	sudo lb build

$(THINLINC_PACKAGE_LOCAL): $(THINLINC_PACKAGE_DIR)
	wget -O $(THINLINC_PACKAGE_LOCAL) $(THINLINC_PACKAGE_URL)

$(THINLINC_PACKAGE_DIR):
	mkdir -p $@
