PREFIX ?= /usr/
DATA_DIR ?= $(PREFIX)/share/

core:
	install -dDm0755 $(DESTDIR)/$(DATA_DIR)/wireplumber/scripts/device/
	install -dDm0755 $(DESTDIR)/$(DATA_DIR)/wireplumber/wireplumber.conf.d/
	install -pm644 conf/wireplumber.conf $(DESTDIR)/$(DATA_DIR)/wireplumber/wireplumber.conf.d/99-ms-surface.conf
	install -pm0644 conf/surface-lock-volume.lua $(DESTDIR)/$(DATA_DIR)/wireplumber/scripts/device/surface-lock-volume.lua
	install -dDm0755 $(DESTDIR)/$(DATA_DIR)/surface-audio/

s%: core
	install -dDm0755 $(DESTDIR)/$(DATA_DIR)/surface-audio/$@/
	install -pm0644 -t $(DESTDIR)/$(DATA_DIR)/surface-audio/$@/ $(wildcard firs/$@/*)

install: core sp9

uninstall:
	rm -rf $(DESTDIR)/$(DATA_DIR)/wireplumber/wireplumber.conf.d/99-ms-surface.conf
	rm -rf $(DESTDIR)/$(DATA_DIR)/surface-audio/

