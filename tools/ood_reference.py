"""Score de referência do modelo OOD v2, calculado exatamente como no treino.

Serve para conferir se o app pré-processa a foto do mesmo jeito: rode este
script e o app na MESMA imagem e compare os scores. Diferenças na casa dos
centésimos são esperadas, porque o decodificador de JPEG do app não é o mesmo
do Pillow.

O app registra no log (flutter run / logcat) uma linha como:

    OOD Score: 2.7341 (/data/user/0/com.example.dermalyze/cache/dermalyze_crop_123.jpg)

Para trazer essa imagem recortada do tablet (só em build debug):

    adb exec-out run-as com.example.dermalyze cat cache/dermalyze_crop_123.jpg > recorte.jpg

Uso:

    pip install torch torchvision onnxruntime pillow
    python tools/ood_reference.py recorte.jpg [outra.jpg ...]
"""

import sys
from pathlib import Path

import onnxruntime as ort
import torchvision
from PIL import Image

MODEL_PATH = Path(__file__).resolve().parent.parent / "assets" / "models" / "ood_model_v2.onnx"

# Mesmo limiar do app (kOodAcceptanceThreshold em inference_service.dart).
THRESHOLD = 2.48


class ImgEvalTransform:
    """Cópia do transform de avaliação usado no treino."""

    def __init__(self, size=(224, 224), normalization=([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])):
        self.normalization = normalization
        self.size = size

    def __call__(self, img):
        transforms = torchvision.transforms.Compose([
            torchvision.transforms.Resize(self.size),
            torchvision.transforms.ToTensor(),
            torchvision.transforms.Normalize(self.normalization[0], self.normalization[1]),
        ])
        return transforms(img)


def main(paths):
    if not paths:
        print(__doc__)
        return 1

    session = ort.InferenceSession(str(MODEL_PATH))
    input_name = session.get_inputs()[0].name
    transform = ImgEvalTransform()

    for path in paths:
        image = Image.open(path).convert("RGB")
        tensor = transform(image).unsqueeze(0).numpy()
        score = float(session.run(None, {input_name: tensor})[0][0][0])
        verdict = "ACEITA" if score >= THRESHOLD else "REJEITA"
        print(f"{path}: score={score:.4f} -> {verdict}")

    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
