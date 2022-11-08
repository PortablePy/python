"""
#################################################################################
launch FTP getfile function with a reusable form GUI class;  uses os.chdir to 
goto target local dir (getfile currently assumes that filename has no local 
directory path prefix);  runs getfile.getfile in thread to allow more than one 
to be running at once and avoid blocking GUI during downloads;  this differs 
from socket-based getfilegui, but reuses Form GUI builder tool;  supports both 
user and anonymous FTP as currently coded;

caveats: the password field is not displayed as stars here, errors are printed
to the console instead of shown in the GUI (threads can't generally update the 
GUI on Windows), this isn't 100% thread safe (there is a slight delay between 
os.chdir here and opening the local output file in getfile) and we could 
display both a save-as popup for picking the local dir, and a remote directory
listing for picking the file to get;  suggested exercises: improve me;
#################################################################################
"""

from tkinter import Tk, mainloop
from tkinter.messagebox import showinfo
import getfile, os, sys, _thread                # FTP getfile here, not socket
from PP4E.Internet.Sockets.form import Form     # reuse form tool in socket dir

class FtpForm(Form):
    def __init__(self):
        root = Tk()
        root.title(self.title)
        labels = ['Server Name', 'Remote Dir', 'File Name',
                  'Local Dir',   'User Name?', 'Password?']
        Form.__init__(self, labels, root)
        self.mutex = _thread.allocate_lock()
        self.threads = 0

    def transfer(self, filename, servername, remotedir, userinfo):
        try:
            self.do_transfer(filename, servername, remotedir, userinfo)
            print('%s of "%s" successful'  % (self.mode, filename))
        except:
            print('%s of "%s" has failed:' % (self.mode, filename), end=' ')
            print(sys.exc_info()[0], sys.exc_info()[1])
        self.mutex.acquire()
        self.threads -= 1
        self.mutex.release()

    def onSubmit(self):
        Form.onSubmit(self)
        localdir   = self.content['Local Dir'].get()
        remotedir  = self.content['Remote Dir'].get()
        servername = self.content['Server Name'].get()
        filename   = self.content['File Name'].get()
        username   = self.content['User Name?'].get()
        password   = self.content['Password?'].get()
        userinfo   = ()
        if username and password:
            userinfo = (username, password)
        if localdir:
            os.chdir(localdir)
        self.mutex.acquire()
        self.threads += 1
        self.mutex.release()
        ftpargs = (filename, servername, remotedir, userinfo)
        _thread.start_new_thread(self.transfer, ftpargs)
        showinfo(self.title, '%s of "%s" started' % (self.mode, filename))

    def onCancel(self):
        if self.threads == 0:
            Tk().quit()
        else:
            showinfo(self.title,
                     'Cannot exit: %d threads running' % self.threads)

class FtpGetfileForm(FtpForm):
    title = 'FtpGetfileGui'
    mode  = 'Download'
    def do_transfer(self, filename, servername, remotedir, userinfo):
        getfile.getfile(
            filename, servername, remotedir, userinfo, verbose=False, refetch=True)

if __name__ == '__main__':
    FtpGetfileForm()
    mainloop()
