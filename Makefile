INCLUDES_CHROOT=config/includes.chroot
PACKAGES_CHROOT=config/packages.chroot

THINLINC_PACKAGE=thinlinc-client_4.0.0-3717_i386.deb
THINLINC_URL=http://www.cendio.com/downloads/clients/$(THINLINC_PACKAGE)
THINLINC_PATH=$(PACKAGES_CHROOT)/$(THINLINC_PACKAGE)

TIGERVNC_TARGZ=tigervnc-Linux-i686-1.2.0.tar.gz
TIGERVNC_URL=http://garr.dl.sourceforge.net/project/tigervnc/tigervnc/1.2.0/$(TIGERVNC_TARGZ)
TIGERVNC_PATH=$(INCLUDES_CHROOT)/opt/TigerVNC

WANDA_SRC=/home/dme/u/bin/wanda
WANDA_PATH=$(INCLUDES_CHROOT)/usr/local/bin/wanda

all: binary.hybrid.iso

clean:
	sudo lb clean

clobber:
	rm -f binary.hybrid.iso
	rm -f $(THINLINC_PACKAGE)
	rm -f $(THINLINC_PATH)
	rm -f $(TIGERVNC_TARGZ)
	rm -rf $(TIGERVNC_PATH)
	rm -f $(WANDA_PATH)

binary.hybrid.iso: $(THINLINC_PATH) $(TIGERVNC_PATH) $(WANDA_PATH)
	sudo lb build

$(THINLINC_PACKAGE):
	wget -O $(THINLINC_PACKAGE) $(THINLINC_URL)

$(THINLINC_PATH): $(THINLINC_PACKAGE)
	mkdir -p $(PACKAGES_CHROOT)
	cp $(THINLINC_PACKAGE) $(PACKAGES_CHROOT)

$(TIGERVNC_TARGZ):
	wget -O $(TIGERVNC_TARGZ) $(TIGERVNC_URL)

$(TIGERVNC_PATH): $(TIGERVNC_TARGZ)
	mkdir -p $(INCLUDES_CHROOT)
	tar -C $(INCLUDES_CHROOT) -zxf $(TIGERVNC_TARGZ)

$(WANDA_PATH): $(WANDA_SRC)
	mkdir -p $(INCLUDES_CHROOT)/usr/local/bin
	cp $(WANDA_SRC) $(WANDA_PATH)
	chmod +x $(WANDA_PATH)
