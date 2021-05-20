
# get paths and stuff
# defines
# EXPORTSCRIPT
# SOURCEPATH
# EXPORTPATH
include make-conf-local
EXPORTARGS=scale=2 resolution=2 scope="entire document"
42DPI=scale=1 resolution=0.58 scope="entire document"
PDFJOIN='/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py'

# usage: ./ogexport.js <source> <format> <target> <property_1=value_1>...<property_n>=<value_n>
# e.g.  ./ogexport.js /Users/beb/dev/ogtool/JXA/test-data/test-data.graffle PNG /Users/beb/tmp/fat scale=2 resolution=2
# full path to document and export is required because this JS stuff sucks, define them in make-conf-local
# transparent background: 
# resolution=1.94444441795 scale=1.0 drawsbackground=0 scope="entire document"
# SVG: scope="entire document"


# $(call export_language,src,en-tmp,PNG)
define export_language
	ogexport.js $(SOURCEPATH)/$(1)/workflow-and-value.graffle $(3) $(EXPORTPATH)/$(2)/workflow-and-value scale=2 resolution=2 scope="entire document"
endef

test:
	# 1. Build small png (625 x 470 px)
	# (used for documentation in the repo and for s3 website)

	-mkdir tmp/42dpi
	ogexport.js $(SOURCEPATH)/s3-delegation-canvas.graffle PNG $(EXPORTPATH)/42dpi/s3-delegation-canvas $(42DPI)
	mv tmp/42dpi/s3-delegation-canvas/s3-delegation-canvas-with-guide.png docs/img/s3-delegation-canvas-sm.png
	ogexport.js $(SOURCEPATH)/s3-organization-canvas.graffle PNG $(EXPORTPATH)/42dpi/s3-organization-canvas $(42DPI)
	mv tmp/42dpi/s3-organization-canvas/s3-organization-canvas-with-guide.png docs/img/s3-organization-canvas-sm.png
	ogexport.js $(SOURCEPATH)/s3-team-canvas.graffle PNG $(EXPORTPATH)/42dpi/s3-team-canvas $(42DPI)
	mv tmp/42dpi/s3-team-canvas/s3-team-canvas-with-guide.png docs/img/s3-team-canvas-sm.png


site:
	cd docs; bundle exec jekyll build


xprt-en:
	-mkdir png/en-tmp
	$(call export_language,src,en-tmp,PNG)


xprt-svg:
	-mkdir png/en-svg
	$(call export_language,src,en-svg,SVG)

