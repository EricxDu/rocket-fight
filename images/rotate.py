import os
import sys

from PIL import Image

filename = sys.argv[1]
name, ext = os.path.splitext(filename)
image = Image.open(filename)
width, height = image.size

steps = len(sys.argv) > 2 and int(sys.argv[2]) or 4
degrees = 45 / steps
filters = {
    'cu': Image.BICUBIC, 'ne': Image.NEAREST, 'li': Image.BILINEAR
}
filter = len(sys.argv) > 3 and sys.argv[3] or 'cu'
master = Image.new(mode='RGBA', size=(width*steps, height*8), color=(0,0,0,0))
for x in range(0, steps, 1):
    out0 = image.rotate(-x*degrees, filters[filter])
    out1 = image.rotate(-x*degrees-45, filters[filter])
    out2 = image.rotate(-x*degrees-90, filters[filter])
    out3 = image.rotate(-x*degrees-135, filters[filter])
    out4 = image.rotate(-x*degrees-180, filters[filter])
    out5 = image.rotate(-x*degrees-225, filters[filter])
    out6 = image.rotate(-x*degrees-270, filters[filter])
    out7 = image.rotate(-x*degrees-315, filters[filter])
    master.paste(out0, (x*width, 0))
    master.paste(out1, (x*width, height))
    master.paste(out2, (x*width, height*2))
    master.paste(out3, (x*width, height*3))
    master.paste(out4, (x*width, height*4))
    master.paste(out5, (x*width, height*5))
    master.paste(out6, (x*width, height*6))
    master.paste(out7, (x*width, height*7))
master.save(name + '.' + filter + '.' + str(steps) + ext)
