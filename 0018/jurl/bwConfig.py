#!/usr/bin/python3
#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

__version__ = '1.0.0'

class configFile:
    ''' simple config file support '''
    _recs = {}
    def __init__(self, fn):
        self._fh = open(fn, 'rt')
        self.parse(self._fh)

    def parseline(self, line):
        if line[0] == '#': return
        if '#' in line: line = line.split('#', 2)[0]
        if '=' not in line: return
        ( lhs, rhs ) = line.split('=', 2)
        self._recs[lhs.strip()] = rhs.strip()

    def parse(self, fh):
        for line in fh.readlines():
            self.parseline(line)

    def recs(self):
        return self._recs

def test():
    import sys
    fn = sys.argv[1] if len(sys.argv) > 1 else 'test.conf'

    try:
        conf = configFile(fn)
    except IOError as e:
        print('could not open {},'.format(fn), e)
    else:
        recs = conf.recs()
        for k in sorted(recs):
            print('{} is [{}]'.format(k, recs[k]))

if __name__ == "__main__": test()

