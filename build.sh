# build various versions of the s3 canvases
#
# uses ogtools (http://github.com/bboc/ogtool)

alias pdfjoin='/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py'

# 1. Build small png (625 x 470 px)
# (used for documentation in the repo and for s3 website)
ogexport png src/s3-delegation-canvas.graffle img/s3-delegation-canvas-sm.png --canvas s3-delegation-canvas-with-guide @42dpi.ini
ogexport png src/s3-organization-canvas.graffle img/s3-organization-canvas-sm.png --canvas s3-organization-canvas-with-guide @42dpi.ini
ogexport png src/s3-team-canvas.graffle img/s3-team-canvas-sm.png --canvas s3-team-canvas-with-guide @42dpi.ini

# 2. Build big png  (resolution ~ 2000px)
# (as template for background for cnvrg or similar)
# version without and with shaded explanation

ogexport png src/s3-delegation-canvas.graffle img/140dpi --canvas s3-delegation-canvas @140dpi.ini
ogexport png src/s3-delegation-canvas.graffle img/140dpi --canvas s3-delegation-canvas-with-guide @140dpi.ini
ogexport png src/s3-organization-canvas.graffle img/140dpi --canvas s3-organization-canvas @140dpi.ini
ogexport png src/s3-organization-canvas.graffle img/140dpi --canvas s3-organization-canvas-with-guide @140dpi.ini
ogexport png src/s3-team-canvas.graffle img/140dpi --canvas s3-team-canvas @140dpi.ini
ogexport png src/s3-team-canvas.graffle img/140dpi --canvas s3-team-canvas-with-guide @140dpi.ini

# 3. Build PDF versions 
# (one version with 2 pages, one for print plain, and one with shaded text)

ogexport pdf src/s3-delegation-canvas.graffle pdf --canvas s3-delegation-canvas @140dpi.ini
ogexport pdf src/s3-delegation-canvas.graffle pdf --canvas s3-delegation-canvas-with-guide @140dpi.ini
ogexport pdf src/s3-delegation-canvas.graffle pdf --canvas s3-delegation-canvas-guide @140dpi.ini
pdfjoin -o s3-delegation-canvas.pdf pdf/s3-delegation-canvas-guide.pdf pdf/s3-delegation-canvas.pdf

ogexport pdf src/s3-organization-canvas.graffle pdf --canvas s3-organization-canvas @140dpi.ini
ogexport pdf src/s3-organization-canvas.graffle pdf --canvas s3-organization-canvas-with-guide @140dpi.ini
ogexport pdf src/s3-organization-canvas.graffle pdf --canvas s3-organization-canvas-guide @140dpi.ini
pdfjoin -o s3-organization-canvas.pdf pdf/s3-organization-canvas-guide.pdf pdf/s3-organization-canvas.pdf

ogexport pdf src/s3-team-canvas.graffle pdf --canvas s3-team-canvas @140dpi.ini
ogexport pdf src/s3-team-canvas.graffle pdf --canvas s3-team-canvas-with-guide @140dpi.ini
ogexport pdf src/s3-team-canvas.graffle pdf --canvas s3-team-canvas-guide @140dpi.ini
pdfjoin -o s3-team-canvas.pdf pdf/s3-team-canvas-guide.pdf pdf/s3-team-canvas.pdf
