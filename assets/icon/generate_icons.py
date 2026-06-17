"""Generate Curae launcher icon master PNGs from the brand mark.

Produces:
  assets/icon/icon.png       1024x1024 opaque (healing-green field) - master for all platforms
  assets/icon/foreground.png 1024x1024 transparent, padded mark    - Android adaptive foreground

Run:  python assets/icon/generate_icons.py
Then: dart run flutter_launcher_icons
"""
import os
from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.abspath(__file__))
GREEN = (0, 108, 81, 255)
WHITE = (255, 255, 255, 255)
SS = 4  # supersample factor for smooth edges


def draw_mark(draw, cx, cy, scale):
    """Draw the white cross + pulse mark centred at (cx, cy) at the given scale."""
    # content bbox is x:312..840 (centre 576), y:312..712 (centre 512)
    def sx(x):
        return cx + (x - 576) * scale
    def sy(y):
        return cy + (y - 512) * scale

    # vertical bar (rounded)
    draw.rounded_rectangle([sx(442), sy(312), sx(582), sy(712)],
                           radius=70 * scale, fill=WHITE)
    # horizontal left + centre bar (rounded)
    draw.rounded_rectangle([sx(312), sy(446), sx(560), sy(578)],
                           radius=66 * scale, fill=WHITE)
    # right arm tapering into an ECG pulse tick
    pts = [(560, 512), (610, 512), (660, 392), (720, 632), (772, 512), (840, 512)]
    spts = [(sx(x), sy(y)) for x, y in pts]
    w = int(96 * scale)
    draw.line(spts, fill=WHITE, width=w, joint="curve")
    r = w / 2
    for (x, y) in (spts[0], spts[-1]):
        draw.ellipse([x - r, y - r, x + r, y + r], fill=WHITE)


def make_master():
    size = 1024 * SS
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.rounded_rectangle([0, 0, size - 1, size - 1], radius=230 * SS, fill=GREEN)
    draw_mark(d, size / 2, size / 2, SS * 1.0)
    img = img.resize((1024, 1024), Image.LANCZOS)
    # flatten onto opaque green so iOS has no alpha
    flat = Image.new("RGB", (1024, 1024), GREEN[:3])
    flat.paste(img, (0, 0), img)
    flat.save(os.path.join(HERE, "icon.png"))
    print("wrote icon.png")


def make_foreground():
    size = 1024 * SS
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    # adaptive icons crop to ~66% safe zone -> render mark smaller, centred
    draw_mark(d, size / 2, size / 2, SS * 0.60)
    img = img.resize((1024, 1024), Image.LANCZOS)
    img.save(os.path.join(HERE, "foreground.png"))
    print("wrote foreground.png")


if __name__ == "__main__":
    make_master()
    make_foreground()
