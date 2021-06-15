from flask import Flask,request,jsonify

app=Flask(__name__)

@app.route('/hello',methods=['GET'])
def hello_world():
    jlist=list()
    value=request.args['value']
    for i in range(1,11):
        d={}
        d['value']=value
        d['multiplier']=i
        d['result']=int(value)*i
        jlist.append(d)
    return jsonify(jlist)


if __name__ == "__main__":
    app.run()
