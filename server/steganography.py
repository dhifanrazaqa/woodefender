from flask import Flask, request, jsonify
from PIL import Image
from io import BytesIO
import cv2
import numpy as np
import base64
from blind_watermark import WaterMark

app = Flask(__name__)


class Steganography:

    BLACK_PIXEL = (0, 0, 0)

    def _int_to_bin(self, rgb):
        if(len(rgb) == 4):
            rgb = rgb[:3]
        r, g, b = rgb
        return f'{r:08b}', f'{g:08b}', f'{b:08b}'

    def _bin_to_int(self, rgb):
        r, g, b = rgb
        return int(r, 2), int(g, 2), int(b, 2)

    def _merge_rgb(self, rgb1, rgb2):
        r1, g1, b1 = self._int_to_bin(rgb1)
        r2, g2, b2 = self._int_to_bin(rgb2)
        rgb = r1[:4] + r2[:4], g1[:4] + g2[:4], b1[:4] + b2[:4]
        return self._bin_to_int(rgb)

    def _unmerge_rgb(self, rgb):
        r, g, b = self._int_to_bin(rgb)
        new_rgb = r[4:] + '0000', g[4:] + '0000', b[4:] + '0000'
        return self._bin_to_int(new_rgb)

    def merge(self, image1, image2):
        if image2.size[0] > image1.size[0] or image2.size[1] > image1.size[1]:
            raise ValueError('Image 2 should be smaller than Image 1!')

        # Get the pixel map of the two images
        map1 = image1.load()
        map2 = image2.load()

        new_image = Image.new(image1.mode, image1.size)
        new_map = new_image.load()

        for i in range(image1.size[0]):
            for j in range(image1.size[1]):
                is_valid = lambda: i < image2.size[0] and j < image2.size[1]
                rgb1 = map1[i ,j]
                rgb2 = map2[i, j] if is_valid() else self.BLACK_PIXEL
                new_map[i, j] = self._merge_rgb(rgb1, rgb2)

        return new_image

    def unmerge(self, image):
        pixel_map = image.load()

        # Create the new image and load the pixel map
        new_image = Image.new(image.mode, image.size)
        new_map = new_image.load()

        for i in range(image.size[0]):
            for j in range(image.size[1]):
                new_map[i, j] = self._unmerge_rgb(pixel_map[i, j])

        return new_image

def create_watermark_image(width, height, text, font_scale=1, font_thickness=1):
    # Membuat gambar dengan latar putih
    image = np.ones((height, width, 3), dtype=np.uint8) * 255
    text = text + " "

    # Menentukan font dan propertinya
    font = cv2.FONT_HERSHEY_SIMPLEX
    font_color = (0, 0, 0)  # Hitam
    font_thickness = font_thickness
    font_scale = 0.4

    # Menentukan posisi awal tulisan
    text_size = cv2.getTextSize(text, font, font_scale, font_thickness)[0]
    repetitions_x = width // text_size[0] + 1
    repetitions_y = height // text_size[1] + 1

    # Menambahkan tulisan sebagai watermark secara berulang
    for i in range(repetitions_y):
        for j in range(repetitions_x):
            start_x = j * (text_size[0] + 3)
            start_y = (i + 1) * (text_size[1] + 3)  # Geser setiap kali iterasi baris baru
            cv2.putText(image, text, (start_x, start_y), font, font_scale, font_color, font_thickness, cv2.LINE_AA)

    cv2.imwrite('wm.png', image)

def robustWatermark(pw):
    bwm1 = WaterMark(password_wm=pw, password_img=pw)
    # read original image
    bwm1.read_img('rob_ori.png')
    # read watermark
    bwm1.read_wm('wm.png')
    # embed
    bwm1.embed('embedded.png')

def extrRobustWatermark(pw, size):
    bwm1 = WaterMark(password_wm=pw, password_img=pw)
    # notice that wm_shape is necessary
    bwm1.extract(filename='rob_watermarked.png', wm_shape=(size, size), out_wm_name='extracted.png', )

def read_base64_image(base64_string):
    # Mengambil data gambar dari base64
    encoded_data = base64_string.split(',')[1]
    image_data = base64.b64decode(encoded_data)

    # Membaca gambar menggunakan PIL
    img = Image.open(BytesIO(image_data))

    return img

def convert_to_pillow_image(opencv_img):
    # Konversi dari format OpenCV ke format Pillow
    pil_img = Image.fromarray(cv2.cvtColor(opencv_img, cv2.COLOR_BGR2RGB))

    return pil_img

def encode_image_base64(image):
    _, buffer = cv2.imencode('.jpg', image)
    img_str = base64.b64encode(buffer).decode()
    return img_str

def image_to_base64(image_path):
    with open(image_path, "rb") as image_file:
        # Membaca gambar sebagai data bytes
        image_data = image_file.read()

        # Mengonversi data bytes menjadi base64
        base64_string = base64.b64encode(image_data).decode('utf-8')

        return base64_string

def convert_pillow_to_base64(pillow_image):
    # Simpan gambar Pillow ke dalam objek BytesIO
    image_stream = BytesIO()
    pillow_image.save(image_stream, format="PNG")  # Anda dapat mengubah format sesuai kebutuhan

    # Ambil nilai byte dari objek BytesIO dan konversi ke base64
    base64_string = base64.b64encode(image_stream.getvalue()).decode("utf-8")

    return base64_string

@app.route('/get_wm', methods=['POST'])
def get_wm():
    try:
        data = request.get_json()
        wm = data['wm']

        create_watermark_image(128, 128, wm)

        response_image = image_to_base64('wm.png')

        return jsonify({'result': response_image})
    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/process_image_rob', methods=['POST'])
def process_image_rob():
    try:
        data = request.get_json()
        base64_image1 = data['image']
        image1 = read_base64_image(base64_image1)
        if(image1.size[0] < 1200 or image1.size[1] < 1200):
            image1 = image1.resize((1200,1200))
        image1.save('rob_ori.png', 'PNG')

        wm = data['wm']
        image2 = read_base64_image(wm)
        image2.save('wm.png', 'PNG')
        # create_watermark_image(128, 128, wm)

        pw = data['pw']

        robustWatermark(pw)

        response_image = image_to_base64('embedded.png')

        return jsonify({'result': response_image})
    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/extract_image_rob', methods=['POST'])
def extract_image_rob():
    try:
        data = request.get_json()
        base64_image = data['image']
        image = read_base64_image(base64_image)
        image.save('rob_watermarked.png', 'PNG')

        pw = data['pw']

        extrRobustWatermark(pw, 128)

        response_image = image_to_base64('extracted.png')

        return jsonify({'result': response_image})
    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/process_image_frag', methods=['POST'])
def process_image():
    try:
        data = request.get_json()
        base64_image1 = data['image1']
        image1 = read_base64_image(base64_image1)

        base64_image2 = data['image2']
        image2 = read_base64_image(base64_image2)
        image2 = image2.resize((image1.size[0] - 1, image1.size[1] - 1))

        result = Steganography().merge(image1, image2)

        response_image = convert_pillow_to_base64(result)

        return jsonify({'result': response_image})
    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/extract_image_frag', methods=['POST'])
def extract_image():
    try:
        data = request.get_json()
        base64_image = data['image']
        image = read_base64_image(base64_image)
        print("HERE")
        result = Steganography().unmerge(image)
        print("SEINI")
        response_image = convert_pillow_to_base64(result)

        return jsonify({'result': response_image})
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run()