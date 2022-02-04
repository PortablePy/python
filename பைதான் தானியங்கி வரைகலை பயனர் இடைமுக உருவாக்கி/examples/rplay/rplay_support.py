#! /usr/bin/env python
#
# Support module generated by PAGE version 4.8
# In conjunction with Tcl version 8.6
#    Dec 05, 2016 10:37:48 PM
#    Dec 08, 2016 08:11:28 AM
#    Dec 19, 2016 09:19:37 PM
#    Dec 29, 2016 03:37:45 PM
#    Dec 31, 2016 08:44:54 AM

import sys
import os

try:
    from Tkinter import *
except ImportError:
    from tkinter import *

try:
    import ttk
    py3 = 0
except ImportError:
    import tkinter.ttk as ttk
    py3 = 1

import time
import threading
import random
import datetime
import copy
import socket

def set_Tk_var():
    # These are Tk variables used passed to Tkinter and must be
    # defined before the widgets using them are created.
    global time_current
    time_current = StringVar()

    global title
    title = StringVar()

    global start_time
    start_time = StringVar()

    global criteria
    criteria = StringVar()

def previous():
    print('rplay_support.previous')
    sys.stdout.flush()
    global previous_flag
    previous_flag = True
    kill_playloop()
    load_search_results(cd_stack, "Previous CD's")

def cont():
    print('rplay_support.cont')
    sys.stdout.flush()
    global continue_flag
    continue_flag = True
    kill_playloop()
    play()

def search():
    """When search button is selected the list of albums is searched for
    the criteria string. The criteria is split into tokens at blanks and
    and the list is repeatedly searched for the tokens. If a token is
    not found the title is deleted from the list so that the list
    shrinks pretty fast.

    The currently playing selection is killed and the main text box is
    used to display the test results.
    """
    print('rplay_support.search')
    sys.stdout.flush()
    global search_flag
    global search_albums
    search_flag = True
    search_string = criteria.get()
    if search_string == '': return
    search_string = search_string.lower()
    search_string = search_string.split()
    search_albums = copy.deepcopy(albums)

    for search_s in search_string:
        del_list = []
        index = 0
        for album in search_albums:
            album_lower = album.lower()
            if album_lower.find(search_s) == -1:
                del_list.append(index)
            index += 1
        newlist = del_list[::-1]
        for d in newlist:
            del search_albums[d]
    load_search_results(search_albums, "Search Results")
    kill_playloop()

def load_search_results(albums, msg):
    """Loads the remaining list of album titles containing all the
    tokens.
    """
    w.Scrolledtext1.delete(1.0, END) # Clear the GUI textbox
    for a in albums:
        edited_album = a.replace('_', ' ') + '\n'
        w.Scrolledtext1.insert(END, edited_album)
    w.Scrolledtext2.delete(1.0, END) # Clear the GUI textbox
    w.Scrolledtext2.insert(END, msg)

def stop():
    """ Kills the play loop and clears the text boxes. However, the
    program waits for a selection of another CD. Does not terminate the
    program.
    """
    print('rplay_support.stop')
    sys.stdout.flush()
    kill_playloop()
    pos = w.Scrolledtext1.index(END)
    pos = int(pos.split('.')[0])    # line number of last line
    if pos <= 7:
        w.Scrolledtext1.insert(END, '\n\n\n\n\n\n\n')
        pad = 20
    else:
        e = w.Scrolledtext1.index('7.end')
        ee = e.split('.')[1]
        ee = int(ee)                # length of line 7.
        if ee >= 20:
            pad = 0
        else:
            pad = 20 - ee
    w.Scrolledtext1.insert("7.20", pad*' ' + '__STOPPED__')
    w.Scrolledtext1.tag_configure('stop',
                                  foreground='yellow', background='blue')
    w.Scrolledtext1.tag_add('stop', '7.20', '7.31') # Color desired line.
    w.Scrolledtext1.see(7.0)

def new_album():
    """Kills the play loop and then selects and restarts the play loop
    with a newly selected CD.
    """
    print('rplay_support.new_album')
    sys.stdout.flush()
    global semaphore
    global selection_flag
    global search_flag
    global continue_flag
    global repeat_flag
    semaphore = False
    selection_flag = False
    search_flag = False
    continue_flag = False
    repeat_flag = False
    kill_playloop()
    #select_album()
    play()

def select_album():
    global cd
    global tracks
    #cd, tracks = pick_album(albums)
    pick_album()
    load_textbox(tracks)
    root.update()
    return

def repeat_cd():
    print('rplay_support.repeat_cd')
    sys.stdout.flush()
    global repeat_flag
    repeat_flag = True
    kill_playloop()
    load_textbox(tracks)
    play()

if socket.gethostname() == 'ajax':
    dir = os.path.expanduser('~/mp3/cdrip') # where my mp3's are
else:
    dir = os.path.expanduser('~/ajax-files/mp3/cdrip') # where my mp3's are


def selection(p1):
    """This was a devil because I want to do a selection of a track so
    that that track would be immediately played. However, I was getting
    multiple events and those after the first were screwing me up. I was
    never able to resolve the problem, so now the selection is triggered
    by a <ButtonRelease-1> event to insure that I only get one.
    """
    global sel_index
    global selection_flag
    global tracks
    sys.stdout.flush()
    ranges = w.Scrolledtext1.tag_ranges(SEL)
    if len(ranges) == 0:
        return
        start_index = len(tracks)
    else:
        start = ranges[0]
        start_index = int(start.string.split('.')[0])
    if search_flag:
        search_album(search_albums, start_index)
        load_textbox(tracks)
        sel_index = 0
        criteria.set("")
    elif previous_flag:
        search_album(cd_stack, start_index)
        load_textbox(tracks)
        sel_index = 0
        criteria.set("")
    else:
        selection_flag = True
        sel_index = start_index
        kill_playloop()
    play()

def play():
    """This function creates a separate thread 'play_tracks' which does
    the actual playing. setDaemon is called so that both threads are
    running simultaneously.  The isAlive loop updated the GUI 4 times a
    second so that the GUI is fairly responsive.
    """
    print('rplay_support.play')
    sys.stdout.flush()
    global cmd
    global semaphore
    global t
    semaphore = False
    #t = threading.Thread(target=play_tracks, args=(tracks,))
    t = threading.Thread(target=play_tracks)
    t.setDaemon(True)
    t.start()
    while t.isAlive():
        time.sleep(0.25)
        root.update()

def play_tracks ():
    """Heart of the program. The outer loop selects the CD to be played
    whether it is a new CD for which the tracks are played in order
    starting with the first or if the a track of the current CD is
    selected the tracks of the CD are played in order starting with the
    one selected. The inner loop play the remaining tracks of the CD.

    This runs as a separate thread so that the GUI is active while the
    music plays.
    """
    print('rplay_support.play_tracks')
    global cmd
    global semaphore
    global selection_flag
    global search_flag
    global continue_flag
    global repeat_flag
    global previous_flag
    global sel_index
    global index
    global cd
    global tracks
    while True:
        if selection_flag:
            # Start playing current CD with the selected track.
            selection_flag = False
            index = sel_index - 1
            color_line(sel_index, cd_track[index])
            w.Scrolledtext1.see(float(sel_index)) # Make the current selection is
                                                  # visible in the text window.
            root.update()
        elif search_flag:
            # If we select the CD from a search we want to start with
            # first track.
            search_flag = False
            index = 0
        elif continue_flag:
            continue_flag = False
            load_textbox(tracks)
        elif repeat_flag:
            repeat_flag = False
            index = 0
        elif previous_flag:
            previous_flag = False
            index = 0
        else:
            select_album()
            index = 0
        while index < len(tracks):
            if track_contains_colon(tracks[index]): continue
            cmd = 'mpg123  ' + tracks[index]
            #cmd = "vlc " + tracks[index]      # alternate player
            color_line(index+1, cd_track[index])
            w.Scrolledtext1.see(float(index+1)) # Make sure the current
                                                # selection is visible
                                                # in the text window.
            os.system(cmd)
            if semaphore:
                # Return, terminating the thread if the semaphore is set.
                semaphore = False
                if cd not in cd_stack:
                    cd_stack.append(cd)
                return
            index += 1
        if cd not in cd_stack:
            cd_stack.append(cd)

def track_contains_colon(track):
    """Colons cause fits with Linux commands, so skip any files
    containing colons. This is for old rips; lately I have been using
    detox to remove offending characters in file names. This is used because
    my CD collection was put on disk before I realized that this might be
    a problem.
    """
    if track.find(':') > -1:
        c = open(os.path.join(cwd(),'colon'), 'a')
        c.write(cd_title)
        return True
    return False

def search_album(albums, number):
    '''Get a list of all the tracks in the cd. They are the mp3 files in
    the directory with the album name as the directory name.
    '''
    global cd
    global tracks
    cd = albums[number-1]
    cmd = 'ls -rt %s/"%s"/*.mp3' % (dir,cd)
    tracks = []
    try:
        tracks = os.popen(cmd).readlines()
        cd_found = True
    except:
        print ('Unable to read album: %s' % cd)

def pick_album():
    """
    Selects a random cd from the list of albums and makes sure that
    the tracks are available for that album.  Available means that
    one can do an ls on the track files and that is important because
    the ripping process may leave blanks or illegal characters in the
    file names.  This should not have happened if 'detox -r' had been
    run one the CD directory after ripping.
    """
    global cd
    global tracks
    no = len(albums)
    cd_found = False
    while not cd_found:
        pick = random.randrange(len(albums))
        cd = albums[pick]
        cmd = 'ls -rt %s/"%s"/*.mp3' % (dir,albums[pick])
        tracks = []
        try:
            tracks = os.popen(cmd).readlines()
            cd_found = True
        except:
            print ('Unable to read album: %s' % cd)
    return

def c_quit(p1):
    print('rplay_support.c_quit')
    sys.stdout.flush()
    quit()

def quit():
    ''' Exit the program.'''
    global semaphore
    print('rplay_support.quit')
    kill_playloop()
    sys.exit()

def kill_playloop():
    '''Terminate the play_tracks thread by killing the mpg123 process
    and setting the semaphore to tell the tread to return, thereby
    killing it.
    '''
    global semaphore
    if ('t' in globals()) and  t.isAlive():
        semaphore = True
        os.system("pkill mpg123")
    while ('t' in globals()) and  t.isAlive() and semaphore:
        time.sleep(0.1)
        root.update()


def load_textbox(tracks):
    """Load both the title textbox and the tracks textbox.  Before each
       line is added the text is cleaned up to remove underbar character.
       This uses regular expressions to parse the track name and extract the
       relevant information. Also, determine and post start time.
    """
    global cd_track
    global cd_title
    global start_time
    w.Scrolledtext1.delete(1.0, END) # Clear the GUI textbox.
    split_patt = r'.*cdrip/(.*)/[0-9_-]*(.*)\.mp3'
    split_r = re.compile(split_patt)
    mo = split_r.search(tracks[0])
    if mo != None:
        # Load title
        cd_title  = mo.group(1)
        cd_title_replaced = cd_title.replace('_', ' ')
        w.Scrolledtext2.delete(1.0, END) # Clear the title textbox.

        w.Scrolledtext2.insert(END, cd_title_replaced)
        now = datetime.datetime.now()
        hr = now.hour
        min = now.minute
        if int(min) < 10:
            min = '0' + str(min)
        if hr > 12:
            hr -= 12
            period = 'p.m.'
        else:
            period = 'a.m.'
        start = str(hr) + ':' + str(min) + ' ' + period
        start_time.set(start)
    # Loads the tracks.
    cd_track = []
    index = 0
    for line in tracks:
        mo = split_r.search(line)
        if mo != None:
            cd_track.append(mo.group(2))
            edited_track = cd_track[index].replace('_', ' ') + '\n'
            w.Scrolledtext1.insert(END, edited_track) # Insert track
            index += 1

    return


def color_line(curr_index, line):
    ''' Function to color current line red.'''
    w.Scrolledtext1.tag_remove('current', 1.0, END)
    w.Scrolledtext1.tag_configure('current',
                                  foreground='red', background='white')
    start, end = (0, len(line))
    min_c = '%d.0+%dchars' % (curr_index, start)
    max_c = '%d.0+%dchars' % (curr_index, end)
    w.Scrolledtext1.tag_add('current', min_c, max_c) # Color desired line.

def read_albums():
    ''' Read list of albums. '''
    global album_dict
    dir_list = os.listdir(dir)
    return dir_list

def init(top, gui, *args, **kwargs):
    '''The list of albums is read once at the beginning of execution.
       If the program is left running for a long time then CD might be
       added but not known to the program.'''
    global w, top_level, root
    global albums
    global selection_flag
    global search_flag
    global continue_flag
    global repeat_flag
    global previous_flag
    global cd_stack
    w = gui
    top_level = top
    root = top
    top.protocol("WM_DELETE_WINDOW", quit)
    if socket.gethostname() != 'ajax':
        mount_music()
    selection_flag = False
    search_flag = False
    continue_flag = False
    repeat_flag = False
    previous_flag = False
    cd_stack = []
    albums = read_albums()
    return

def mount_music():
    """ Mounts the music library contained on the server Ajax. """
    import subprocess

    def volumeCheck(volume_name):
        """This function will check volume name is mounted or not.
        """
        #p = subprocess.Popen(['df', '-h'],
        #                     stdout=subprocess.PIPE,
        #                     stderr=subprocess.PIPE)
        #p1, err = p.communicate()
        #return p1.find(volume_name)

        process = subprocess.run(['df','-h'], check=True,
                                 stdout=subprocess.PIPE, universal_newlines=True)
        output = process.stdout
        return output.find(volume_name)

        
    if volumeCheck('ajax-files') != -1:
        # Already mounted
        return
    # Mount music library
    cmd = "sudo mount -t cifs //AJAX/files-rozen %s -o username=rozen,password=pm10mary" % os.path.expanduser('~/ajax-files')
    try:
        os.system(cmd)
    except:
        print ('Mount of AJAX//files-rozen failed.')

def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None

if __name__ == '__main__':
    import rplay
    rplay.vp_start_gui()
