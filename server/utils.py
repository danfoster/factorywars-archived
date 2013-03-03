import config

# see http://stackoverflow.com/questions/36932/whats-the-best-way-to-implement-an-enum-in-python
def enum(**enums):
    return type('Enum', (), enums)

import json
class MyEncoder(json.JSONEncoder):
    def default(self, o):
        return o.__dict__  
jsonEncoder = MyEncoder(separators = (',', ':'))

def toJSON(obj):
    return jsonEncoder.encode(obj)

from network import Command
def _as_command(obj):
    return Command(obj['command'], obj['value'])

def evalJSON(string):
    return json.loads(string, object_hook = _as_command)
