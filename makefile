
# get paths and stuff
# defines REPOSITORYPATH
include make-conf-local

42DPI=scale=1 resolution=0.583333325
140DPI=resolution=1.94444441795 scale=1 
DOCUMENT=scope="entire document"

# usage: ./ogexport.js <source> <format> <target> <property_1=value_1>...<property_n>=<value_n>
# e.g.  ./ogexport.js /Users/beb/dev/ogtool/JXA/test-data/test-data.graffle PNG /Users/beb/tmp/fat scale=2 resolution=2
# full path to document and export is required because this JS stuff sucks, define them in make-conf-local
# transparent background: 
# resolution=1.94444441795 scale=1.0 drawsbackground=0 scope="entire document"
# SVG: scope="entire document"


assets:
	# 1. Build small png (625 x 470 px)
	# (used for documentation in the repo and for s3 website)
	# Note: it appears impossible to export one specific canvas from Omnigraffle, just the one that is 
	# the "current canvas", which leads to unpredictable results, therefore this crude workaround
	-mkdir tmp/42dpi
	./ogexport.js $(REPOSITORYPATH)/src/s3-delegation-canvas.graffle PNG $(REPOSITORYPATH)/tmp/42dpi/s3-delegation-canvas $(42DPI) $(DOCUMENT)
	./ogexport.js $(REPOSITORYPATH)/src/s3-organization-canvas.graffle PNG $(REPOSITORYPATH)/tmp/42dpi/s3-organization-canvas $(42DPI) $(DOCUMENT)
	./ogexport.js $(REPOSITORYPATH)/src/s3-team-canvas.graffle PNG $(REPOSITORYPATH)/tmp/42dpi/s3-team-canvas $(42DPI) $(DOCUMENT)
	mv $(REPOSITORYPATH)/tmp/42dpi/s3-delegation-canvas/s3-delegation-canvas-with-guide.png docs/img/s3-delegation-canvas-sm.png
	mv $(REPOSITORYPATH)/tmp/42dpi/s3-organization-canvas/s3-organization-canvas-with-guide.png docs/img/s3-organization-canvas-sm.png
	mv $(REPOSITORYPATH)/tmp/42dpi/s3-team-canvas/s3-team-canvas-with-guide.png docs/img/s3-team-canvas-sm.png

	# 2. Build big png  (resolution ~ 2000px)
	# (as template for background for cnvrg or similar)
	# version without and with shaded explanation

	-mkdir tmp/140dpi
	-mkdir docs/img/140dpi

	./ogexport.js $(REPOSITORYPATH)/src/s3-delegation-canvas.graffle PNG $(REPOSITORYPATH)/tmp/140dpi/delegation-canvas $(140DPI) $(DOCUMENT)
	./ogexport.js $(REPOSITORYPATH)/src/s3-organization-canvas.graffle PNG $(REPOSITORYPATH)/tmp/140dpi/organization-canvas $(140DPI) $(DOCUMENT)
	./ogexport.js $(REPOSITORYPATH)/src/s3-team-canvas.graffle PNG $(REPOSITORYPATH)/tmp/140dpi/team-canvas $(140DPI) $(DOCUMENT)
	mv tmp/140dpi/delegation-canvas/* docs/img/140dpi
	mv tmp/140dpi/organization-canvas/* docs/img/140dpi
	mv tmp/140dpi/team-canvas/* docs/img/140dpi

	# 3. Build one PDF with all canvases 
	# of course it is also impossible to export one specific canvas to a PDF file.

	./ogexport.js $(REPOSITORYPATH)/src/s3-delegation-canvas.graffle PDF $(REPOSITORYPATH)/docs/pdf/s3-delegation-canvas.pdf $(DOCUMENT)
	./ogexport.js $(REPOSITORYPATH)/src/s3-organization-canvas.graffle PDF $(REPOSITORYPATH)/docs/pdf/s3-organization-canvas.pdf $(DOCUMENT)
	./ogexport.js $(REPOSITORYPATH)/src/s3-team-canvas.graffle PDF $(REPOSITORYPATH)/docs/pdf/s3-team-canvas.pdf $(DOCUMENT)

site:
	cd docs; bundle exec jekyll build


