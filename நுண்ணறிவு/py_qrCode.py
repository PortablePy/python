import pyqrcode
# import png

def qr_code():
    # name_s = "வாழ்க வளமுடன்"
    name_s = "Ascii only"
    d = pyqrcode.create(name_s)
    d.png(
    d.png("my_img.png", scale=6)
    print("done")

if __name__ == "__main__":
    qr_code()          
