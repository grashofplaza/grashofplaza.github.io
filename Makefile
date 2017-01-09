.SUFFIXES: .js .css .html .svg .png .jpg .ico

DIST=dist
DIST_DIRS=$(DIST)/assets/images \
	$(DIST)/assets/lib \
	$(DIST)/components
THUMB_SIZE=256
FAVICON_MASTER=src/assets/images/logo.png

.PHONY: help dist publish clean

help:
	@echo "available targets:"
	@echo
	@echo dist
	@echo publish
	@echo clean
	@echo

#
# production rules
#
$(DIST_DIRS):
	mkdir -p $@

$(DIST)/assets/iosfavicon-%.png: $(FAVICON_MASTER)
	utl/iosresize.sh $< $@

$(DIST)/favicon.ico: $(FAVICON_MASTER)
	utl/png2favico.sh $< $@

$(DIST)/index.html: src/index.hbs
	node utl/smurf html < $< > $@

$(DIST)/components/%.min.css: src/semantic/dist/components/%.min.css
	cp $< $@

$(DIST)/assets/lib/%: src/assets/lib/%
	cp $< $@

$(DIST)/assets/images/%: src/assets/images/%
	cp $< $@

$(DIST)/content: src/content
	cp -R $< $@

$(DIST)/content/%_klein.jpg: src/klein/%_klein.jpg
	convert $< \( -clone 0 -resize $(THUMB_SIZE)x$(THUMB_SIZE) -strip \) -delete 0 - | \
	jpegtran -copy none -optimize -progressive > $@

include thumbnails.mk

#
# phony targets
#
dist: $(DIST_DIRS) \
	$(DIST)/favicon.ico \
	$(DIST)/assets/iosfavicon-152.png \
	$(DIST)/assets/lib/lazysizes.min.js \
	$(DIST)/assets/lib/fancybox.min.js \
	$(DIST)/assets/lib/fancybox.min.css \
	$(DIST)/assets/lib/jquery-3.1.1.min.js \
	$(DIST)/assets/images/logo.svg \
	$(DIST)/assets/images/hans.jpg \
	$(DIST)/components/site.min.css \
	$(DIST)/components/reset.min.css \
	$(DIST)/components/container.min.css \
	$(DIST)/components/header.min.css \
	$(DIST)/components/image.min.css \
	$(DIST)/components/menu.min.css \
	$(DIST)/components/card.min.css \
	$(DIST)/components/segment.min.css \
	$(DIST)/components/table.min.css \
	$(DIST)/content \
	$(DIST)/index.html \
	$(DIST_THUMBNAILS)

thumbinclude:
	node utl/smurf mkThumbs > thumbnails.mk

publish:
	git subtree push --prefix $(DIST) origin master

clean:
	rm -rf dist/*
