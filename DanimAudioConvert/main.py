import json

from flask import Flask, Response, request
from pydub import AudioSegment
from requests_toolbelt.multipart.encoder import MultipartEncoder
from werkzeug.utils import secure_filename

app = Flask(__name__)


@app.route("/", methods=["POST"])
def index():

    file = request.files["file"]

    filename = secure_filename("bigboot1.wav")
    file.save(filename)

    words=request.form['words']
    words1=json.loads(words)
    words=words1
    original_file = AudioSegment.from_wav("bigboot1.wav")


    te=words[0]
    # 추출할 구간 설정
    # start_time = 1000 # 1초
    start_time = (int)(words[0]['startTime'])
    end_time = -1
    # 추출할 구간의 음성을 다른 음성 파일로 변환
    new_sound = AudioSegment.from_wav("다님.wav")

    # 초기 작업
    total_file = original_file[:start_time]
    for l in range(len(words)):

        temp = words[l]
        if l > 0:
            total_file += original_file[start_time:end_time]
        total_file += new_sound
        start_time = temp['endTime']
        if l != len(words) - 1:
            temp_next = words[l + 1]
            end_time = temp_next['startTime']
        else:
            total_file += original_file[start_time:]

    # 기존 음성 파일에서 추출한 구간 제거
    combined_file = total_file

    # 기존 음성 파일과 새로운 음성 파일 합치기
    # combined_file = original_file + new_sound
    # 합친 음성 파일 저장
    combined_file.export("combined.wav", format="wav")
    print(len(combined_file))
    audio = ""
    with open('combined.wav', 'rb') as f:
        audio = f.read()
        # MultipartEncoder를 사용하여 데이터를 생성
        multipart_data = MultipartEncoder(
            fields={'audio': ("conbined.wav", audio, "audio/wav")}
        )
        # 응답 생성
        response = Response(multipart_data.to_string(), content_type=multipart_data.content_type)

        return response





app.debug = True
app.run(host="localhost", port=4000, use_reloader=False)
