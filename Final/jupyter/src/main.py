import os
import hashlib
import xml.etree.ElementTree as ET

from flask import Flask, request

from preprocess_data import Question


app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello, Welcome to CloudBase!\nBy HLN\n'


@app.route('/wx', methods={'get'})
def handel():
    print('handel')
    print(request.args)
    signature = request.args.get('signature')
    timestamp = request.args.get('timestamp')
    nonce = request.args.get('nonce')
    echostr = request.args.get('echostr')
    token = 'HLN'

    list_ = [token, timestamp, nonce]
    if all(list_):
        list_.sort()
        s = ''.join(list_)
        hashcode = hashlib.sha1(s.encode('utf-8')).hexdigest()
        print("handle/GET func: hashcode, signature: ", hashcode, signature)
        if hashcode == signature:
            return echostr
    return 'Error'


XmlForm = """
<xml>
<ToUserName><![CDATA[{ToUserName}]]></ToUserName>
<FromUserName><![CDATA[{FromUserName}]]></FromUserName>
<CreateTime>{CreateTime}</CreateTime>vim
<MsgType><![CDATA[{MsgType}]]></MsgType>
<Content><![CDATA[{Content}]]></Content>
</xml>
"""


@app.route('/wx', methods={'post'})
def question():
    print('handel')
    print(request.args)
    signature = request.args.get('signature')
    timestamp = request.args.get('timestamp')
    nonce = request.args.get('nonce')
    echostr = request.args.get('echostr')
    token = 'HLN'

    list_ = [token, timestamp, nonce]
    list_.sort()
    s = ''.join(list_)
    hashcode = hashlib.sha1(s.encode('utf-8')).hexdigest()
    print("handle/GET func: hashcode, signature: ", hashcode, signature)

    if not hashcode == signature:
        return 'Error'
    else:
        xml_raw = request.data
        if not xml_raw:
            return 'success'
        msg = ET.fromstring(xml_raw)
        print(msg)

        if msg.find('MsgType').text != 'text':
            return 'success'
        else:
            res = {
                'ToUserName': msg.find('FromUserName').text,
                'FromUserName': msg.find('ToUserName').text,
                'CreateTime': msg.find('CreateTime').text,
                'MsgType': 'text',
            }

            res['Content'] = qusetion.question_process(msg.find('Content').text) or ''

            return XmlForm.format(**res)
    return 'success'


if __name__ == "__main__":
    qusetion = Question()
    app.run(debug=True, host='0.0.0.0', port=int(os.environ.get('PORT', 80)))
