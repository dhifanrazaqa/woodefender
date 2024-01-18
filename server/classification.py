from flask import Flask, request, jsonify
import cv2
import numpy as np
import base64

app = Flask(__name__)

def create_ela(img):
    cv2.imwrite("temp.jpg", img, [cv2.IMWRITE_JPEG_QUALITY, 95])
    img2 = cv2.imread("temp.jpg")
    cv2.imwrite("temp.jpg", img2, [cv2.IMWRITE_JPEG_QUALITY, 90])
    img2 = cv2.imread("temp.jpg")
    diff = 15 * cv2.absdiff(img, img2)
    return diff

def read_base64_image(base64_string):
    encoded_data = base64_string.split(',')[1]
    nparr = np.fromstring(base64.b64decode(encoded_data), np.uint8)
    img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    return img

def encode_image_base64(image):
    _, buffer = cv2.imencode('.jpg', image)
    img_str = base64.b64encode(buffer).decode()
    return img_str

@app.route('/process_image', methods=['POST'])
def process_image():
    try:
        data = request.get_json()
        base64_image = data['image']

        img = read_base64_image(base64_image)

        ela_result = create_ela(img)

        response_image = encode_image_base64(ela_result)

        return jsonify({'result': response_image})
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(debug=True)